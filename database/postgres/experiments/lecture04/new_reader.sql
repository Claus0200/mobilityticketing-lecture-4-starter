-- TODO: Extend this query to return a resolved_product_id.
-- Join by product_id when present; otherwise look up the product by code.
-- Before backfill, your query should still resolve every original ticket.
SELECT
    t.id,
    t.product_code,
    t.product_id,
    COALESCE(p_new.id, p_old.id) AS resolved_product_id,
    t.price,
    t.currency
FROM tickets t
LEFT JOIN products p_new
    ON p_new.id = t.product_id
LEFT JOIN products p_old
    ON t.product_id IS NULL
   AND p_old.code = t.product_code
ORDER BY t.id;