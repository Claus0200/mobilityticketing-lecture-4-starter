-- TODO: Adapt your new writer to use product_id without tickets.product_code.
-- Keep id, user_id, trip_id, ticket_code, status, validity dates, price and
-- currency in the insert. Use a fresh ticket ID and ticket code.
-- Test after removing the old column. If you try it while that column still
-- exists, check whether its NOT NULL constraint allows the insert.

INSERT INTO tickets (
    id,
    user_id,
    trip_id,
    ticket_code,
    status,
    product_id,
    valid_from_utc,
    valid_to_utc,
    price,
    currency
)
SELECT
    'LAB04-NEW-2',
    user_id,
    trip_id,
    'LAB04-CODE-NEW-2',
    status,
    p.id,
    valid_from_utc,
    valid_to_utc,
    36.00,
    'DKK'
FROM tickets t
JOIN products p
    ON p.id = '6ba9e6ed-4a01-4857-9534-db53378737be'
WHERE t.id = 'TICKET-1';