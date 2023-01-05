WITH cte AS
	(SELECT creators.creator_id, creators.monthly_amount, subscriptions.active_from, subscriptions.expires_at FROM creators
	JOIN subscriptions
	ON creators.creator_id = subscriptions.creator_id)

SELECT creator_id, SUM(monthly_amount) AS "MRR" FROM cte
WHERE creator_id = 5 AND (expires_at IS NULL OR now() < expires_at)
GROUP BY creator_id