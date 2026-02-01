
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pole_driver_id
from "AwsDataCatalog"."dbt_marts"."ana_qualifying_pole"
where pole_driver_id is null



  
  
      
    ) dbt_internal_test