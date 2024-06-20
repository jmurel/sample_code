INSERT INTO publishers (pub_name,pub_est)
	VALUES
		('DC','1937'),
		('Marvel','1961'),
		('Dark Horse','1986');
INSERT INTO creators (pers_name,role)
	VALUES
		('Siegel, Jerry','W'),
		('Schuster, Joe','A'),
		('Kane, Bob','B'),
		('Finger, Bill','W'),
		('Marston, William Moulton','W'),
		('Peter, Harry George','A'),
		('Lee, Stan','W'),
		('Ditko, Steve','B'),
		('Kirby, Jack','B'),
		('Eisner, Will','B'),
		('Moore, Alan','W'),
		('McFarlane, Todd','B');
INSERT INTO series ('name',vol,start_date,pub_id,'type')
	VALUES
		('Action Comics','1','1938-06','1','ON'),
		('Detective Comics','1','1937-03','1','ON'),
		('All-Star Comics','1','1940-06','1','ON'),
		('Sensation Comics','1','1942-01','1','ON'),
		('Amazing Fantasy','1','1962-08','2','ON');