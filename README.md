# MobilityTicketing: Lecture 4 starter

Submitted commit: 
Setup and reset instructions: [link](setup.md)

## Where to find the work
Lecture 1: model, workload map and queries: [link](https://github.com/Claus0200/mobilityticketing-lecture-1-starter)
Lecture 2: constraints and tests: [link](https://github.com/Claus0200/mobilityticketing-lecture-2-starter)
Lecture 3: reporting experiment and comparison: [link](https://github.com/Claus0200/mobilityticketing-lecture-3-starter)
Lecture 4: migration stages and verification: [link](https://github.com/Claus0200/mobilityticketing-lecture-4-starter)

## Two decisions worth discussing

### Expand before migrating
I choose to first add product_id as nullable column while keeping product_code. Instead of the alternative to remove product_code and make product_id required immediately.
The reason for that is to make migration easier, so that we have point where both the old writer/reader works and the new writer/reader.

030_expand_product_identity.sql and the failed migration shows that making product_id required immediately fails because existing tickets contain NULL values.

### Make product_id required only after backfill

I choose to first backfill all existing tickets with their correct product_id and then make product_id required. Instead of making product_id required while some tickets still have NULL values.
The reason for that is to make sure all existing tickets have a valid product reference before enforcing the new requirement. This also gives us a clear point where we can verify that the migration is complete.

031_backfill_ticket_product.sql and 032_require_ticket_product.sql support this. The failed test where product_id was made required while a ticket still had NULL shows that the database rejects the change until the tickets have been backfilled.


## One limitation or open question
One limitation is that we have not fully checked whether removing tickets.product_code could break other parts of the system. We have mainly checked the tickets table, readers, writers, views and functions, but there could still be other application code, queries or tests that depend on product_code without knowing.

The relevant evidence is the dependency checks and the successful tests of the readers and writers. These show that the parts we checked work, but they do not guarantee that there are no other dependencies elsewhere in the system.

The next step would be to search the entire application and test code for references to tickets.product_code before committing the removal of the column, and then run the relevant tests against the final schema.