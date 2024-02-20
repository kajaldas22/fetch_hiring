--Q5-- Which brand has the most spend among users who were created within the past 6 months?

WITH RecentUsers AS (
    SELECT DISTINCT _id
    FROM USERS
    WHERE CREATEDATE >= '2021-01-01'
),
UserReceipts AS (
    SELECT r._id, r.totalspent, r.userid
    FROM RECEIPTS r
    JOIN RecentUsers u ON r.userid = u._id
)



 select   b.name AS brand_name, b.barcode, SUM(distinct ur.totalspent) AS total_spend
 from UserReceipts ur 
 JOIN rewardsreceiptitemlist rl on rl.receipt_id=ur._id
 join brands b on b.barcode=rl.barcode
 group by b.name,b.barcode
 order by total_spend desc
 limit 1;
