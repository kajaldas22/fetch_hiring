--1: What are the top 5 brands by receipts scanned for most recent month?

SELECT b.name AS brand_name, COUNT(r._id) AS receipts_scanned
FROM BRANDS b
JOIN rewardsreceiptitemlist rl ON b.barcode = rl.barcode
JOIN RECEIPTS r ON rl.receipt_id = r._id
WHERE date_trunc('month',r.datescanned)='2021-01-01'
--DATEDIFF(month, r.datescanned, CURRENT_DATE) >= '2021-01-01'
GROUP BY b.name
ORDER BY receipts_scanned DESC
LIMIT 5;
