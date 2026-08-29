select ABS(HASH(f.Date)) AS Date_Id ,
f.date,
f.Isholiday,
current_timestamp() as Insert_date,
current_timestamp() as Update_date
from {{ ref('int_date') }} f