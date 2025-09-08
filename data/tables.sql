drop database if exists tour_booking_system;
create database tour_booking_system;

use tour_booking_system;

create table accounts (
	id int primary key,
	name varchar(255),
	email varchar(255) not null,
	account_role enum('ADMIN', 'CUSTOMER') default 'CUSTOMER',
	phone varchar(255) null,
	address varchar(255) null,
	password varchar(255) not null,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP
);

create table categories (
	id int primary key,
	name varchar(255) not null unique,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP
);

create table locations (
	id int primary key,
	name varchar(255) not null unique,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP
);

create table packages (
	id int primary key,
	code varchar(255) not null unique,
	title varchar(255) not null,
	overview text not null,
	category_id int not null,
	location_id int not null,
	departure_date date not null,
	duration int not null,
	total_tickets int not null,
	remaining_tickets int,
	unit_price decimal(10, 2) not null,
	account_id int not null,
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP,

	foreign key (category_id) references categories (id),
	foreign key (location_id) references locations (id),
	foreign key (account_id) references accounts (id)
);

create table bookings (
	id int primary key,
	package_id int not null,
	account_id int not null,
	ticket_counts int not null,
	unit_price decimal(10, 2) not null,
	booking_status enum('PENDING', 'REQUESTING', 'RESERVED', 'CANCELLED') default 'PENDING',
	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP,

	foreign key (package_id) references packages (id),
	foreign key (account_id) references accounts (id)
);

	create table payment_types (
		id int primary key,
		name varchar(255) not null unique,
		payment_phone varchar(255) not null,
		created_at datetime default CURRENT_TIMESTAMP,
		updated_at datetime default CURRENT_TIMESTAMP
	);

create table payments (
	id int primary key,
	booking_id int not null,
	status enum('PENDING', 'SUCCESS', 'FAIL') default 'PENDING',
	account_id int null,

	created_at datetime default CURRENT_TIMESTAMP,
	updated_at datetime default CURRENT_TIMESTAMP,

	foreign key (booking_id) references bookings (id),
	foreign key (account_id) references accounts (id)
);