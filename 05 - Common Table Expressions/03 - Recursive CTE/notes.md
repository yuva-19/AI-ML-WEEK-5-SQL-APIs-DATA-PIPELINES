# Recursive CTEs

Recursive CTEs are used when data has a hierarchical or parent-child relationship.

Examples:

- Organizational structures
- Product categories
- Folder structures
- Tree-like data
- Hierarchical relationships

---

## WITH RECURSIVE

Basic structure:

WITH RECURSIVE cte_name AS (

    -- Anchor query
    SELECT ...

    UNION ALL

    -- Recursive query
    SELECT ...
    FROM cte_name
    WHERE ...

)

SELECT *
FROM cte_name;

---

## Anchor Query

The anchor query defines where recursion starts.

Example:

SELECT
    category_id,
    category_name,
    parent_category_id,
    1 AS category_level
FROM category_hierarchy
WHERE parent_category_id IS NULL;

This finds the root category.

---

## Recursive Query

The recursive query finds the next level of children.

Example:

SELECT
    c.category_id,
    c.category_name,
    c.parent_category_id,
    ch.category_level + 1
FROM category_hierarchy AS c
JOIN category_tree AS ch
    ON c.parent_category_id = ch.category_id;

The CTE refers to itself:

FROM category_tree AS ch

This is what makes the CTE recursive.

---

## UNION ALL

The anchor query and recursive query are combined using:

UNION ALL

Conceptually:

Root
↓
Children
↓
Grandchildren
↓
Next level
↓
...

---

## Recursion Process

A recursive CTE works like:

1. Start with the anchor rows.
2. Find children of those rows.
3. Add the children.
4. Find children of the new rows.
5. Continue until no more matching rows exist.

---

## Category Hierarchy

Example:

Electronics
├── Computers
│   ├── Laptops
│   └── Desktops
│
├── Phones
│   ├── Smartphones
│   └── Feature Phones
│
└── Accessories
    ├── Headphones
    └── Chargers

The hierarchy can be represented using:

category_id
parent_category_id

Example:

Electronics → parent = NULL
Computers → parent = Electronics
Laptops → parent = Computers

---

## Hierarchy Level

A recursive CTE can track the depth of each node.

Root:

category_level = 1

Child:

category_level = 2

Grandchild:

category_level = 3

Example:

Electronics → 1
Computers → 2
Laptops → 3

---

## Simple Recursive Example

Generate numbers from 1 to 5:

WITH RECURSIVE numbers AS (

    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM numbers
    WHERE number < 5

)

SELECT *
FROM numbers;

Result:

1
2
3
4
5

---

## Important Terms

Anchor query
→ Starting point of recursion.

Recursive query
→ Query that generates the next level.

UNION ALL
→ Combines anchor and recursive results.

Termination condition
→ Condition that eventually stops recursion.

Hierarchy level
→ Depth of a node in the hierarchy.

Parent
→ Node one level above.

Child
→ Node one level below.

Root
→ Top-level node with no parent.

---

## AI/ML and Analytics Relevance

Recursive CTEs can be useful when preprocessing hierarchical data.

Examples:

- Product category hierarchies
- Organizational data
- Folder structures
- Dependency relationships
- Hierarchical feature generation

Deep recursive optimization and graph traversal are not required for this roadmap.