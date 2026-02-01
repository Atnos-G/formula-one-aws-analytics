create or replace view
    "AwsDataCatalog"."dbt_staging"."stg_constructors"
  as
    

with src as (
    select
        payload,
        season as load_season,
        load_date
    from "AwsDataCatalog"."formula_one_raw"."raw_constructors_json"
),

constructors as (
    select
        load_season,
        load_date,
        c
    from src
    cross join unnest(
        cast(json_extract(payload, '$.MRData.ConstructorTable.Constructors') as array(json))
    ) as t(c)
)

select
    json_extract_scalar(c, '$.constructorId')            as constructor_id,
    json_extract_scalar(c, '$.name')                     as constructor_name,
    json_extract_scalar(c, '$.nationality')              as constructor_nationality,
    json_extract_scalar(c, '$.url')                      as constructor_url,

    load_season,
    load_date
from constructors;
