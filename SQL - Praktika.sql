DROP TABLE IF EXISTS software CASCADE;
CREATE TABLE software (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	software_name VARCHAR(20)
);

create type request_state as enum ('discovered', 'resolved');
create type request_state2 as enum ('high', 'normal', 'low');
create type request_state3 as enum ('functional', 'visual', 'orthography');
create type request_state4 as enum('in progress', 'for review', 'resolved');
create type request_state7 as enum ('design', 'logic');

DROP TABLE IF EXISTS version1 CASCADE;
CREATE TABLE version1 (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk_software INT,
	version_index VARCHAR(20),
	data_release timestamp without time zone,
	CONSTRAINT fk_software
	FOREIGN KEY(fk_software)
	REFERENCES software(ID)
);

INSERT INTO software
(software_name)
VALUES
('Word'),
('Photoshop'),
('Chrome');
SELECT * FROM software;

INSERT INTO version1
(fk_software, version_index, data_release)
VALUES
(3, '513422', '2022-06-16 16:37:23'),
(1, '613523', '2023-02-25 19:25:41'),
(2, '352461', '2022-09-20 10:05:52');
SELECT * FROM version1;

DROP TABLE IF EXISTS bug CASCADE;
CREATE TABLE bug (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	criticality request_state2,
	bug_type request_state3,
	status1 request_state4,
	description TEXT
);

INSERT INTO bug 
(criticality, bug_type, status1, description)
VALUES
('normal', 'visual', 'in progress', 'text is not visible'),
('high', 'functional', 'resolved', 'the application does not start'),
('low','orthography', 'for review', 'a letter is missing in the page title');
SELECT * FROM bug;

DROP TABLE IF EXISTS version_bug CASCADE;
CREATE TABLE version_bug(
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk_version1 INT,
	fk_bug INT,
	data_correction timestamp without time zone,
	data_discovery timestamp without time zone,
	status request_state,
	CONSTRAINT fk_bug
	FOREIGN KEY(fk_bug)
	REFERENCES bug(ID),
    CONSTRAINT fk_version1
	FOREIGN KEY(fk_version1)
	REFERENCES version1(ID)
);

INSERT INTO version_bug
(fk_version1, fk_bug, data_correction, data_discovery, status)
VALUES
(1, 1, '2022-09-21 15:45:37', '2022-07-14 13:15:47', 'resolved'),
(2, 2, '2022-12-17 20:38:45', '2022-11-25 21:32:47', 'discovered'),
(3, 3, '2022-01-18 11:32:44', '2022-01-03 19:55:31', 'resolved');
SELECT * FROM version_bug;

DROP TABLE IF EXISTS changes CASCADE;
CREATE TABLE changes (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	author VARCHAR(25),
	data_introduction timestamp without time zone,
	functionallity_type request_state7,
	desription TEXT,
	fk_version1 INT,
	CONSTRAINT fk_version1
	FOREIGN KEY (fk_version1)
	REFERENCES version1(ID)
);

INSERT INTO changes 
(author, data_introduction, functionallity_type, desription, fk_version1)
VALUES
('Kate Watson', '2022-09-21 15:45:37', 'design', 'Text colors have become brighter and no longer blend into the background.', 1),
('David Paul', '2023-01-25 17:29:55', 'logic', 'Fixed a bug with app startup', 2),
('Kate Watson', '2022-01-18 11:32:44', 'design', 'Fixed a bug in the page title', 3);
SELECT * FROM changes;









