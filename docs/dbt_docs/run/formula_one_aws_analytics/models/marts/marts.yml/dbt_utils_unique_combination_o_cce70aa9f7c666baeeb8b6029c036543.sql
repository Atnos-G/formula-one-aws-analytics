
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        season, round
    from "AwsDataCatalog"."dbt_marts"."ana_qualifying_pole"
    group by season, round
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test