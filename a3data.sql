CREATE OR REPLACE FUNCTION a3data() RETURNS void AS $$
BEGIN

CREATE TABLE IF NOT EXISTS vendor(
	Vno TEXT PRIMARY KEY NOT NULL,
	Vname TEXT,
	City TEXT,
	Vbalance REAL
);

CREATE TABLE IF NOT EXISTS customer(
	Account TEXT PRIMARY KEY NOT NULL,
	Cname TEXT,
	Province TEXT,
	Cbalance REAL,
	Crlimit REAL
);

CREATE TABLE IF NOT EXISTS transaction(
	Tno TEXT PRIMARY KEY NOT NULL,
	Vno TEXT,
	Account TEXT,
	T_Date DATE,
	Amount REAL
);

INSERT INTO vendor VALUES
	('V1','Sears','Toronto',200),
	('V2','WalMart','Waterloo',671.05),
	('V3','Esso','Windsor',0.00),
	('V4','Esso','Waterloo',225.00);

INSERT INTO customer VALUES
	('A1','Smith','ONT',2515.00,2000),
	('A2','Jones','BC',2014.00,2500),
	('A3','Doc','ONT',150.00,1000);

INSERT INTO transaction VALUES
	('T1','V2','A1','2016-07-15',1325),
	('T2','V2','A3','2015-12-16',1900),
	('T3','V3','A1','2016-09-01',2500),
	('T4','V4','A2','2016-03-20',1613),
	('T5','V4','A3','2016-07-31',3312);

END;

$$ LANGUAGE plpgsql;
