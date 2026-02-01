
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select load_date
from "AwsDataCatalog"."formula_one_raw"."raw_races_json"
where load_date is null



  
  
      
    ) dbt_internal_test