# BLOCK 11 — Modern API Technologies

> **Goal:** Understand what these technologies are, why they exist, and when AI/ML engineers might encounter them.  
> **Depth:** Introduction only — no need to master them yet.

---

## 1. Webhooks

A **webhook** allows a server to automatically send data to your application when an event happens.

### Normal API

Your program asks:

```text
Your program → API
             "Any new orders?"
```

You have to keep asking.

### Webhook

The server contacts you automatically:

```text
Event happens
     ↓
API Server
     ↓
Your webhook URL
     ↓
Your application
```

### Example

An order is successfully paid.

Instead of your application repeatedly checking:

```text
"Is the order paid?"
"Is the order paid?"
"Is the order paid?"
```

The payment service sends:

```json
{
    "event": "payment_success",
    "order_id": 101,
    "amount": 2500
}
```

to your webhook endpoint.

### Important

**API polling:**

> Client asks server for updates.

**Webhook:**

> Server pushes an update to client.

### AI/ML use cases

- Receiving notifications when a model training job finishes
- Triggering data pipelines when new data arrives
- Receiving events from SaaS platforms
- Triggering ML predictions after a business event

---

# 2. GraphQL

**GraphQL** is an API query language that allows the client to request exactly the data it needs.

### REST

A REST API might have:

```text
GET /customers/101
GET /customers/101/orders
GET /customers/101/profile
```

You may need multiple requests.

### GraphQL

The client can request related data in one query:

```graphql
query {
    customer(id: 101) {
        name
        email
        orders {
            order_id
            status
        }
    }
}
```

The server returns the requested structure.

### Main advantage

The client controls **which fields it wants**.

Instead of receiving:

```json
{
    "id": 101,
    "name": "Yuvanesh",
    "email": "yuva@example.com",
    "phone": "...",
    "address": "...",
    "company": "...",
    "other_data": "..."
}
```

you can request only:

```text
name
email
```

### REST vs GraphQL

| REST | GraphQL |
|---|---|
| Multiple endpoints | Usually a GraphQL endpoint |
| Server defines response structure | Client requests fields |
| Easy to understand | More flexible |
| Very common | Common in some modern applications |

### AI/ML relevance

GraphQL can be useful when collecting structured data from applications where you need **specific fields from complex/nested data**.

> **For now:** Understand the concept. Don't spend time mastering GraphQL syntax.

---

# 3. Async HTTP with `httpx`

Normally, with `requests`, a request waits for the response.

```python
response = requests.get(url)
```

The program waits here until the request finishes.

With **asynchronous HTTP**, your program can start other work while waiting for network operations.

### Example idea

Suppose you need data from:

```text
API 1
API 2
API 3
API 4
```

With normal synchronous execution:

```text
API 1 → wait → finish
API 2 → wait → finish
API 3 → wait → finish
API 4 → wait → finish
```

With async execution, multiple network requests can be in progress:

```text
API 1 ──────────→
API 2 ───────→
API 3 ─────────────→
API 4 ──────→
```

This can significantly improve performance for **I/O-bound workloads**.

---

## `httpx`

`httpx` is a modern Python HTTP client.

It supports both:

- Synchronous requests
- Asynchronous requests

Basic synchronous usage:

```python
import httpx

response = httpx.get(url)
```

Async usage:

```python
import httpx
import asyncio

async def main():
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        print(response.json())

asyncio.run(main())
```

### Important terms

**`async def`**

Defines an asynchronous function.

**`await`**

Waits for an asynchronous operation without blocking the entire async workflow.

**`AsyncClient`**

Used for making asynchronous HTTP requests.

### AI/ML use cases

Async HTTP becomes useful when:

- Calling many APIs
- Sending many LLM requests
- Collecting data from multiple services
- Building high-throughput data pipelines
- Making many network requests concurrently

---

# 4. `aiohttp`

`aiohttp` is another Python library for asynchronous HTTP communication.

It can be used to:

- Make asynchronous HTTP requests
- Build asynchronous HTTP servers

Example:

```python
import aiohttp
import asyncio

async def main():

    async with aiohttp.ClientSession() as session:

        async with session.get(url) as response:

            data = await response.json()

            print(data)

asyncio.run(main())
```

### `httpx` vs `aiohttp`

Both support asynchronous HTTP.

For your current AI/ML learning:

```text
requests
   ↓
Learn properly
   ↓
httpx
   ↓
Understand async API calls
   ↓
aiohttp
   ↓
Know that it exists
```

You **do not need deep `aiohttp` knowledge right now**.

---

# 5. When Should You Use What?

### `requests`

Use when:

- Making normal API requests
- Working with a small number of requests
- Building simple data collection scripts

```python
requests.get()
requests.post()
```

### `httpx`

Use when:

- You need modern HTTP features
- You want synchronous or asynchronous HTTP
- You need many concurrent API requests

### `aiohttp`

Use when:

- Building heavily asynchronous applications
- You specifically need its async HTTP capabilities
- Working with an existing `aiohttp` ecosystem

### Webhooks

Use when:

> You want the server to notify you when something happens.

### GraphQL

Use when:

> You need flexible access to specific fields from complex data.

---

# 6. Key Difference to Remember

```text
REST API
    ↓
Client requests data

Webhook
    ↓
Server sends notification when event happens

GraphQL
    ↓
Client specifies exactly what data it wants

httpx / aiohttp
    ↓
Tools for making HTTP requests,
especially useful for asynchronous/concurrent requests
```

---

# 7. What You Actually Need to Remember 🧠

For your **AI/ML roadmap**, remember these:

- **Webhook = server pushes event/data to you**
- **REST = client requests resources**
- **GraphQL = client asks for specific fields**
- **Async = don't unnecessarily wait for each network operation**
- **`httpx` = modern HTTP client with async support**
- **`aiohttp` = another async HTTP library**
- Async HTTP is especially useful when making **many API calls concurrently**
- You **do not need to master GraphQL, webhooks, or `aiohttp` yet**

### Priority

| Technology | Your required level |
|---|---|
| Webhooks | ⭐⭐ Understand |
| GraphQL | ⭐⭐ Understand |
| `httpx` | ⭐⭐ Understand + basic usage |
| `aiohttp` | ⭐ Know it exists |
| Async programming | ⭐⭐ Understand the idea |
