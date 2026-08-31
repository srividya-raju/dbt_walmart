with distinct_values as (
select distinct date, 
isholiday,
current_timestamp() as Insert_date
from {{ ref('stg_fact') }} f )

select 
{{ dbt_utils.generate_surrogate_key(['date']) }} AS date_id ,
 *
from distinct_values