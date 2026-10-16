-- Buat tabel Hotel dengan fitur Integrity Enhancement Feature
CREATE TABLE Hotel(
hotelNo CHAR(4) NOT NULL,
hotelName VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
PRIMARY KEY (hotelNo)
);

-- Buat tabel Room, Booking, dan Guest
-- a. type harus single, double, atau family
CREATE DOMAIN RoomType AS VARCHAR(6)
CHECK (VALUE IN('Single', 'Double', 'Family'));

--b. price antara 10 dan 100
CREATE DOMAIN RoomPrice AS DECIMAL(5,2)
CHECK (VALUE BETWEEN 10 AND 100);

-- C. roomNo antara 1 dan 100
CREATE DOMAIN RoomNumber AS SMALLINT
CHECK (VALUE BETWEEN 1 AND 100);

CREATE TABLE Room(
roomNo RoomNumber NOT NULL,
hotelNo CHAR(4) NOT NULL,
type RoomType NOT NULL DEFAULT 'Single',
price RoomPrice NOT NULL,
PRIMARY KEY (roomNo, hotelNo),
FOREIGN KEY (hotelNo) REFERENCES Hotel(hotelNo)
ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel guest
CREATE TABLE Guest(
guestNo CHAR(5) NOT NULL,
guestName VARCHAR(40) NOT NULL,
guestAddress VARCHAR(80),
PRIMARY KEY (guestNo)
);

-- Tabel Booking
CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE TABLE Booking(
hotelNo CHAR(4) NOT NULL,
guestNo CHAR(5) NOT NULL,
dateFrom DATE NOT NULL,
dateTo DATE NOT NULL,
roomNo RoomNumber NOT NULL,
PRIMARY KEY (hotelNo, guestNo, dateFrom),
FOREIGN KEY (hotelNo) references Hotel(hotelNo)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (guestNo) REFERENCES Guest(guestNo)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (roomNo, hotelNo) REFERENCES Room(roomNo,hotelNo)
ON UPDATE CASCADE ON DELETE CASCADE,

-- d. Tanggal ahrus lebih besar dair hari ini
CONSTRAINT chk_dateFrom_future CHECK (dateFrom > CURRENT_DATE),
CONSTRAINT chk_dateTo_future CHECK (dateTo > CURRENT_DATE),
CONSTRAINT chk_date_order CHECK (dateTo > dateFrom),

-- e. kamar yang sama tidak boleh double booked
CONSTRAINT no_room_double_booking
EXCLUDE USING gist(
hotelNo WITH =,
roomNo WITH =,
daterange(dateFrom, dateTo, '[)') WITH &&),

-- f. tamu yang sama tidak boleh punya booking yang overlap
CONSTRAINT no_guest_obverlap
EXCLUDE USING gist(
guestNo WITH =,
daterange(dateFrom, dateTo, '[)') WITH &&
)

);