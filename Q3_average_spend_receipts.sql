--Q3- avaerage spent from receipt with rewardsReceiptStatus



-- Calculate average spend for receipts with  'Accepted'
WITH AcceptedReceipts AS (
    SELECT totalspent
    FROM RECEIPTS
    WHERE rewardsreceiptstatus = 'ACCEPTED'
),
-- Calculate average spend for receipts with   'Rejected'
RejectedReceipts AS (
    SELECT totalspent
    FROM RECEIPTS
    WHERE rewardsreceiptstatus = 'REJECTED'
)
--  average spend for each status
SELECT 
    'Accepted' AS status,
    AVG(totalspent) AS average_spend
FROM AcceptedReceipts
UNION ALL
SELECT 
    'Rejected' AS status,
    AVG(totalspent) AS average_spend
FROM RejectedReceipts;
