
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pole_constructor_id
from "AwsDataCatalog"."dbt_marts"."ana_qualifying_pole"
where pole_constructor_id is null



  
  
      
    ) dbt_internal_test