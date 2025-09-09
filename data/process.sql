use tour_booking_system;

-- admin functions, procedures and triggers

-- functions
-- function for getting booking count of a package

DELIMITER //

CREATE FUNCTION GetBookingCount(p_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM bookings
    WHERE package_id = p_id;

    RETURN total;
END;
//

DELIMITER ;



-- procedures
-- confriming the payment and updating the booking status

DELIMITER //

CREATE PROCEDURE ConfirmPayment(
    IN paymentId INT,
    IN adminId INT
)
BEGIN
    DECLARE bookingId INT;
    DECLARE currentStatus ENUM('PENDING','SUCCESS','FAIL');

    -- 1. Get current payment info
    SELECT booking_id, payment_status
    INTO bookingId, currentStatus
    FROM payments
    WHERE id = paymentId;

    -- 2. Only proceed if payment is PENDING
    IF currentStatus = 'PENDING' THEN

        -- 3. Update payment status to SUCCESS and record admin who confirmed
        UPDATE payments
        SET payment_status = 'SUCCESS',
            account_id = adminId,
            updated_at = NOW()
        WHERE id = paymentId;

        -- 4. Update related booking status to RESERVED
        UPDATE bookings
        SET booking_status = 'RESERVED',
            updated_at = NOW()
        WHERE id = bookingId;

    ELSE
        -- Optional: raise an error if payment already confirmed or failed
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment is not in PENDING status';
    END IF;
END;
//

DELIMITER ;



-- triggers
-- check if account is admin before inserting
DELIMITER //

CREATE TRIGGER CheckAdminRoleBeforePackage
BEFORE INSERT ON packages
FOR EACH ROW
BEGIN
    DECLARE user_role ENUM('ADMIN','CUSTOMER');

    -- Get the role of the account creating the package
    SELECT account_role INTO user_role
    FROM accounts
    WHERE id = NEW.account_id;

    -- If not an ADMIN, throw an error
    IF user_role <> 'ADMIN' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only admins can create packages!';
    END IF;
END;
//

DELIMITER ;





-- customer functions, procedures and triggers
-- functions
-- calculate the total price of a booking

DELIMITER //

CREATE FUNCTION TotalBookingPriceByBooking(b_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE unit DECIMAL(10,2);
    DECLARE tickets INT;
    DECLARE total DECIMAL(10,2);

    -- Get unit price and ticket count from bookings table
    SELECT unit_price, ticket_counts
    INTO unit, tickets
    FROM bookings
    WHERE id = b_id;

    -- Calculate total price
    SET total = unit * tickets;

    RETURN total;
END;
//

DELIMITER ;



-- procedures
-- update remaining tickets and packages status from packages when a booking is cancelled

DELIMITER //

CREATE PROCEDURE CancelBooking(IN bookingId INT)
BEGIN
    DECLARE pkgId INT;
    DECLARE tickets INT;
    DECLARE current_status ENUM('PENDING','REQUESTING','RESERVED','CANCELLED');
    DECLARE pkg_remaining INT;

    -- 1. Get booking info
    SELECT package_id, ticket_counts, booking_status
    INTO pkgId, tickets, current_status
    FROM bookings
    WHERE id = bookingId;

    -- 2. Only proceed if booking is not already cancelled
    IF current_status <> 'CANCELLED' THEN

        -- 3. Update booking status to CANCELLED
        UPDATE bookings
        SET booking_status = 'CANCELLED', updated_at = NOW()
        WHERE id = bookingId;

        -- 4. Add tickets back to the package
        UPDATE packages
        SET remaining_tickets = remaining_tickets + tickets,
            updated_at = NOW()
        WHERE id = pkgId;

        -- 5. Check and update package status
        SELECT remaining_tickets INTO pkg_remaining
        FROM packages
        WHERE id = pkgId;

        -- If remaining tickets > 0 and departure date in future, set to AVAILABLE
        IF pkg_remaining > 0 THEN
            UPDATE packages
            SET package_status = 'AVAILABLE',
                updated_at = NOW()
            WHERE id = pkgId;
        END IF;

    ELSE
        -- Optional: raise an error if already cancelled
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Booking is already cancelled';
    END IF;
END;
//

DELIMITER ;



-- triggers
-- check if account is customer before inserting
DELIMITER //

CREATE TRIGGER CheckCustomerRoleBeforeBooking
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    DECLARE user_role ENUM('ADMIN','CUSTOMER');

    -- Get the role of the account making the booking
    SELECT account_role INTO user_role
    FROM accounts
    WHERE id = NEW.account_id;

    -- If not a CUSTOMER, throw an error
    IF user_role <> 'CUSTOMER' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only customers can create bookings!';
    END IF;
END;
//

DELIMITER ;
