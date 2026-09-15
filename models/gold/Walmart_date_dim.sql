{{
    config
    (
        materialized='incremental',
        incremental_strategy='append'

    )

}}

with date_dim as (
select f.date_id,
f.date,
f.Isholiday,
f.create_date,
current_timestamp() as Insert_date

from {{ ref('int_date') }} f


)

select date_id,
date,
Isholiday,
create_date,
Insert_date
from date_dim
{% if is_incremental() %}
where create_date > (select max(Insert_date) from {{this}} )
{% endif%}