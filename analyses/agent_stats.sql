with exploded as (
    select
        reference_id,
        trim(agent) as sales_agent,
        revenue_total,
        discount_amount
    from {{ ref('fct_sales') }},
         regexp_split_to_table(sales_agents, ',') as agent
    where sales_agents is not null
),

agent_stats as (
    select
        sales_agent,
        count(distinct reference_id) as total_sales,
        avg(revenue_total) as avg_revenue,
        avg(discount_amount) as avg_discount,
        sum(revenue_total) as total_revenue
    from exploded
    where sales_agent <> 'N/A'
    group by sales_agent
)

select
    sales_agent,
    total_sales,
    round(avg_revenue::numeric,2) as avg_revenue,
    round(avg_discount::numeric,2) as avg_discount,
    total_revenue,
    rank() over (order by total_revenue desc) as revenue_rank
from agent_stats
order by total_revenue desc;
