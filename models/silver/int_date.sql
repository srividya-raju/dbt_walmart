select distinct date, 
isholiday 
from {{ ref('stg_fact') }} f