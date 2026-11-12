select store,
dept_id,
store_type,
store_size,
create_time as insert_date,
INSERT_DATE as Upadate_date
from {{ ref('int_incremental_stores') }} 