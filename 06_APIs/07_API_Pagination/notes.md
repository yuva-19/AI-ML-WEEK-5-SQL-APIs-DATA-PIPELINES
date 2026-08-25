# BLOCK 7 — API PAGINATION

## 1. What is Pagination?

APIs may contain thousands or millions of records, so they usually **do not return everything in one request**.

Instead, the data is divided into smaller parts called **pages**.

```text
API
│
├── Page 1 → 100 records
├── Page 2 → 100 records
├── Page 3 → 100 records
└── ...
```

Pagination is important when collecting large datasets for **data analysis, preprocessing, and ML pipelines**.

---

# 2. Offset Pagination

The API uses parameters such as:

```text
limit
offset
```

### `limit`

Number of records requested.

```text
limit = 100
```

→ Return at most 100 records.

### `offset`

Number of records to skip.

```text
offset = 0    → first 100
offset = 100  → next 100
offset = 200  → next 100
```

Example:

```python
params = {
    "limit": 100,
    "offset": 200
}

response = requests.get(
    url,
    params=params
)
```

---

# 3. Offset Pagination Loop

Typical pattern:

```python
all_data = []

limit = 100
offset = 0

while True:

    params = {
        "limit": limit,
        "offset": offset
    }

    response = requests.get(
        url,
        params=params
    )

    data = response.json()

    # Store current page
    all_data.extend(data)

    # Stop if this is the last page
    if len(data) < limit:
        break

    # Move to next page
    offset += limit
```

### Remember the order:

```text
REQUEST
   ↓
GET DATA
   ↓
STORE DATA
   ↓
CHECK LAST PAGE
   ↓
MOVE TO NEXT PAGE
```

---

# 4. Detecting the Last Page

A common pattern is:

```python
if len(data) < limit:
    break
```

Suppose:

```text
limit = 100
```

API responses:

```text
Page 1 → 100 records
Page 2 → 100 records
Page 3 → 100 records
Page 4 → 37 records
```

Since:

```text
37 < 100
```

we know the final page has been reached.

⚠️ This is a common pattern, but not every API works this way. Some APIs provide explicit pagination information.

---

# 5. Cursor Pagination

Instead of using an offset, some APIs return a **cursor** for the next page.

Example response:

```json
{
    "data": [
        {"id": 1},
        {"id": 2}
    ],
    "next_cursor": "abc123"
}
```

The next request uses:

```text
cursor=abc123
```

Typical structure:

```python
all_data = []
cursor = None

while True:

    params = {}

    if cursor:
        params["cursor"] = cursor

    response = requests.get(
        url,
        params=params
    )

    result = response.json()

    all_data.extend(result["data"])

    cursor = result.get("next_cursor")

    if not cursor:
        break
```

### Logic

```text
Request
   ↓
Receive data + cursor
   ↓
Store data
   ↓
Get next cursor
   ↓
Cursor exists?
 ↙          ↘
NO          YES
 ↓           ↓
STOP      Next request
```

---

# 6. Token Pagination

Some APIs use a **page token** instead of a cursor.

Example:

```json
{
    "data": [...],
    "nextPageToken": "abc123"
}
```

Next request:

```text
pageToken=abc123
```

The exact parameter name depends on the API.

---

# 7. Types of Pagination

| Type | Main idea |
|---|---|
| **Offset** | `limit + offset` |
| **Cursor** | API returns a cursor for the next page |
| **Token** | API returns a token for the next page |

Examples:

```text
Offset:
offset=0 → offset=100 → offset=200

Cursor:
cursor=A → cursor=B → cursor=C

Token:
token=A → token=B → token=C
```

---

# 8. Pagination + DataFrame

After collecting all pages:

```python
all_data = []

# pagination...

df = pd.DataFrame(all_data)

print(len(all_data))
print(df.shape)
print(df.head())
```

Typical data pipeline:

```text
API
 ↓
Pagination
 ↓
all_data
 ↓
Pandas DataFrame
 ↓
Cleaning
 ↓
Analysis / ML
```

---

# 9. Important Rules

### Always store each page

```python
all_data.extend(data)
```

Otherwise you request the data but lose it.

### Stop the loop properly

```python
if len(data) < limit:
    break
```

Without `break`, the loop may continue indefinitely.

### Move to the next page

```python
offset += limit
```

Only do this when another page exists.

### Initialize your collection

```python
all_data = []
```

Otherwise:

```text
NameError
```

can occur.

---

# 10. Common Mistakes

### ❌ Forgetting to store data

```python
data = response.json()
```

but no:

```python
all_data.extend(data)
```

### ❌ Forgetting `break`

```python
if len(data) < limit:
    print("Done")
```

This does **not** stop the loop.

Use:

```python
if len(data) < limit:
    break
```

### ❌ Wrong DataFrame syntax

```python
pd.DataFrame[all_data]   # ❌
```

Correct:

```python
pd.DataFrame(all_data)   # ✅
```

Remember:

```text
() → function call
[] → indexing/access
```

---

# 11. Real-World Rule

**Never assume how pagination works.**

Read the API documentation and check whether it uses:

```text
?page=2
```

or:

```text
?limit=100&offset=100
```

or:

```text
?cursor=abc123
```

or:

```text
?page_token=abc123
```

Your job is to identify the API's pagination mechanism and implement it correctly.

---

## 🧠 Quick Revision

```text
Pagination
    ↓
Large dataset → split into pages

Offset
    ↓
limit + offset

Cursor
    ↓
next_cursor

Token
    ↓
next_page_token
```

### Core offset pattern:

```python
all_data = []

while True:

    # request page

    data = response.json()

    all_data.extend(data)

    if len(data) < limit:
        break

    offset += limit
```

**The three things you absolutely need to remember:**

> **STORE → CHECK → MOVE**  
> `extend(data)` → `break` → `offset += limit`