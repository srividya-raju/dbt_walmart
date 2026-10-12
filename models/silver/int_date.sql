with distinct_items as (
select  distinct  date, isholiday, create_time
from {{ ref('stg_fact') }}
WHERE date IS NOT NULL
order by date asc
)

select 
--{{ dbt_utils.generate_surrogate_key(['DATE']) }} AS DATE_ID,
    ROW_NUMBER() OVER (ORDER BY DATE) AS DATE_ID,
    DATE,
    ISHOLIDAY,
    create_time,
    current_timestamp() AS INSERT_DATE
from distinct_items