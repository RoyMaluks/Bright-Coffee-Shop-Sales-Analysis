--Coffee Sales Analysis......

------------------------------------------------------------------------------------------------------------------------------
-- check all column names and to check data types
select *
from coffee_table;

------------------------------------------------------------------------------------------------------------------------------
--To check my categorical colums

select distinct product_category
    from coffee_table;
    
------------------------------------------------------------------------------------------------------------------------------
--Operating days
select 
        min(transaction_date) as first_operating_date,
        max(transaction_date) as last_opening_date,
        from coffee_table;

------------------------------------------------------------------------------------------------------------------------------
--Time the shop opens and closes
select 
        min(transaction_time) as opening_time,
        max(transaction_time) as closing_time,
        from coffee_table;
        
------------------------------------------------------------------------------------------------------------------------------

--Final code for Data ingestion.
select transaction_date,
        dayname(transaction_date) as day_name,
        case
            when day_name in ('sun', 'sat') then 'weekend'
            else 'weekday'
            end as day_classification,
        monthname(transaction_date) as month_name,
        
        --transaction_time,
        
        case 
            when transaction_time between '06:00:00' and '11:59:59' then 'Morning'
            when transaction_time between '12:00:00' and '16:59:59' then 'afternoon'
            when transaction_time >= '17:00:00' then 'evening'
        end as time_classification,
            
        hour(transaction_time) as hr_of_day,
        
        -- categorical data
        store_location,
        product_category,
        product_detail,
        product_type,

        --ID's 
        COUNT(distinct transaction_id) as number_of_sales,

        --revenue calc
        sum(transaction_qty*unit_price) as revenue
        
from coffee_table
group by all;

-------------------------------------------------------------------------------------------------------------------------------
   
