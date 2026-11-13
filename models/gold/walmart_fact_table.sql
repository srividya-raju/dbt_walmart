select store,
dept_id,
weekly_sales as store_weekly_sales,
FUEL_PRICE,
TEMPERATURE as store_temperature,
Unemployment,
CPI,
Markdown1,
Markdown2,
Markdown3,
Markdown4,
Markdown5,

from {{ref('int_store')}} s
