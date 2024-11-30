-- create the database
create database kickstarter;


-- indicate which database to use.
use Kickstarter;


-- create a table before importing the data
create table kickstarter_project (
ID int primary key,
Name varchar(2000),
Category varchar(2000),
Main_Category varchar(2000),
Currency varchar(2000),
Deadline DATETIME,
Goal INT,
Launched datetime,
Pledged int,
State varchar(2000),
Backers int,
Country varchar(2000),
USD_pledged int
);

-- run the sql code to make sure your table columns are accurate.
select *
from kickstarter_project;


-- ANALYZING DATA
select
Main_Category, Goal, Backers, Pledged
from kickstarter_project
limit 10;


-- Filtering by category
select
Main_Category, Goal, Backers, Pledged
from kickstarter_project
where State IN ('failed','canceled','suspended')
limit 10;


-- filtering by Quantity
select
Main_Category, Goal, Backers, Pledged
from kickstarter_project
where State IN ('failed','canceled','suspended')
AND Backers >= 100
AND Pledged >= 20000
limit 10;

-- Ordering Results
select
Main_Category, Goal, Backers, Pledged, (Pledged/Goal) AS pct_pledged
from kickstarter_project
where State IN ('failed')
AND Backers >= 100 AND Pledged >= 20000
order by 
	Main_Category ASC,
    pct_pledged DESC
limit 10;


-- Applying Conditional Logic
select
Main_Category, Goal, Backers, Pledged, (Pledged/Goal) AS pct_pledged,
CASE
	when (CAST(Pledged AS decimal) / goal) >= 1 then "Fully funded"
	when (CAST(Pledged AS decimal) / goal) between 0.75 AND 1 then "Nearly funded"
	when (CAST(Pledged AS decimal) / goal) < 0.75 then "Not nearly funded"
	ELSE "Not Applicable"
END AS funding_status
from kickstarter_project
where State IN ('failed')
AND Backers >= 100 AND Pledged >= 20000
order by 
	Main_Category ASC,
    pct_pledged DESC
limit 10;


-- WHAT MAIN CATEFORY WAS SUCCESSFUL IN WHAT COUNRTY
select
Main_Category, Country, Pledged, Backers
from kickstarter_project
limit 10;

-- filtering the results
select
Main_Category, Country, Pledged, Backers
from kickstarter_project
where Country IN ('US', 'GB', 'CA')
AND Pledged >= 20000
AND Backers >= 100
limit 10;

-- ordering based on country
select
Main_Category, Country, Pledged, Backers, (Pledged/Backers) AS Support
from kickstarter_project
where Country IN ('US', 'GB', 'CA')
AND Pledged >= 20000
AND Backers >= 100
Order by 
Main_Category ASC
limit 10;

-- APPLYING CONDITIONAL LOGIC
select
Main_Category, Country, Pledged, Backers, (Pledged/Backers) AS Support,
CASE
	when (CAST(Pledged AS decimal) / Backers) >= 50 then "US"
	when (CAST(Pledged AS decimal) / Backers) between 50 AND 10000 then "GB"
	when (CAST(Pledged AS decimal) / Backers) < 50 then "CA"
	ELSE "Not Applicable"
END AS category_choice
from kickstarter_project
where Country IN ('US', 'GB', 'CA')
AND Pledged >= 20000
AND Backers >= 100
Order by 
Main_Category ASC
limit 10;

-- which category is more successful
-- APPLYING CONDITIONAL LOGIC
select
Category, Main_Category, Country, Pledged, Backers, (Pledged/Backers) AS Support,
CASE
	when (CAST(Pledged AS decimal) / Backers) >= 90 then "Best"
	when (CAST(Pledged AS decimal) / Backers) between 90 AND 300 then "Medium"
	when (CAST(Pledged AS decimal) / Backers) < 90 then "Worse"
	ELSE "Not Applicable"
END AS category_choice
from kickstarter_project
where Country IN ('US', 'GB', 'CA')
AND Pledged >= 20000
AND Backers >= 100
Order by 
Main_Category ASC
limit 50;

-- the ART category is the best category to buy products