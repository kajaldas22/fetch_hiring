--Q6--Which brand has the most transactions among users who were created within the past 6 months?


WITH RecentUsers AS (
    SELECT distinct _id
    FROM USERS
    WHERE CREATEDATE >= '2021-01-01'
),
UserReceipts AS (
    SELECT r._id, r.userid,r.datescanned
    FROM RECEIPTS r
    JOIN RecentUsers u ON r.userid = u._id
)

 select   b.name AS brand_name, b.barcode, count(distinct rl.receipt_id) trx_count
 from UserReceipts ur 
 JOIN rewardsreceiptitemlist rl on rl.receipt_id=ur._id
 join brands b on b.barcode=rl.barcode
 group by b.name,b.barcode
 order by trx_count desc
 limit 1;
