
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select season
from "AwsDataCatalog"."formula_one_raw"."raw_races_json"
where season is null



  
  
      
    ) dbt_internal_test