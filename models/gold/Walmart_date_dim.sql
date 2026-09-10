{{
    config
    (
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='date_id'

    )

}}

with date_dim as (
select f.date_id,
f.date,
f.Isholiday,
f.create_date,
f.Insert_date

from {{ ref('int_date') }} f

{% if is_incremental() %}
where f.create_date > (select max(t.Insert_date) from {{this}} t)
{% endif%}
)

select date_id,
date,
Isholiday,
create_date 
from date_dim