{{
    config
    (
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['store_id','Dept_id']

    )

}}

select cast(s.Store as integer) as store_id,
cast(d.dept as integer) as Dept_id ,
cast(s.type as varchar) as Store_type,
cast(s.size as integer) as Store_size,
current_timestamp() as Insert_date,
current_timestamp() as Update_date
from {{ ref('stg_stores') }} s
left join {{ ref('int_distinct_dept_store') }} d
on s.store=d.store