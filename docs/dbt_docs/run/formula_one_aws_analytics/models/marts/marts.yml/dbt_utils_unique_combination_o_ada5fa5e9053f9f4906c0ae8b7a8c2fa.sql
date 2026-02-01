
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        season, round, driver_id
    from "AwsDataCatalog"."dbt_marts"."fct_qualifying"
    group by season, round, driver_id
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test