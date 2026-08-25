# BLOCK 5 — JSON 📦

## JSON Basics

JSON is the common format used by APIs to exchange data.

### JSON → Python

```python
data = response.json()
```

Common mappings:

```text
JSON object  → Python dictionary
JSON array   → Python list
JSON value   → Python value
```

---

## Accessing JSON

### Dictionary

```python
data["name"]
data["email"]
```

### List

```python
data[0]
```

### List of dictionaries

```python
for user in data:
    print(user["name"])
```

---

## Nested JSON

Example:

```python
user["address"]["city"]
```

Think:

```text
user
 └── address
      └── city
```

Each `["key"]` moves one level deeper.

---

## Inspect API JSON First

Don't assume the structure.

```python
data = response.json()

print(type(data))
print(data)
```

Useful:

```python
print(type(data[0]))
```

This helps determine whether the response is:

```text
list → dictionary
```

or another structure.

---

## Serialization

### JSON → Python

**Deserialization**

```python
data = response.json()
```

### Python → JSON

**Serialization**

```python
requests.post(url, json=data)
```

---

## JSON → DataFrame

For flat JSON:

```python
import pandas as pd

df = pd.DataFrame(data)
```

Pipeline:

```text
API
 ↓
JSON
 ↓
Python
 ↓
DataFrame
```

---

## Flattening Nested JSON

For nested API responses:

```python
df = pd.json_normalize(data)
```

Example nested field:

```text
address
 └── city
```

can become:

```text
address.city
```

Useful for converting API data into an analysis-ready table.

---

## Important Mental Model

```text
{} → Dictionary → ["key"]

[] → List → [index]
```

Example:

```python
data[0]["address"]["city"]
```

means:

```text
first item
   ↓
address
   ↓
city
```

### ⭐ AI/ML Focus

The important workflow to remember:

```text
API Response
     ↓
response.json()
     ↓
Inspect structure
     ↓
Extract / navigate JSON
     ↓
pd.DataFrame()
or
pd.json_normalize()
     ↓
Data Analysis / Preprocessing
```

**Focus on:** JSON objects, arrays, nested JSON, parsing, `json_normalize()`, serialization/deserialization.