--Ad Campaign ROAS
SELECT advertiser_id, 
ROUND(CAST((tot_revenue/tot_spend) as decimal),2) as ROAS
FROM
(SELECT advertiser_id,
sum(spend) as tot_spend,
sum(revenue) as tot_revenue
FROM ad_campaigns
GROUP BY advertiser_id) as t0
ORDER BY advertiser_id
;
