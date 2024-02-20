--question 1:  What are the top 5 brands by receipts scanned for most recent month?
-- due to current date data is not available, i have no choice to look for available dates. 

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
WHERE date_trunc('month',f.datescanned)<='2020-11-01'
--DATEDIFF(month, f.datescanned, CURRENT_DATE) <= 1
group by 1
order by 2 desc
limit 5
)

-- vs  current month data- 
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
WHERE date_trunc('month',f.datescanned)>='2021-02-01'
-- DATE_TRUNC('MONTH', r.datescanned) = DATE_TRUNC('MONTH', DATEADD('MONTH', -1, CURRENT_DATE))
    
group by 1
order by 2 desc
limit 5
)
