-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer



-- 8.1. List all personal training sessions for specific trainer "Ivy Irwin"
SELECT
    pts.session_id,                -- Select the personal training session ID.
    m.first_name || ' ' || m.last_name AS member_name, -- Concatenate the member's first and last names and alias it as "member_name".
    pts.session_date,              -- Select the session date.
    pts.start_time,                -- Select the session start time.
    pts.end_time                  -- Select the session end time.
FROM personal_training_sessions pts -- From the "personal_training_sessions" table (aliased as "pts").
JOIN staff s ON pts.staff_id = s.staff_id     -- Join with the "staff" table (aliased as "s") on the "staff_id" column.
JOIN members m ON pts.member_id = m.member_id   -- Join with the "members" table (aliased as "m") on the "member_id" column.
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin'; -- Filter for sessions conducted by the trainer with the first name "Ivy" and last name "Irwin".