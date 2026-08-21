# ANY and ALL

ANY and ALL are comparison operators used when
comparing a value against multiple values.

They are commonly used with subqueries.

---

# ANY

ANY returns TRUE when the comparison is TRUE for
at least one value returned by the subquery.

Example:

SELECT
    product_name,
    price
FROM filtering_products
WHERE price > ANY (
    SELECT price
    FROM filtering_products
    WHERE category = 'Stationery'
);

If Stationery prices are:

100
50

price > ANY means the price must be greater than
at least one of those values.

Mental model:

ANY → at least one → OR

---

# ALL

ALL returns TRUE only when the comparison is TRUE
for every value returned by the subquery.

Example:

SELECT
    product_name,
    price
FROM filtering_products
WHERE price > ALL (
    SELECT price
    FROM filtering_products
    WHERE category = 'Stationery'
);

If Stationery prices are:

100
50

price > ALL means:

price > 100
AND
price > 50

Mental model:

ALL → every value → AND

---

# ANY vs ALL

ANY:
The comparison must be TRUE for at least one value.

ALL:
The comparison must be TRUE for every value.

---

# Relationship with IN

For equality comparisons:

price = ANY (...)

is conceptually similar to:

price IN (...)

---

# Relationship with NOT IN

For inequality comparisons:

price <> ALL (...)

is conceptually similar to:

price NOT IN (...)

NULL behavior should still be considered.

---

# When to Use

IN is usually clearer for simple membership checks.

ANY and ALL are useful when performing comparisons
against multiple values returned by a subquery.

Examples:

price > ANY (...)
price > ALL (...)
price < ANY (...)
price < ALL (...)