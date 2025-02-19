-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year



-- 5.1. List all active memberships with member details
SELECT
    m.member_id,              -- Select the member ID. And the members first name, last name, join date, membership type (Aliased as 'membership type')
    m.first_name,             
    m.last_name,             
    ms.type AS membership_type, 
    m.join_date             
FROM members m                  -- From the "members" table (aliased as "m").
JOIN memberships ms ON m.member_id = ms.member_id -- Join with the "memberships" table (aliased as "ms") on the "member_id" column.
WHERE ms.status = 'Active';     -- Filter for memberships with an "Active" status.

-- 5.2. Calculate the average duration of gym visits for each membership type
SELECT
    ms.type AS membership_type,                -- Select the membership type and alias it as "membership_type".
    AVG(JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 24 * 60 AS avg_visit_duration_minutes -- Calculate the average visit duration in minutes for each membership type and alias it as "avg_visit_duration_minutes".
FROM memberships ms                           -- From the "memberships" table (aliased as "ms").
JOIN members m ON ms.member_id = m.member_id      -- Join with the "members" table (aliased as "m") on the "member_id" column.
JOIN attendance a ON m.member_id = a.member_id      -- Join with the "attendance" table (aliased as "a") on the "member_id" column.
GROUP BY ms.type;                              -- Group the results by membership type to calculate the average duration for each type.

-- 5.3. Identify members with expiring memberships this year
SELECT
    m.member_id,              -- Select the member ID. And the members first name, lasnt name, email address, membership end date
    m.first_name,             
    m.last_name,              
    m.email,                 
    ms.end_date               
FROM members m                  -- From the "members" table (aliased as "m").
JOIN memberships ms ON m.member_id = ms.member_id -- Join with the "memberships" table (aliased as "ms") on the "member_id" column.
WHERE STRFTIME('%Y', ms.end_date) = STRFTIME('%Y', 'now'); -- Filter for memberships that expire in the current year. 