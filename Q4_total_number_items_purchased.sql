--Q4: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?


-- items purchased with ACCEPTED
WITH AcceptedReceipts AS (
    SELECT _id
    FROM RECEIPTS
    WHERE rewardsReceiptStatus = 'ACCEPTED'
),
items purchased with REJECTED
RejectedReceipts AS (
    SELECT _id
    FROM RECEIPTS
    WHERE rewardsReceiptStatus = 'REJECTED'
)
SELECT 
    'Accepted' AS status,
    SUM(purchaseditemcount) AS total_items_purchased
FROM RECEIPTS
WHERE _id IN (SELECT _id FROM AcceptedReceipts)
UNION ALL
SELECT 
    'Rejected' AS status,
    SUM(purchaseditemcount) AS total_items_purchased
FROM RECEIPTS
WHERE _id IN (SELECT _id FROM RejectedReceipts);
