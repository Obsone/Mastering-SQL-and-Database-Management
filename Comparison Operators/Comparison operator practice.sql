-- How many female customers do we have from the state of Oregon (OR)?
-- Result: 106
SELECT firstname, gender, state FROM "public"."customers"
WHERE state = 'OR' AND gender = 'F';

SELECT age FROM customers
WHERE NOT age = 55 AND NOT age = 47;

-- Who over the age of 44 has an income of 100 000 or more? (excluding 44)
-- Result: 2497
SELECT firstname, age, income FROM customers
WHERE age > 44 AND income >= 100000;

-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)
-- Result: 2362
SELECT firstname, age, income FROM customers
WHERE ( age >= 30 AND age <=50 ) AND income < 50000;

-- What is the average income between the ages of 20 and 50? (Excluding 20 and 50)
-- Result: 59409.926240780098
SELECT avg( income ) FROM customers
WHERE age > 20 AND age <50;

