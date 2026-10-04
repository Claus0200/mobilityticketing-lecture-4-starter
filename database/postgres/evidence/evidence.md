# Evidence

## Ticket price

### Before migration

| ID       | Product code | Price | Currency |
| -------- | ------------ | ----: | -------- |
| TICKET-1 | SINGLE       | 36.00 | DKK      |
| TICKET-2 | SINGLE       | 36.00 | DKK      |
| TICKET-3 | DAY          | 65.00 | DKK      |

### After migration and test writes

| ID          | Product code | Price | Currency |
| ----------- | ------------ | ----: | -------- |
| LAB04-NEW-1 | SINGLE       | 36.00 | DKK      |
| LAB04-OLD-1 | SINGLE       | 36.00 | DKK      |
| LAB04-OLD-2 | SINGLE       | 36.00 | DKK      |
| TICKET-1    | SINGLE       | 36.00 | DKK      |
| TICKET-2    | SINGLE       | 36.00 | DKK      |
| TICKET-3    | DAY          | 65.00 | DKK      |

The original tickets retain their product codes, prices, and currencies after the migration.

## Observation table

| Stage                            | Old writer (`product_code`) | New writer (`product_id`) | Old reader | New reader    | Observation                                                                                                  |
| -------------------------------- | --------------------------- | ------------------------- | ---------- | ------------- | ------------------------------------------------------------------------------------------------------------ |
| **Before expansion**             | Works                       | Not available             | Works      | Not available | Original schema only has `product_code`.                                                                     |
| **After expansion**              | Works                       | Works                     | Works      | Works         | `product_id` is nullable. Existing tickets have `product_id = NULL`.                                         |
| **After backfill**               | Works                       | Works                     | Works      | Works         | Existing tickets have been assigned the correct `product_id`. Re-running the backfill changes 0 rows.        |
| **After `product_id` required**  | **Fails**                   | Works                     | Works      | Works         | Old writer fails because it does not provide `product_id`. The database rejects rows with `NULL product_id`. |
| **After `product_code` removed** | **Fails**                   | Works                     | **Fails**  | Works         | Old writer/reader depend on the removed column. New writer and reader use only `product_id`.                 |

## Rollout decision

The old writers should be stopped after the backfill has completed, the verification query returns zero rows, and the new writer and reader have been tested. product_id can then be made required. The old application cannot safely be restored after this point because the old writer fails when product_id is required. After tickets.product_code is removed, the old reader and writer are no longer compatible with the database.
