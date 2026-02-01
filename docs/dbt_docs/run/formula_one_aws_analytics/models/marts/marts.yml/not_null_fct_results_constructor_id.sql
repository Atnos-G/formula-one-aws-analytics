
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select constructor_id
from "AwsDataCatalog"."dbt_marts"."fct_results"
where constructor_id is null



  
  
      
    ) dbt_internal_test