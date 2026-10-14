select 
d.store, d.dept, s.type, s.size
from {{ ref('stg_department')}} d
left join {{ ref('stg_stores')}} s on d.store=s.store