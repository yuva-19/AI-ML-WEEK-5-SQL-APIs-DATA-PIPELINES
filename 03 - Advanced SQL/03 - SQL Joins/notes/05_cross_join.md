# CROSS JOIN

CROSS JOIN returns every possible combination of rows
from two tables.

It does not require an ON condition.

## Example

SELECT
    c.customer_name,
    p.product_name
FROM join_customers AS c
CROSS JOIN join_products AS p;

If table A has 4 rows and table B has 3 rows:

4 × 3 = 12 rows

## Important

CROSS JOIN produces a Cartesian product.

It can create a very large number of rows if the
tables are large.

## Use Cases

CROSS JOIN can be useful when generating combinations
between two sets of data.