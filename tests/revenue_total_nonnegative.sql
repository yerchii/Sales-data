-- tests/revenue_total_nonnegative.sql
select *
from {{ ref('fct_sales') }}
where revenue_total < 0
