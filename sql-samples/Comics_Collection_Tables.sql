CREATE TABLE publishers (
		pub_id INTEGER PRIMARY KEY,
		pub_name VARCHAR(30) NOT NULL,
		pub_est DATE NOT NULL
			CHECK (pub_est >= '1934')
		);
CREATE TABLE creators (
		pers_id INTEGER PRIMARY KEY,
		pers_name VARCHAR(30) UNIQUE NOT NULL,
		role VARCHAR(3) NOT NULL
			CHECK (role IN ('W','A','B'))
		);
CREATE TABLE series (
		id INTEGER PRIMARY KEY,
		'name' VARCHAR(30) NOT NULL,
		vol SMALLINT NOT NULL,
		start_date DATE NOT NULL
			CHECK (start_date IS NOT NULL AND start_date BETWEEN '1935-02' AND CURRENT_DATE),
		end_date DATE
			CHECK ((NOT end_date) OR (end_date BETWEEN start_date AND CURRENT_DATE)),
		pub_id NOT NULL,
		'type' VARCHAR(2) NOT NULL
			CHECK ("type" IN ('ON','LT','OS')),
		UNIQUE ("name", vol), 
		FOREIGN KEY (pub_id) REFERENCES publishers (pub_id)
			ON UPDATE CASCADE
			ON DELETE RESTRICT
		);
CREATE TABLE events (
		event_id INTEGER PRIMARY KEY,
		'name' VARCHAR(30) UNIQUE NOT NULL,
		start_date DATE NOT NULL
			CHECK (start_date IS NOT NULL AND start_date BETWEEN '1935-02' AND CURRENT_DATE),
		end_date DATE
			CHECK ((NOT end_date) OR (end_date BETWEEN start_date AND CURRENT_DATE)),
		pub_id NOT NULL,
		FOREIGN KEY (pub_id) REFERENCES publishers (pub_id)
			ON UPDATE CASCADE
			ON DELETE RESTRICT
		);
CREATE TABLE comics (
		item_id INTEGER PRIMARY KEY,
		series_id INTEGER NOT NULL,
		issue INTEGER NOT NULL,
		'type' VARCHAR(3)
			CHECK ((NOT "type") OR ("type" = 'ANN')),
		pub_date DATE NOT NULL,
		writer_id INTEGER NOT NULL,
		artist_id INTEGER NOT NULL,
		notes VARCHAR(50),
		event_id INTEGER,
		event_order INTEGER,
		date_added DATE DEFAULT CURRENT_DATE,
		UNIQUE (series_id, issue, "type"),
		FOREIGN KEY (series_id) REFERENCES series (series_id)
			ON UPDATE CASCADE
			ON DELETE RESTRICT,
		FOREIGN KEY (writer_id) REFERENCES creators (pers_id)
			ON UPDATE CASCADE
			ON DELETE RESTRICT,
		FOREIGN KEY (artist_id) REFERENCES creators (pers_id)
			ON UPDATE CASCADE
			ON DELETE RESTRICT,
		FOREIGN KEY (event_id) REFERENCES events (event_id)
			ON UPDATE CASCADE
			ON DELETE RESTRICT,
		CONSTRAINT event_check CHECK ((NOT event_id) OR (event_order NOT NULL))
		);