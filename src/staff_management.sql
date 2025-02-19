-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days



-- 7.1. List all staff members by role
SELECT
    staff_id,                -- Select the staff ID. And the staff members first name, last name, and position (aliased as 'role')
    first_name,               
    last_name,             
    position AS role           
FROM
    staff                     -- From the "staff" table.
ORDER BY
    role;                      -- Order the results by role in ascending order.

-- 7.2 Find trainers with one or more personal training session in the next 30 days
SELECT
    s.staff_id AS trainer_id,       -- Select the staff ID and alias it as "trainer_id".
    s.first_name || ' ' || s.last_name AS trainer_name, -- Concatenate the trainer's first and last names and alias it as "trainer_name".
    COUNT(pts.session_id) AS session_count -- Count the number of personal training sessions for each trainer and alias it as "session_count".
FROM staff s                          -- From the "staff" table (aliased as "s").
LEFT JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id -- Left join with the "personal_training_sessions" table (aliased as "pts") on the "staff_id" column.
WHERE s.position = 'Trainer'           -- Filter for staff members with the position "Trainer".
AND pts.session_date BETWEEN DATE('now') AND DATE('now', '+30 days') -- Filter for sessions scheduled within the next 30 days.
GROUP BY trainer_id, trainer_name     -- Group the results by trainer ID and name to count sessions for each trainer.
HAVING COUNT(pts.session_id) > 0;      -- Filter the grouped results to include only trainers with at least one session in the next 30 days.