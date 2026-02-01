
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select driver_id
from "AwsDataCatalog"."dbt_marts"."fct_results"
where driver_id is null



  
  
      
    ) dbt_internal_test