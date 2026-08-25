# BLOCK 8 — API ERROR HANDLING & RELIABILITY 🛡️

## 1. Why Error Handling?

API requests can fail because of:

- Server errors
- Invalid requests
- Authentication problems
- Timeouts
- Network failures
- Rate limits

A production API program should **handle failures instead of crashing**.

---

## 2. Basic Status-Code Handling

Use `response.status_code` when you need **specific behavior** for a particular status.

```python
response = requests.get(url)

if response.status_code == 200:
    data = response.json()

elif response.status_code == 404:
    print("Not found")

else:
    print("Unexpected error")
```

Use this when you specifically care about statuses such as `404`, `401`, `403`, or `429`.

---

## 3. `raise_for_status()`

```python
response.raise_for_status()
```

Checks whether the response has an HTTP error.

### 2xx → continues normally

```text
200 → continues
201 → continues
204 → continues
```

### 4xx / 5xx → raises an exception

```text
400 → exception
401 → exception
404 → exception
500 → exception
503 → exception
```

It **does not make another request**. It only checks the response you already received.

Typical usage:

```python
try:
    response = requests.get(url, timeout=5)

    response.raise_for_status()

    data = response.json()

except requests.exceptions.RequestException as e:
    print("Request failed:", e)
```

---

## 4. `try / except`

Use `try/except` to handle request-related exceptions.

```python
try:
    response = requests.get(
        url,
        timeout=5
    )

except requests.exceptions.RequestException as e:
    print("Request failed:", e)
```

Prefer:

```python
except requests.exceptions.RequestException as e:
```

over:

```python
except:
```

because it specifically handles errors from the `requests` operation.

---

## 5. Timeout

Always consider using a timeout:

```python
response = requests.get(
    url,
    timeout=5
)
```

Without a timeout, your program may wait too long for an unresponsive server.

Handle timeout errors with:

```python
try:
    response = requests.get(
        url,
        timeout=5
    )

except requests.exceptions.Timeout:
    print("Request timed out")
```

---

# 6. Retry Logic

Some failures are temporary.

Example:

```text
Request 1 → 503 ❌
Request 2 → 503 ❌
Request 3 → 200 ✅
```

A retry mechanism allows the program to try again.

Basic structure:

```python
for attempt in range(3):

    try:
        response = requests.get(
            url,
            timeout=5
        )

        response.raise_for_status()

        data = response.json()

        break

    except requests.exceptions.RequestException as e:
        print("Request failed:", e)
```

`range(3)` → maximum **3 attempts**.

---

# 7. Which Errors Should Be Retried?

This is important.

### Usually DON'T retry ❌

These generally indicate a problem with the request or permissions:

```text
400 → Bad Request
401 → Unauthorized
403 → Forbidden
404 → Not Found
```

Example:

```python
if response.status_code == 404:
    print("Resource not found")
    break
```

There is usually no point repeatedly requesting a resource that doesn't exist.

---

### Usually CAN retry ✅

Temporary failures include:

```text
500 → Internal Server Error
502 → Bad Gateway
503 → Service Unavailable
```

Also commonly retry:

```text
Timeout
Temporary connection failure
```

---

### Special case: 429

```text
429 → Too Many Requests
```

This means the API rate limit was exceeded.

Usually:

```text
429
 ↓
wait
 ↓
retry
```

If the API provides a `Retry-After` header, follow it.

---

# 8. Exponential Backoff

Don't retry immediately again and again.

Instead, progressively increase the waiting time.

```text
Attempt 1 → fail → wait 1 sec
Attempt 2 → fail → wait 2 sec
Attempt 3 → fail → stop
```

Common pattern:

```python
wait_time = 2 ** attempt
```

For:

```text
attempt = 0 → 1 second
attempt = 1 → 2 seconds
attempt = 2 → 4 seconds
```

Use:

```python
import time

time.sleep(wait_time)
```

---

# 9. Retry + Backoff Structure

```python
import requests
import time

for attempt in range(3):

    try:
        response = requests.get(
            url,
            timeout=5
        )

        if response.status_code == 404:
            print("Not found. No retry.")
            break

        response.raise_for_status()

        data = response.json()

        break

    except requests.exceptions.RequestException as e:

        print(f"Attempt {attempt + 1} failed:", e)

        if attempt < 2:
            wait_time = 2 ** attempt
            time.sleep(wait_time)

        else:
            print("All attempts failed")
```

---

# 10. Important Pattern to Remember

```text
API Request
    ↓
Check response
    ↓
Specific permanent error?
    │
    ├── YES → Handle it → STOP
    │
    └── NO
         ↓
     Temporary error?
         │
         ├── YES → Wait → Retry
         │
         └── NO → Handle/Stop
```

---

# 11. Common Mistakes

### ❌ Bare `except`

```python
except:
```

Prefer:

```python
except requests.exceptions.RequestException as e:
```

### ❌ Retry forever

```python
while True:
    requests.get(url)
```

Always have a **maximum retry limit**.

### ❌ Retry 404 repeatedly

```text
404 → retry → 404 → retry → 404
```

Usually pointless.

### ❌ No timeout

```python
requests.get(url)
```

Prefer:

```python
requests.get(url, timeout=5)
```

### ❌ Retry immediately

```text
fail → retry immediately → fail → retry immediately
```

Use backoff:

```text
1 sec → 2 sec → 4 sec → ...
```

---

# 🧠 Quick Revision

| Situation | Action |
|---|---|
| `200` | Process response |
| `201` | Process created response |
| `400` | Fix request |
| `401` | Fix authentication |
| `403` | Check permissions |
| `404` | Resource doesn't exist → usually don't retry |
| `429` | Wait → retry |
| `500` | Usually retry |
| `502` | Usually retry |
| `503` | Usually retry |
| Timeout | Usually retry |
| Connection failure | Usually retry |

### Core tools

```python
response.status_code
```

→ Check a specific status.

```python
response.raise_for_status()
```

→ Turn HTTP errors into exceptions.

```python
try:
    ...
except requests.exceptions.RequestException:
    ...
```

→ Handle request failures.

```python
timeout=5
```

→ Don't wait forever.

```python
time.sleep(...)
```

→ Wait before retrying.

```python
2 ** attempt
```

→ Exponential backoff.

**Core idea:**  
> **Check → Decide → Retry only when it makes sense → Back off → Stop after a limit.**