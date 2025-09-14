USE tour_booking_system;

-- =======================
-- Admin Accounts + Admin Details
-- =======================
INSERT INTO accounts (email, password, account_role) VALUES
('admin1@gmail.com', 'password', 'ADMIN'),
('admin2@gmail.com', 'password', 'ADMIN');

INSERT INTO admins (account_id, name, phone, address) VALUES
(1, 'admin1', '09999888777', 'Yangon'),
(2, 'admin2', '09999888666', 'Mandalay');

-- =======================
-- Customer Accounts + Customer Details
-- =======================
INSERT INTO accounts (email, password, account_role) VALUES
('aung@gmail.com', 'password', 'CUSTOMER'),
('su@gmail.com', 'password', 'CUSTOMER'),
('moe@gmail.com', 'password', 'CUSTOMER'),
('hla@gmail.com', 'password', 'CUSTOMER');

INSERT INTO customers (account_id, name, phone, address) VALUES
(3, 'Aung Aung', '09777888777', 'Yangon'),
(4, 'Su Su', '09777888666', 'Mandalay'),
(5, 'Moe Moe', '09777888555', 'Bagan'),
(6, 'Hla Hla', '09777888444', 'Inle Lake');

-- =======================
-- Categories
-- =======================
INSERT INTO categories (name) VALUES
('Relaxation'),
('Pagoda'),
('Beach'),
('History');

-- =======================
-- Locations
-- =======================
INSERT INTO locations (name) VALUES
('Yangon'),
('Bagan'),
('Chaung Tha'),
('Mandalay'),
('Naypyitaw'),
('Inle Lake');

-- =======================
-- Packages
-- =======================
INSERT INTO packages 
(code, title, overview, category_id, location_id, departure_date, duration, total_tickets, remaining_tickets, unit_price, admin_id, package_status)
VALUES
-- Category 1 (Relaxation)
('PKG-001', 'Adventure in Mountains', 'Explore the majestic mountains with guided tours.', 1, 1, '2025-10-01', 5, 20, 18, 500.00, 1, 'AVAILABLE'),
('PKG-002', 'Mountain Hiking Challenge', 'A thrilling hiking experience for adventure seekers.', 1, 2, '2025-11-05', 7, 15, 12, 650.00, 1, 'AVAILABLE'),

-- Category 2 (Pagoda)
('PKG-003', 'Beach Relaxation Getaway', 'Relax on pristine beaches with all-inclusive amenities.', 2, 3, '2025-09-15', 4, 30, 29, 400.00, 1, 'AVAILABLE'),
('PKG-004', 'Sunset Cruise Escape', 'Enjoy sunset cruises and beach parties.', 2, 4, '2025-10-20', 3, 25, 24, 350.00, 1, 'AVAILABLE'),

-- Category 3 (Beach)
('PKG-005', 'City Cultural Tour', 'Discover historical landmarks and local culture.', 3, 5, '2025-12-01', 6, 20, 18, 300.00, 1, 'AVAILABLE'),
('PKG-006', 'Nightlife Exploration', 'Experience the vibrant city nightlife and local cuisine.', 3, 6, '2025-12-10', 5, 15, 15, 320.00, 1, 'AVAILABLE'),

-- Category 4 (History)
('PKG-007', 'Ancient Pagoda Tour', 'Visit historic pagodas and learn about Burmese history.', 4, 2, '2025-11-12', 4, 25, 25, 450.00, 1, 'AVAILABLE'),
('PKG-008', 'Historical Yangon Walk', 'A walking tour through Yangon''s historical sites.', 4, 1, '2025-12-05', 3, 20, 20, 280.00, 1, 'AVAILABLE'),

-- Extra Package: UNAVAILABLE
('PKG-009', 'Hidden Lakes Adventure', 'A secret journey to hidden lakes with full bookings.', 1, 6, '2025-11-20', 3, 10, 0, 600.00, 1, 'UNAVAILABLE'),

-- Extra Package: FINISHED
('PKG-010', 'Old Kingdom Exploration', 'Historic kingdom tour, already departed.', 4, 2, '2025-08-01', 4, 12, 5, 700.00, 1, 'FINISHED');

-- =======================
-- Bookings
-- =======================
INSERT INTO bookings 
(code, package_id, customer_id, ticket_counts, unit_price, booking_status)
VALUES
('BOOK-001', 1, 3, 2, 500.00, 'PENDING'),
('BOOK-002', 3, 4, 1, 400.00, 'RESERVED'),
('BOOK-003', 2, 3, 3, 650.00, 'REQUESTING'),
('BOOK-004', 5, 4, 2, 300.00, 'PENDING'),
('BOOK-005', 4, 3, 1, 350.00, 'CANCELLED');

-- =======================
-- Receiving Methods (with owner)
-- =======================
INSERT INTO receiving_methods (name, receiving_phone, owner) VALUES
('KBZ Pay', '09990001111', 'Admin1'),
('Wave Pay', '09990002222', 'Admin1'),
('AYA Pay', '09990003333', 'Admin2');

-- =======================
-- Payments
-- =======================
INSERT INTO payments 
(code, booking_id, payment_status, confirmed_by, receiving_method_id)
VALUES
('PAY-001', 1, 'PENDING', NULL, 1),
('PAY-002', 2, 'SUCCESS', 1, 2), -- admin1 confirmed
('PAY-003', 3, 'FAIL', 2, 1),    -- admin2 handled
('PAY-004', 4, 'PENDING', NULL, 3),
('PAY-005', 5, 'SUCCESS', 1, 2); -- admin1 confirmed
