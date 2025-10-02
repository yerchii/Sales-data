{% macro test_revenue_total_nonnegative(model, column_name='revenue_total') %}

select *
from {{ model }}
where revenue_total < 0

{% endmacro %}
