DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;
DROP TABLE staff CASCADE;


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
INSERT INTO enclosures (name, capacity, closed_for_maintenance) VALUES ('Awesome Aquarium', 100, TRUE);

INSERT INTO staff (name, employee_number) VALUES ('Captain Rik', 12345);
INSERT INTO staff (name, employee_number) VALUES ('Captain Marvel', 23456);
INSERT INTO staff (name, employee_number) VALUES ('Diver Dan', 34567);

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
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Monday', 3, 3);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Tuesday', 3, 3);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Wednesday', 3, 3);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Thursday', 3, 3);
INSERT INTO assignments (day, employee_id, enclosure_id) VALUES ('Friday', 3, 3);

-- names of animals in given enclosures
SELECT name FROM animals WHERE enclosure_id = 1;
SELECT name FROM animals WHERE enclosure_id = 2;

-- names of staff in given enclosures on a given day
SELECT staff.name AS employee_name, 
enclosures.name AS enclosure_name, assignments.day FROM staff
INNER JOIN assignments
ON staff.id = assignments.employee_id
INNER JOIN enclosures
ON enclosure_id = enclosures.id
ORDER BY staff.name, assignments.id;

-- names of staff working in enclosures which are closed for maintenance
SELECT DISTINCT staff.name AS employee_in_enclosure_closed_for_maintenance
FROM staff
INNER JOIN assignments
ON staff.id = assignments.employee_id
INNER JOIN enclosures
ON enclosure_id = enclosures.id
WHERE enclosures.closed_for_maintenance = TRUE;

-- name of the enclosure where the oldest animal lives. If there are two animals who are the same age choose the first one alphabetically.
SELECT enclosures.name AS enclosures_name,
animals.name AS animal_name,
animals.age AS animal_age
FROM enclosures
INNER JOIN animals
ON enclosures.id = animals.enclosure_id
ORDER BY animals.age DESC, animals.name DESC 
LIMIT 1;

-- number of different animal types a given keeper has been assigned to work with. 
-- (Diver Dan is 0)
SELECT staff.name,
COUNT(DISTINCT animals.type) 
FROM animals
INNER JOIN enclosures
ON enclosures.id = animals.enclosure_id
INNER JOIN assignments
ON enclosures.id = assignments.enclosure_id
INNER JOIN staff
ON staff.id = assignments.employee_id
GROUP BY staff.name;

-- number of different keepers who have been assigned to work in a given enclosure
SELECT enclosures.name AS enclosure_name,
COUNT(DISTINCT staff.id) AS employee_count
FROM staff
INNER JOIN assignments
ON staff.id = assignments.employee_id
INNER JOIN enclosures
ON enclosure_id = enclosures.id
GROUP BY enclosures.name;

-- names of the other animals sharing an enclosure with Tony
SELECT animals.name AS animal_name,
enclosures.name AS enclosure_name
FROM animals
INNER JOIN enclosures
ON enclosures.id = animals.enclosure_id
WHERE enclosures.id = (SELECT enclosure_id FROM animals WHERE name = 'Tony')
AND NOT animals.name = 'Tony';

-- names of the other animals sharing an enclosure with Boots
SELECT animals.name AS animal_name,
enclosures.name AS enclosure_name
FROM animals
INNER JOIN enclosures
ON enclosures.id = animals.enclosure_id
WHERE enclosures.id = (SELECT enclosure_id FROM animals WHERE name = 'Boots')
AND NOT animals.name = 'Boots';
