
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select qualifying_id
from "AwsDataCatalog"."dbt_marts"."fct_qualifying"
where qualifying_id is null



  
  
      
    ) dbt_internal_test