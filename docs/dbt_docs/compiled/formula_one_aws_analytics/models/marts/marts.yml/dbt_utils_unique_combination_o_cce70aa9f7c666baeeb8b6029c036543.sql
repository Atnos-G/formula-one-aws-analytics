





with validation_errors as (

    select
        season, round
    from "AwsDataCatalog"."dbt_marts"."ana_qualifying_pole"
    group by season, round
    having count(*) > 1

)

select *
from validation_errors


