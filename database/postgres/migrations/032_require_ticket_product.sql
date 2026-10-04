-- Copy to 032_require_ticket_product.sql and complete it.
-- Apply only after retiring old writers and passing final verification.
-- Validate the product-ID foreign key, then require the ticket reference.
-- Rehearse legacy-column removal separately after dependency checks.

BEGIN;
SET LOCAL lock_timeout = '3s';

ALTER TABLE tickets
  VALIDATE CONSTRAINT tickets_product_id_fk;

ALTER TABLE tickets
  ALTER COLUMN product_id SET NOT NULL;

COMMIT;
