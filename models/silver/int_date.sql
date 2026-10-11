with distinct_items as (
select  distinct  date, isholiday 
from {{ ref('stg_fact') }}
order by date asc
)

select {{ dbt_utils.generate_surrogate_key(['DATE']) }} AS DATE_ID,
*
from distinct_items