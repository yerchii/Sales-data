-- Анализ по агентам
with agent_data as (
    select
        unnest(string_to_array(sales_agents, ', ')) as agent_name,
        revenue_total,
        discount_amount
    from {{ ref('fct_sales') }}
)
select
    agent_name,
    count(*) as num_sales,
    sum(revenue_total) as total_revenue,
    avg(revenue_total) as avg_revenue,
    avg(discount_amount) as avg_discount,
    rank() over (order by sum(revenue_total) desc) as revenue_rank,
    case when avg(discount_amount) > (select avg(discount_amount) from agent_data)
         then 'above_avg' else 'below_avg' end as discount_level
from agent_data
group by agent_name
order by total_revenue desc;
