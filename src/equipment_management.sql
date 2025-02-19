-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)




-- 3.1. Find equipment due for maintenance in the next 30 days
SELECT 
    equipment_id,                -- Select the equipment ID, name, and next maintenance date 
    name,                      
    next_maintenance_date      
FROM equipment                     -- From the "equipment" table.
WHERE next_maintenance_date BETWEEN DATE('now') AND DATE('now', '+30 days'); -- Filter for equipment with a next maintenance date within the next 30 days.

-- 3.2. Count equipment types in stock
SELECT 
    type AS equipment_type,     -- Select the equipment type and alias it as "equipment_type".
    COUNT(*) AS count           -- Count the occurrences of each equipment type and alias it as "count".
FROM equipment                     -- From the "equipment" table.
GROUP BY equipment_type;          -- Group the results by equipment type to count the quantity of each type.

-- 3.3. Calculate average age of equipment by type (in days)
SELECT
    type AS equipment_type,   
    AVG(JULIANDAY('now') - JULIANDAY(purchase_date)) AS avg_age_days -- Calculate the average age of equipment in days by subtracting the purchase date from the current date and alias it as "avg_age_days".
FROM equipment                   
GROUP BY equipment_type;          -- Group the results by equipment type to calculate the average age for each type.
