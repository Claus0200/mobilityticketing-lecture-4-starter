-- Change both values for each new ticket, including your late-write test.
INSERT INTO tickets
    (id, user_id, trip_id, ticket_code, status, product_code,
     valid_from_utc, valid_to_utc, price, currency)
SELECT
    'LAB04-OLD-1',
    user_id,
    trip_id,
    'LAB04-CODE-OLD-1',
    status,
    product_code,
    valid_from_utc,
    valid_to_utc,
    price,
    currency
FROM tickets
WHERE id = 'TICKET-1';