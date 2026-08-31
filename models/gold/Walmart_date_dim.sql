{{
    config
    (
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='date_id'

    )

}}

with date_dim as (
f.date_id,
f.date,
f.Isholiday,
{% if is_incremental() %}

    Insert_date,
{% else %}
    current_timestamp() as Insert_date,
{% endif %}

current_timestamp() as Update_date
from {{ ref('int_date') }} f

{% if is_incremental() %}
where Insert_date > (select max(Update_date) from {{this}})
{% endif%}

)

select * from date_dim