USE tour_booking_system;

-- =======================
-- Admin Accounts
-- =======================
INSERT INTO accounts (name, email, password, phone, account_role) VALUES
('admin1', 'admin1@gmail.com', 'password', '09999888777', 'ADMIN'),
('admin2', 'admin2@gmail.com', 'password', '09999888666', 'ADMIN');

-- =======================
-- Customer Accounts
-- =======================
INSERT INTO accounts (name, email, password, phone) VALUES
('Aung Aung', 'aung@gmail.com', 'password', '09777888777'),
('Su Su', 'su@gmail.com', 'password', '09777888666'),
('Moe Moe', 'moe@gmail.com', 'password', '09777888555'),
('Hla Hla', 'hla@gmail.com', 'password', '09777888444');

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
-- Packages (2 per category)
-- =======================
INSERT INTO packages 
(code, title, overview, category_id, location_id, departure_date, duration, total_tickets, remaining_tickets, unit_price, account_id)
VALUES
-- Category 1 (Relaxation)
('PKG-001', 'Adventure in Mountains', 'Explore the majestic mountains with guided tours.', 1, 1, '2025-10-01', 5, 20, 20, 500.00, 1),
('PKG-002', 'Mountain Hiking Challenge', 'A thrilling hiking experience for adventure seekers.', 1, 2, '2025-11-05', 7, 15, 15, 650.00, 1),

-- Category 2 (Pagoda)
('PKG-003', 'Beach Relaxation Getaway', 'Relax on pristine beaches with all-inclusive amenities.', 2, 3, '2025-09-15', 4, 30, 30, 400.00, 1),
('PKG-004', 'Sunset Cruise Escape', 'Enjoy sunset cruises and beach parties.', 2, 4, '2025-10-20', 3, 25, 25, 350.00, 1),

-- Category 3 (Beach)
('PKG-005', 'City Cultural Tour', 'Discover historical landmarks and local culture.', 3, 5, '2025-12-01', 6, 20, 20, 300.00, 1),
('PKG-006', 'Nightlife Exploration', 'Experience the vibrant city nightlife and local cuisine.', 3, 6, '2025-12-10', 5, 15, 15, 320.00, 1),

-- Category 4 (History)
('PKG-007', 'Ancient Pagoda Tour', 'Visit historic pagodas and learn about Burmese history.', 4, 2, '2025-11-12', 4, 25, 25, 450.00, 1),
('PKG-008', 'Historical Yangon Walk', 'A walking tour through Yangon\'s historical sites.', 4, 1, '2025-12-05', 3, 20, 20, 280.00, 1);

-- =======================
-- Bookings (5 random bookings)
-- =======================
INSERT INTO bookings 
(code, package_id, account_id, ticket_counts, unit_price, booking_status)
VALUES
('BOOK-001', 1, 3, 2, 500.00, 'PENDING'),
('BOOK-002', 3, 4, 1, 400.00, 'RESERVED'),
('BOOK-003', 2, 3, 3, 650.00, 'REQUESTING'),
('BOOK-004', 5, 4, 2, 300.00, 'PENDING'),
('BOOK-005', 4, 3, 1, 350.00, 'CANCELLED');

-- =======================
-- Payment Types
-- =======================
INSERT INTO payment_types (name, payment_phone) VALUES
('KBZ Pay', '09990001111'),
('Wave Pay', '09990002222'),
('AYA Pay', '09990003333');

-- =======================
-- Payments (5 sample payments)
-- =======================
INSERT INTO payments 
(code, booking_id, status, account_id, payment_type_id)
VALUES
('PAY-001', 1, 'PENDING', NULL, 1),
('PAY-002', 2, 'SUCCESS', 4, 2),
('PAY-003', 3, 'FAIL', 3, 1),
('PAY-004', 4, 'PENDING', NULL, 3),
('PAY-005', 5, 'SUCCESS', 3, 2);
