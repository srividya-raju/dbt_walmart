with distinct_values as (
select distinct date, 
isholiday,
create_date
from {{ ref('stg_fact') }} f )

select 
{{ dbt_utils.generate_surrogate_key(['date']) }} AS date_id ,
 *
from distinct_values