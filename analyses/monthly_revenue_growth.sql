-- Анализ роста дохода по месяцам
with monthly_revenue as (
    select
        date_trunc('month', order_date_utc) as month,
        sum(revenue_total) as total_revenue
    from {{ ref('fct_sales') }}
    group by 1
)
select
    month,
    total_revenue,
    (total_revenue - lag(total_revenue) over (order by month)) /
    nullif(lag(total_revenue) over (order by month), 0) * 100 as pct_change
from monthly_revenue
order by month;
