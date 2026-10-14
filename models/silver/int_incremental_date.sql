{{
    config(
        materialized='incremental',
        incremental_strategy = 'delete+insert',
        unique_key='date_id'
    )
}}

with src as (

    select
        f.date_id,
        f.date,
        f.isholiday,
        f.create_time,
        f.insert_date
    from {{ ref('int_date') }} f

    -- one row per date_id: keep the latest version
    qualify row_number() over (
        partition by f.date,
        f.isholiday
        order by f.create_time desc
    ) = 1

),

final as (

    select
        s.date_id,
        s.date,
        s.isholiday,
        s.insert_date,
        s.create_time
    from src s

    {% if is_incremental() %}
    where create_time > (select max(insert_date) from {{this}})
    {% endif %}

)

select * from final