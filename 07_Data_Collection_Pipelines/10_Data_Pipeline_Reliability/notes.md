# Data Pipeline Reliability

Data pipeline reliability is the ability of a pipeline to **process data correctly, detect failures, recover from temporary problems, and prevent bad data from reaching the destination**.

---

## 1. Logging

**Logging** records what happens during pipeline execution.

```python
import logging

logging.basicConfig(level=logging.INFO)

logging.info("Pipeline started")
logging.info("Data extraction completed")
logging.info("Data validation completed")
logging.error("Database connection failed")
```

### Why Logging Is Important

Logs help identify:

- Where a pipeline failed
- When the failure occurred
- What operation was running
- Whether a step succeeded
- What error occurred

Example:

```text
10:00 → Extraction started
10:02 → Extraction completed
10:05 → Transformation started
10:15 → Validation completed
10:20 → Database connection failed
```

---

# 2. Exception Handling

**Exception handling** allows a program to detect and handle errors without failing unexpectedly.

Basic structure:

```python
try:
    # Code that may fail

except Exception as e:
    # Handle error
```

Example:

```python
import logging

try:
    data = 10 / 0

except Exception as e:
    logging.error("Pipeline failed: %s", e)
```

For pipelines:

```python
try:
    data = extract_data()
    data = transform_data(data)
    load_data(data)

except Exception as e:
    logging.error("Pipeline failed: %s", e)
```

---

# 3. Retry Mechanisms

A **retry mechanism** attempts an operation again after a temporary failure.

Example:

```text
Attempt 1 → Failed
Attempt 2 → Failed
Attempt 3 → Success
```

Useful for temporary failures such as:

- Network timeout
- Database connection failure
- Temporary server unavailability
- Service interruption

General flow:

```text
Operation
   ↓
Failed?
   ↓
Temporary?
  ↙    ↘
YES     NO
 ↓       ↓
Retry   Handle Error
```

---

# 4. Temporary vs Permanent Errors

Not every error should be retried.

### Temporary Errors

These may succeed if tried again:

- Network timeout
- Connection timeout
- Temporary server failure
- Service unavailable

```text
Temporary Error
      ↓
    Retry
```

### Permanent Errors

Retrying will not normally solve the problem:

- Invalid API key
- Invalid SQL query
- Invalid data
- Missing required column
- Incorrect configuration

```text
Permanent Error
      ↓
Log Error
      ↓
Stop / Handle
```

---

# 5. Validation

**Data validation** checks whether incoming data satisfies expected rules before continuing through the pipeline.

Common checks:

- Missing values
- Data types
- Duplicate records
- Value ranges
- Unexpected values
- Date consistency
- Required fields

Example:

```python
if df["age"].isna().any():
    raise ValueError("Age contains missing values")
```

Another example:

```python
if (df["salary"] < 0).any():
    raise ValueError("Negative salary detected")
```

General flow:

```text
Incoming Data
      ↓
  Validation
      ↓
Valid?
 ↙       ↘
NO       YES
↓         ↓
Reject   Continue
/Handle  Pipeline
```

---

# 6. Failure Handling

**Failure handling** defines what the pipeline should do when an operation fails.

Example:

```text
Extract
   ↓
Transform
   ↓
Validation ❌
   ↓
Log Error
   ↓
Stop Pipeline
```

Invalid data should not continue into the destination or ML training process.

---

# 7. Reliable Pipeline Flow

A reliable pipeline combines all these components:

```text
START
  ↓
Extract
  ↓
Log
  ↓
Validate
  ↓
Valid?
 ↙     ↘
NO     YES
↓       ↓
Log   Transform
Error    ↓
↓      Validate
Stop      ↓
        Load
          ↓
     Load Successful?
       ↙       ↘
     NO         YES
     ↓           ↓
   Retry    Update State
     ↓           ↓
  Failure     SUCCESS
```

---

# 8. Production-Style Structure

A simplified reliable pipeline:

```python
import logging

logging.basicConfig(level=logging.INFO)

def pipeline():

    try:
        logging.info("Pipeline started")

        data = extract_data()
        logging.info("Extraction completed")

        validate_data(data)
        logging.info("Validation completed")

        data = transform_data(data)
        logging.info("Transformation completed")

        load_data(data)
        logging.info("Loading completed")

        logging.info("Pipeline completed successfully")

    except Exception as e:
        logging.error("Pipeline failed: %s", e)
        raise
```

---

# 9. Reliability Components

| Component | Purpose |
|---|---|
| **Logging** | Records pipeline activity and errors |
| **Exception Handling** | Handles unexpected errors |
| **Retry Mechanism** | Recovers from temporary failures |
| **Validation** | Prevents invalid data from continuing |
| **Failure Handling** | Defines how pipeline failures are handled |

---

# 10. Connection With Previous Concepts

```text
Data Collection
      ↓
Validation
      ↓
Incremental Loading
      ↓
Idempotency
      ↓
Pipeline Reliability
```

- **Incremental loading** → Determines which data needs processing.
- **Validation** → Determines whether the data is valid.
- **Idempotency** → Makes repeated runs safe.
- **Logging** → Records what happened.
- **Exception handling** → Handles errors.
- **Retry mechanisms** → Recover from temporary failures.
- **Failure handling** → Defines what happens when recovery is unsuccessful.

---

# Key Takeaways

- **Logging** records pipeline execution and errors.
- **Exception handling** prevents unexpected failures from being ignored.
- **Retry mechanisms** help recover from temporary failures.
- **Validation** prevents bad data from entering downstream systems.
- **Failure handling** determines how the pipeline responds to errors.
- Temporary failures can often be retried; permanent failures generally require correction.
- A reliable pipeline should be **observable, fault-tolerant, and safe to rerun**.

> **Core idea:** A reliable data pipeline should not just process data when everything works—it should also detect, report, and safely handle failures when things go wrong.