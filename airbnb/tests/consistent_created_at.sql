WITH f as (
    select * from {{ ref('fct_reviews') }})
,
  d as  (select * from {{ ref('dim_listings_cleansed') }})

select f.*
from f
join d on f.listing_id = d.listing_id
where f.review_date < d.created_at
limit 10