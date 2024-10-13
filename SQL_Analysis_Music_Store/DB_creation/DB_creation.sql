CREATE DATABASE Music_store;
USE Music_store;



CREATE TABLE Artist (
	artist_id INT PRIMARY KEY NOT NULL,
	artist_name NVARCHAR(255)
);

CREATE TABLE Playlist (
	playlist_id INT PRIMARY KEY NOT NULL,
	playlist_name NVARCHAR(255)
);

CREATE TABLE PlaylistTrack (
	playlist_id INT,
	track_id INT
);

CREATE TABLE Album (
	album_id INT PRIMARY KEY NOT NULL,
	title NVARCHAR(255),
	artist_id INT
);

CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY NOT NULL,
	media_type_name NVARCHAR(255)
);

CREATE TABLE Genre (
	genre_id INT PRIMARY KEY NOT NULL,
	genre_name NVARCHAR(255)
);

CREATE TABLE Track (
	track_id INT PRIMARY KEY NOT NULL,
	track_name NVARCHAR(255),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer NVARCHAR(255),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL (10, 2)
);

CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY NOT NULL,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL (10, 2),
	quantity INT
);

CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY NOT NULL,
	customer_id INT,
	invoice_date DATE,
	billing_address NVARCHAR(255),
	billing_city NVARCHAR(255),
	billing_state NVARCHAR(255),
	billing_country NVARCHAR(255),
	billing_postal_code NVARCHAR(255),
	total DECIMAL (10, 2)
);

CREATE TABLE Customer (
	customer_id INT PRIMARY KEY NOT NULL,
	first_name NVARCHAR(255),
	last_name NVARCHAR(255),
	company NVARCHAR(255),
	customer_address NVARCHAR(255),
	city NVARCHAR(255),
	customer_state NVARCHAR(255),
	country NVARCHAR(255),
	postal_code NVARCHAR(255),
	phone NVARCHAR(255),
	fax NVARCHAR(255),
	email NVARCHAR(255),
	support_rep_id INT
);

CREATE TABLE Employee (
	employee_id INT PRIMARY KEY NOT NULL,
	last_name NVARCHAR(255),
	first_name NVARCHAR(255),
	title NVARCHAR(255),
	reports_to NVARCHAR(255),
	levels NVARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	employee_address NVARCHAR(255),
	city NVARCHAR(255),
	employee_state NVARCHAR(255),
	country NVARCHAR(255),
	postal_code NVARCHAR(255),
	phone NVARCHAR(255),
	fax NVARCHAR(255),
	email NVARCHAR(255)
);



ALTER TABLE Album
ADD CONSTRAINT FK_Album_Artist
FOREIGN KEY (artist_id) REFERENCES Artist (artist_id);

ALTER TABLE PlaylistTrack
ADD CONSTRAINT FK_PlaylistTrack_Playlist
FOREIGN KEY (playlist_id) REFERENCES Playlist (playlist_id);

ALTER TABLE PlaylistTrack
ADD CONSTRAINT FK_PlaylistTrack_Track
FOREIGN KEY (track_id) REFERENCES Track (track_id);

ALTER TABLE Track
ADD CONSTRAINT FK_Track_Album
FOREIGN KEY (album_id) REFERENCES Album (album_id);

ALTER TABLE Track
ADD CONSTRAINT FK_Track_MediaType
FOREIGN KEY (media_type_id) REFERENCES MediaType (media_type_id);

ALTER TABLE Track
ADD CONSTRAINT FK_Track_Genre
FOREIGN KEY (genre_id) REFERENCES Genre (genre_id);

ALTER TABLE InvoiceLine
ADD CONSTRAINT FK_InvoiceLine_Track
FOREIGN KEY (track_id) REFERENCES Track (track_id);

ALTER TABLE InvoiceLine
ADD CONSTRAINT fk_InvoiceLine_Invoice 
FOREIGN KEY (invoice_id) REFERENCES Invoice (invoice_id);

ALTER TABLE Invoice
ADD CONSTRAINT FK_Invoice_Customer
FOREIGN KEY (customer_id) REFERENCES Customer (customer_id);

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Employee
FOREIGN KEY (support_rep_id) REFERENCES Employee (employee_id);