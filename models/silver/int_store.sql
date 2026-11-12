with distinct_items as (
select 
distinct d.store, d.dept, s.type, s.size, s.create_time, d.weekly_sales
from {{ ref('stg_department')}} d
left join {{ ref('stg_stores')}} s on d.store=s.store)

select 
--{{ dbt_utils.generate_surrogate_key(['DATE']) }} AS DATE_ID,
    ROW_NUMBER() OVER (ORDER BY store, dept) AS store_ID,
    store,
    dept,
    type,
    size,
    weekly_sales,
    create_time,
    current_timestamp() AS INSERT_DATE
from distinct_items