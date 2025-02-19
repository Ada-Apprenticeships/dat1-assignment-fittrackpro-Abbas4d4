-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member





-- 4.1. List all classes with their instructors
SELECT
  c.class_id,                                           -- Select the class ID.
  c.name AS class_name,                                 -- Select the class name and alias it as "class_name".
  s.first_name || ' ' || s.last_name AS instructor_name -- Concatenate the first and last names of the instructor and alias it as "instructor_name".
FROM classes c                                          -- From the "classes" table (aliased as "c").
JOIN class_schedule cs ON c.class_id = cs.class_id     -- Join with the "class_schedule" table (aliased as "cs") on the "class_id" column.
JOIN staff s ON cs.staff_id = s.staff_id;               -- Join with the "staff" table (aliased as "s") on the "staff_id" column. 

-- 4.2. Find available classes for a specific date
SELECT
    c.class_id,                -- Select the class ID, name, start time, end time
    c.name,                   -- Select the class name.
    cs.start_time,             
    cs.end_time,               
    (c.capacity - COUNT(ca.member_id)) AS available_spots -- Calculate the number of available spots by subtracting the count of attending members from the class capacity.
FROM classes c                 
JOIN class_schedule cs ON c.class_id = cs.class_id -- Join with the "class_schedule" table (aliased as "cs") on the "class_id" column.
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id -- Left join with the "class_attendance" table (aliased as "ca") on the "schedule_id" column to include classes with no attendees.
WHERE DATE(cs.start_time) = '2025-02-01' -- Filter results to include classes on specified date.
GROUP BY c.class_id, c.name, cs.start_time, cs.end_time -- Group the results by class ID, name, start time, and end time to count available spots for each class schedule.
HAVING available_spots > 0;          -- Filter the grouped results to include only classes with available spots.

-- 4.3. Register a member for a class
INSERT INTO class_attendance (schedule_id, member_id, attendance_status) -- Insert new row into the "class_attendance" table.
SELECT schedule_id, 11, 'Registered' -- Select the schedule ID, member ID (11), and set the attendance status to 'Registered'.
FROM class_schedule
WHERE class_id = 3 AND DATE(start_time) = '2025-02-01' -- Filter the selection to the specific class (ID 3) on the specified date.
LIMIT 1; -- Limit the insertion to one row, effectively registering the member for one schedule of the class.

-- 4.4. Cancel a class registration
UPDATE class_attendance -- Update the "class_attendance" table.
SET attendance_status = 'Unattended' 
WHERE schedule_id = 7 AND member_id = 2; -- Filter for the specific attendance record based on schedule ID and member ID.

-- 4.5. List top 3 most popular classes
SELECT
    c.class_id,                -- Select the class ID and class name aliased as calss_name
    c.name AS class_name,     
    COUNT(ca.member_id) AS registration_count -- Count the number of registrations for each class and alias it as "registration_count".
FROM classes c                  -- From the "classes" table (aliased as "c").
JOIN class_schedule cs ON c.class_id = cs.class_id -- Join with the "class_schedule" table (aliased as "cs") on the "class_id" column.
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id -- Left join with the "class_attendance" table (aliased as "ca") on the "schedule_id" column to include classes with no attendees.
GROUP BY c.class_id, c.name     -- Group the results by class ID and name to count registrations for each class.
ORDER BY registration_count DESC -- Order the results in descending order based on the registration count.
LIMIT 3;                          -- Limit the results to the top 3 most popular classes.

-- 4.6. Calculate average number of classes per member
SELECT
    CAST(COUNT(DISTINCT schedule_id) AS REAL) / (SELECT COUNT(*) FROM members) AS average_classes_per_member -- Calculate the average number of classes per member by dividing the count of distinct schedule IDs in "class_attendance" by the total number of members.
FROM
    class_attendance;            -- From the "class_attendance" table.