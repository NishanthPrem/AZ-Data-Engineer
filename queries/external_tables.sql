CREATE DATABASE SCOPED CREDENTIAL nish_credential
WITH IDENTITY = 'Managed Identity';

CREATE EXTERNAL DATA SOURCE source_silver
WITH (
    LOCATION = 'https://nishazdatalake.dfs.core.windows.net/silver/',
    CREDENTIAL = nish_credential
);

CREATE EXTERNAL DATA SOURCE source_gold
WITH (
    LOCATION = 'https://nishazdatalake.dfs.core.windows.net/gold/',
    CREDENTIAL = nish_credential
);

CREATE EXTERNAL FILE FORMAT parquet_format
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);

CREATE EXTERNAL TABLE gold.external_sales
WITH   (
    LOCATION = 'external_sales',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = parquet_format
) AS
 SELECT* FROM gold.sales;
