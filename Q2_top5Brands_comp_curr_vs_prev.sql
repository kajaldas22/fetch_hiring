--question 1:  What are the top 5 brands by receipts scanned for most recent month?
-- due to current date data is not available, i have no choice to look for available dates. 

-- previous vs current month by rank comparsion.
with previousMonthRnk as (
select 
    b.name as brand_name
,   count(*) as cnt
,   row_number() over(order by count(f._id) desc) as previous_mth_rnk
from 
        mytestschema.receipts f
join    mytestschema.rewardsreceiptitemlist r1
  on    f._id=r1.receipt_id
join    mytestschema.brands b
  on    r1.barcode=b.barcode
WHERE date_trunc('month',f.datescanned) between'2020-10-01' and '2020-11-01'
--DATEDIFF(month, f.datescanned, CURRENT_DATE) <= 1
group by 1
order by 2 desc
limit 5
)

-- vs  current month
, currentMonthRnk as (
 select 
    b.name as brand_name
,   count(*) as cnt
,   row_number() over(order by count(f._id) desc) as current_mth_rnk
from 
        mytestschema.receipts f
join    mytestschema.rewardsreceiptitemlist r1
  on    f._id=r1.receipt_id
join    mytestschema.brands b
  on    r1.barcode=b.barcode
WHERE date_trunc('month',f.datescanned)>='2021-01-01'
-- DATE_TRUNC('MONTH', r.datescanned) = DATE_TRUNC('MONTH', DATEADD('MONTH', -1, CURRENT_DATE))
    
group by 1
order by 2 desc
limit 5
)


SELECT 'Current Month' AS month,
       brand_name,
       cnt,
       current_mth_rnk
FROM currentMonthRnk
UNION ALL
SELECT 'Previous Month' AS month,
       brand_name,
       cnt,
       previous_mth_rnk
FROM previousMonthRnk;
ORDER BY month, current_mth_rnk;
