drop database if exists tour_booking_system;
create database tour_booking_system;

use tour_booking_system;

create table accounts (
	id int auto_increment primary key,
	email varchar(255) not null unique,
	account_role enum('ADMIN', 'CUSTOMER') default 'CUSTOMER',
	password varchar(255) not null,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);


create table admins (
	account_id int primary key,
	name varchar(255),
	phone varchar(255) null,
	address varchar(255) null,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

	foreign key (account_id) references accounts (id)
);


create table customers (
	account_id int primary key,
	name varchar(255),
	phone varchar(255) null,
	address varchar(255) null,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

	foreign key (account_id) references accounts (id)
);


create table categories (
	id int auto_increment primary key,
	name varchar(255) not null unique,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);


create table locations (
	id int auto_increment primary key,
	name varchar(255) not null unique,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table packages (
	id int auto_increment primary key,
	code varchar(255) not null unique,
	title varchar(255) not null,
	overview text not null,
	category_id int not null,
	location_id int not null,
	departure_date date not null,
	duration int not null,
	total_tickets int not null,
	remaining_tickets int not null,
	package_status enum('AVAILABLE', 'UNAVAILABLE', 'FINISHED') default 'AVAILABLE',
	unit_price decimal(10, 2) not null,
	admin_id int not null,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

	foreign key (category_id) references categories (id),
	foreign key (location_id) references locations (id),
	foreign key (admin_id) references admins (account_id),

	check (remaining_tickets <= total_tickets)
);

create table bookings (
	id int auto_increment primary key,
	code varchar(255) not null unique,
	package_id int not null,
	customer_id int not null,
	ticket_counts int not null,
	unit_price decimal(10, 2) not null,
	booking_status enum('PENDING', 'REQUESTING', 'RESERVED', 'CANCELLED') default 'PENDING',
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

	foreign key (package_id) references packages (id),
	foreign key (customer_id) references customers (account_id)
);

create table receiving_methods (
	id int auto_increment primary key,
	name varchar(255) not null unique,
	receiving_phone varchar(255) not null,
	owner varchar(255),

	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table payments (
	id int auto_increment primary key,
	code varchar(255) not null unique,
	booking_id int not null,
	payment_status enum('PENDING', 'SUCCESS', 'FAIL') default 'PENDING',
	confirmed_by int null,
	receiving_method_id int not null,

	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

	foreign key (booking_id) references bookings (id),
	foreign key (confirmed_by) references admins (account_id),
	foreign key (receiving_method_id) references receiving_methods (id)
);