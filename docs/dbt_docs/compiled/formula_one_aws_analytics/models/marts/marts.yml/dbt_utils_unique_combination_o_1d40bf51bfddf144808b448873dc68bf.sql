





with validation_errors as (

    select
        season, round, driver_id
    from "AwsDataCatalog"."dbt_marts"."fct_results"
    group by season, round, driver_id
    having count(*) > 1

)

select *
from validation_errors


