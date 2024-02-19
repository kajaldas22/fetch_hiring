-- create raw table to hold third party source data

CREATE TABLE mytestschema.raw_receipts (
    _id varchar,
    bonusPointsEarned NUMBER,
    bonusPointsEarnedReason VARCHAR(255),
    createDate TIMESTAMP,
    dateScanned TIMESTAMP,
    finishedDate TIMESTAMP,
    modifyDate TIMESTAMP,
    pointsAwardedDate TIMESTAMP,
    pointsEarned NUMBER,
    purchaseDate TIMESTAMP,
    purchasedItemCount INTEGER,
    rewardsReceiptItemList VARIANT, -- Assuming rewardsReceiptItemList is a JSON array
    rewardsReceiptStatus VARCHAR(255),
    totalSpent NUMBER,
    userId VARCHAR(255),
    load_date timestamp
);
 
CREATE or replace TABLE mytestschema.raw_users (
    _id VARCHAR , -- Assuming user Id is a string identifier
    state VARCHAR(2),  
    createdDate TIMESTAMP,
    lastLogin TIMESTAMP,
    role VARCHAR(255) DEFAULT 'CONSUMER', -- Default value set to 'CONSUMER'
    active BOOLEAN, -- Assuming active flag is boolean
    load_date timestamp
);

CREATE or replace  table mytestschema.raw_brands
(
    _id varchar,
    barcode VARCHAR(255), -- Assuming barcode is a string
    brandCode VARCHAR(255),
    category VARCHAR(255),
    categoryCode VARCHAR(255),
    cpg VARCHAR(255), -- Assuming CPG is a string reference
    topBrand BOOLEAN,
    name VARCHAR(255),
     load_date timestamp
);
