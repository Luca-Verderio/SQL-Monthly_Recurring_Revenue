WITH cte AS
	(SELECT creators.creator_id, creators.monthly_amount, subscriptions.active_from, subscriptions.expires_at FROM creators
	JOIN subscriptions
	ON creators.creator_id = subscriptions.creator_id)

SELECT creator_id,
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-10 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-10 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -11",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-9 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-9 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -10",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-8 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-8 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -9",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-7 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-7 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -8",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-6 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-6 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -7",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-5 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-5 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -6",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-4 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-4 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -5",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-3 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-3 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -4",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-2 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-2 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -3",
	SUM(CASE
		WHEN active_from < (date_trunc('month', now()) + interval '-1 month')::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-1 month -1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -2",
	SUM(CASE
		WHEN active_from < date_trunc('month', now())::timestamp AND
			 (expires_at >= (date_trunc('month', now()) + interval '-1 day')::timestamp OR expires_at IS NULL)
		THEN monthly_amount
	END) AS "MRR month -1",
	SUM(CASE
		WHEN now() <= expires_at OR expires_at IS NULL
		THEN monthly_amount
	END) AS "MRR current month"
FROM cte
WHERE creator_id = 5
GROUP BY creator_id