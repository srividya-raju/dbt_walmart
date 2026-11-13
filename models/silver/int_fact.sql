select f.store as store_id,
s.dept as dept_id,
weekly_sales as store_weekly_sales,
fuel_price,
temperature as store_temperature,
unemployment,
CPI,
markdown1,
markdown2,
markdown3,
markdown4,
markdown5,
f.create_time as insert_date,
dbt_updated_at as update_date,
dbt_valid_from as vrsn_start_date,
dbt_valid_to as vrsn_end_date
from {{ref('fact_snapshot')}} f
join {{ref('int_store')}} s on f.store=s.store 