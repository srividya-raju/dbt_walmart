select distinct date, 
isholiday,
current_timestamp() as Insert_date
from {{ ref('stg_fact') }} f