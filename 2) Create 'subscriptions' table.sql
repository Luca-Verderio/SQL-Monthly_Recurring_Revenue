CREATE TABLE subscriptions(
	subscriber_id SERIAL PRIMARY KEY,
	creator_id INTEGER REFERENCES creators(creator_id),
	active_from TIMESTAMP NOT NULL,
	expires_at TIMESTAMP
)