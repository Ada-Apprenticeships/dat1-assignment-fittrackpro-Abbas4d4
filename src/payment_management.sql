-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases



-- 2.1. Record a payment for a membership
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type) -- Insert a new payment record into the "payments" table.
VALUES (11, 50.00, DATE('now'), 'Credit Card', 'Monthly membership fee'); -- Provide the member ID, payment amount, current date, payment method, and payment type.

-- 2.2. Calculate total revenue from membership fees for each month of the last year
SELECT
    STRFTIME('%Y-%m', payment_date) AS payment_month, -- Extract the year and month from the payment date and alias it as "payment_month".
    SUM(amount) AS total_revenue                -- Calculate the total revenue for each month and alias it as "total_revenue".
FROM payments                                       -- From the "payments" table.
WHERE payment_date BETWEEN DATE('now', '-1 year') AND DATE('now') -- Filter payments within the last year.
AND payment_type = 'Monthly membership fee'         -- Filter for payments of type "Monthly membership fee".
GROUP BY payment_month;                             -- Group the results by payment month to aggregate revenue for each month.

-- 2.3. Find all day pass purchases
SELECT 
    payment_id,             -- Select the payment ID, payment amount, payment date, payment method
    amount,                
    payment_date,         
    payment_method          
FROM payments                -- From the "payments" table.
WHERE payment_type = 'Day pass'; -- Filter for payments of type "Day pass".
