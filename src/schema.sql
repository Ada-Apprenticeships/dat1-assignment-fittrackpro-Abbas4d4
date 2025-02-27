-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- 1. locations
-- 2. members
-- 3. staff
-- 4. equipment
-- 5. classes
-- 6. class_schedule
-- 7. memberships
-- 8. attendance
-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal
DROP TABLE locations;
DROP TABLE members;
DROP TABLE staff;
DROP TABLE equipment;
DROP TABLE classes;
DROP TABLE class_schedule;
DROP TABLE memberships;
DROP TABLE attendance;
DROP TABLE class_attendance;
DROP TABLE payments;
DROP TABLE personal_training_sessions;
DROP TABLE member_health_metrics;
DROP TABLE equipment_maintenance_log;

CREATE TABLE locations (
  location_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  address TEXT NOT NULL,
  phone_number VARCHAR(20),
  email VARCHAR(255),
  opening_hours TEXT
);

CREATE TABLE members (
  member_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(255), -- Ensures unique email addresses
  phone_number VARCHAR(20),  
  date_of_birth DATE,
  join_date DATE,
  emergency_contact_name VARCHAR(100),
  emergency_contact_phone VARCHAR(20)
);

CREATE TABLE staff (
  staff_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(255), -- Enforces unique email addresses
  phone_number VARCHAR(20),
  position VARCHAR(255) CHECK (position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),   hire_date DATE,
  location_id INTEGER,
  FOREIGN KEY (location_id) REFERENCES locations(location_id) -- Implements referential integrity
);

CREATE TABLE equipment (
  equipment_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(255) CHECK (type IN ('Cardio', 'Strength')), -- Limits equipment types
  purchase_date DATE,
  last_maintenance_date DATE,
  next_maintenance_date DATE,
  location_id INTEGER,
  FOREIGN KEY (location_id) REFERENCES locations(location_id) -- Implements referential integrity
);

CREATE TABLE classes (
  class_id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT, -- Allows for longer descriptions if needed
  capacity INTEGER,
  duration INTEGER, 
  location_id INTEGER,
  FOREIGN KEY (location_id) REFERENCES locations(location_id) -- Enforces referential integrity
);

CREATE TABLE class_schedule (
  schedule_id INTEGER PRIMARY KEY,
  class_id INTEGER,
  staff_id INTEGER,
  location_id INTEGER,
  start_time DATETIME,
  end_time DATETIME,
  FOREIGN KEY (class_id) REFERENCES classes(class_id),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE memberships (
  membership_id INTEGER PRIMARY KEY,
  member_id INTEGER,
  type VARCHAR(255),
  start_date DATE,
  end_date DATE,
  status VARCHAR(255) CHECK (status IN ('Active', 'Inactive')),
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE attendance (
  attendance_id INTEGER PRIMARY KEY,
  member_id INTEGER,
  location_id INTEGER,
  check_in_time DATETIME,
  check_out_time DATETIME,
  FOREIGN KEY (member_id) REFERENCES members(member_id),
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_attendance (
  class_attendance_id INTEGER PRIMARY KEY,
  schedule_id INTEGER,
  member_id INTEGER,
  attendance_status VARCHAR(255) CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended')),
  FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  member_id INTEGER,
  amount REAL, 
  payment_date DATE,
  payment_method VARCHAR(255),
  payment_type VARCHAR(255),
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions (
  session_id INTEGER PRIMARY KEY,
  member_id INTEGER,
  staff_id INTEGER,
  session_date DATE,
  start_time DATETIME,
  end_time DATETIME,
  notes TEXT,
  FOREIGN KEY (member_id) REFERENCES members(member_id),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics (
  metric_id INTEGER PRIMARY KEY,
  member_id INTEGER,
  measurement_date DATE,
  weight REAL,
  body_fat_percentage REAL,
  muscle_mass REAL,
  bmi REAL,
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE equipment_maintenance_log (
  log_id INTEGER PRIMARY KEY,
  equipment_id INTEGER,
  maintenance_date DATE,
  description TEXT,
  staff_id INTEGER,
  FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

