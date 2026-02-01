

with src as (
    select
        driver_id,
        driver_permanent_number,
        driver_code,
        driver_given_name,
        driver_family_name,
        driver_date_of_birth,
        driver_nationality,
        driver_url
    from "AwsDataCatalog"."dbt_staging"."stg_drivers"
),

dedup as (
    select
        *,
        row_number() over (
            partition by driver_id
            order by driver_id
        ) as rn
    from src
)

select
    driver_id,
    driver_permanent_number,
    driver_code,
    driver_given_name,
    driver_family_name,
    driver_date_of_birth,
    driver_nationality,
    driver_url
from dedup
where rn = 1