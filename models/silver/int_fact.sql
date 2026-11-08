with distinct_items as (
select 
distinct 
d.store,
d.dept,
d.weekly_sales,
f.fuel_price,
f.temperature,
f.unemployment,
f.cpi,
f.Markdown1,
f.Markdown2,
f.Markdown3,
f.Markdown4,
f.Markdown5,
f.create_time,
dbt_valid_from,
dbt_valid_to
from {{ ref('stg_department')}} d
left join {{ ref('walmart_snapshot')}} f on d.store=f.store)

select 
--{{ dbt_utils.generate_surrogate_key(['DATE']) }} AS DATE_ID,
    ROW_NUMBER() OVER (ORDER BY store, dept) AS store_ID,
    store,
    dept,
    weekly_sales,
fuel_price,
temperature,
unemployment,
cpi,
Markdown1,
Markdown2,
Markdown3,
Markdown4,
Markdown5
    create_time,
    current_timestamp() AS INSERT_DATE
from distinct_items