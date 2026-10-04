-- After expansion, use this query to choose a product ID for your test.
select id, code, price, currency from products order by code;

-- TODO: Write a function or parameterized insert that accepts a product ID.
-- Look up its code and store both references on the ticket.
-- Use old_writer.sql as a guide to the other required ticket fields.
-- Keep the agreed price as an input; do not copy the current catalogue price.
-- Test an unknown ID and a supplied code belonging to another product.

INSERT INTO tickets (
    id,
    user_id,
    trip_id,
    ticket_code,
    status,
    product_id,
    product_code,
    valid_from_utc,
    valid_to_utc,
    price,
    currency
)
SELECT
    'LAB04-NEW-1',
    user_id,
    trip_id,
    'LAB04-CODE-NEW-1',
    status,
    p.id,
    p.code,
    valid_from_utc,
    valid_to_utc,
    36.00,
    'DKK'
FROM tickets t
JOIN products p
    ON p.id = '6ba9e6ed-4a01-4857-9534-db53378737be'
WHERE t.id = 'TICKET-1';