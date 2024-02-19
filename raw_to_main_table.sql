-- load the brand main table from raw_brands table

CREATE OR REPLACE Table   brands
as 
select 
 parse_json(_id):"$oid"::string AS _id
,barcode
,brandcode
,category
,categorycode
,parse_json(cpg):"$id":"$oid"::string as cpg
, parse_json(cpg):"$ref" ::string AS ref
,name
,topbrand
, current_timestamp as load_date
from mytestschema.raw_brands c;

------------  load users main table from raw_users table, apply deduplication as idenitical rows are available in raw\source 

CREATE OR REPLACE TABLE USERS 
AS 
select distinct 
    parse_json(_id):"$oid"::string AS _id
,   state
,   to_timestamp_ntz(parse_json(createdDate):"$date"::bigint /1000)  as createDate
,   to_timestamp_ntz(parse_json(lastLogin):"$date"::bigint /1000)  as lastLogin
,   role
,   active
 
from mytestschema.raw_users;
-------- load receipts main table from raw_receipts table,  
create or replace table mytestschema.receipts
as 
select 
    parse_json(_id):"$oid"::string AS _id
,   bonuspointsearned
,   bonuspointsearnedreason
,   to_timestamp_ntz(parse_json(createDate):"$date"::bigint /1000)  as createDate
,   to_timestamp_ntz(parse_json(datescanned):"$date"::bigint /1000)  as datescanned
,   to_timestamp_ntz(parse_json(finisheddate):"$date"::bigint /1000)  as finisheddate
,   to_timestamp_ntz(parse_json(modifydate):"$date"::bigint /1000)  as modifydate 
,   to_timestamp_ntz(parse_json(pointsawardeddate):"$date"::bigint /1000)  as pointsawardeddate
,   pointsearned
,   to_timestamp_ntz(parse_json(purchasedate):"$date"::bigint /1000)  as purchasedate
,   purchaseditemcount
,   rewardsreceiptitemlist 
,   rewardsreceiptstatus
,   totalspent
,   userid
,   current_timestamp as load_date
from mytestschema.raw_receipts; 

--- create bridge table out of rewardreceiptitemlist column of receipt table. also removed duplicates while loading this table.

CREATE OR REPLACE TABLE mytestschema.rewardsreceiptitemlist AS
SELECT distinct 
    parse_json(_id):"$oid"::string AS    receipt_id,
    parse_json(f.value):barcode::string AS barcode,
    parse_json(f.value):finalPrice::float AS finalPrice,
    parse_json(f.value):itemPrice::float AS itemPrice,
    CURRENT_TIMESTAMP AS load_date
FROM 
    mytestschema.raw_receipts r,
    LATERAL FLATTEN(input => parse_json(r.rewardsreceiptitemlist)) f
    WHERE 
    parse_json(value):barcode IS NOT NULL
    AND parse_json(value):finalPrice IS NOT NULL
    AND parse_json(value):itemPrice IS NOT NULL;

