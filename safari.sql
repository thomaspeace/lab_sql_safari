DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;

CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employee_number INT
);

CREATE TABLE enclosures(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closed_for_maintenance BOOLEAN
);

CREATE TABLE assignments(
    id SERIAL PRIMARY KEY,
    day VARCHAR(255),
    employee_id INTEGER REFERENCES staff(id),
    enclosure_id INTEGER REFERENCES enclosures(id)
);

CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INTEGER REFERENCES enclosures(id)
);

INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Big Cat Field', 20, FALSE);
INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Swinging Monkey Enclosure', 10, FALSE);

INSERT INTO staff (name, employee_number) VALUES ('Captain Rik', 12345);
INSERT INTO staff (name, employee_number) VALUES ('Captain Marvel', 23456);

INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Tony', 'Tiger', 59, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Simba', 'Lion', 4, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Mufasa', 'Lion', 35, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Aslan', 'Lion', 52, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Coco Pops', 'Monkey', 15, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Boots', 'Monkey', 10, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Curious George', 'Monkey', 7, 2);

INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Monday', 1, 1);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Tuesday', 1, 2);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Wednesday', 1, 1);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Thursday', 1, 2);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Friday', 1, 1);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Monday', 2, 2);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Tuesday', 2, 1);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Wednesday', 2, 2);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Thursday', 2, 1);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Friday', 2, 2);

SELECT * FROM animals;
SELECT * FROM staff;
SELECT * FROM enclosures;
SELECT * FROM assignments;
