-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class



-- 1.1. Retrieve all members
SELECT 
    member_id,            -- Select the member ID. And the members first name, last name, email address, and join date
    first_name,           
    last_name,            
    email,            
    join_date            
FROM members;                -- From the "members" table.

-- 1.2. Update a member's contact information
UPDATE members                -- Update the "members" table.
SET phone_number = '555-9876', -- Set the phone number to '555-9876'.
email = 'emily.jones.updated@email.com' -- Set the email address to 'emily.jones.updated@email.com'.
WHERE member_id = 5;           -- Filter for the member with an ID of 5.

-- 1.3. Count total number of members
SELECT 
    COUNT(*) AS total_members -- Count all rows in the "members" table and alias it as "total_members".
FROM members;                -- From the "members" table.

-- 1.4. Find member with the most class registrations
SELECT 
    m.member_id,              -- Select the member ID. And members first name, last name, and number of class registations for the member 
    m.first_name,            
    m.last_name,              
    COUNT(ca.member_id) AS registration_count -- Number of class registrations for the member alisased as "registration_count".
FROM members m                  -- From the "members" table (aliased as "m").
JOIN class_attendance ca ON m.member_id = ca.member_id -- Join with the "class_attendance" table (aliased as "ca") on the "member_id" column.
GROUP BY m.member_id, m.first_name, m.last_name -- Group the results by member ID, first name, and last name to count registrations for each member.
ORDER BY registration_count DESC -- Order the results in descending order based on the registration count.
LIMIT 1;                          -- Limit the results to the member with the highest registration count.

-- 1.5. Find member with the least class registrations
SELECT 
    m.member_id,              -- Select the member ID, first name, last name, and number of class registrations for the member
    m.first_name,             
    m.last_name,              
    COUNT(ca.member_id) AS registration_count -- number of class registrations for the member alisased "registration_count".
FROM members m                  -- From the "members" table (aliased as "m").
LEFT JOIN class_attendance ca ON m.member_id = ca.member_id -- Left join with the "class_attendance" table (aliased as "ca") on the "member_id" column to include members with no registrations.
GROUP BY m.member_id, m.first_name, m.last_name -- Group the results by member ID, first name, and last name to count registrations for each member.
ORDER BY registration_count ASC -- Order the results in ascending order based on the registration count.
LIMIT 1;                          -- Limit the results to the member with the lowest registration count.

-- 1.6. Calculate the percentage of members who have attended at least one class
SELECT 
    CAST(COUNT(DISTINCT T1.member_id) AS REAL) * 100 / (SELECT COUNT(*) FROM members) AS percentage_attended -- Calculate the percentage of members who have attended at least one class.
FROM class_attendance AS T1     -- From the "class_attendance" table (aliased as "T1").
WHERE T1.attendance_status = 'Attended'; -- Filter for attendance records where the status is "Attended".