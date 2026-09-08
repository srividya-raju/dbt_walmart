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
f.create_date,
f.Insert_date

from {{ ref('int_date') }} f

{% if is_incremental() %}
where create_date > (select max(Update_date) from {{this}})
{% endif%}

)

select * from date_dim