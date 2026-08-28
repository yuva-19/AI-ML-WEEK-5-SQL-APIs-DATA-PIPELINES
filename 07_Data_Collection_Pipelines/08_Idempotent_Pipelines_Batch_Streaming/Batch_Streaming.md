# Batch vs Streaming

## 1. Batch Processing

**Batch processing** means collecting data over a period of time and processing it together as a group.

```text
Data → Data → Data → Data
            ↓
       Collect Batch
            ↓
         Process
            ↓
         Storage
```

### Examples

- Daily sales reports
- Monthly billing
- Payroll processing
- Data warehouse updates
- Large ML dataset preparation
- Scheduled ETL jobs

### Characteristics

- Processes data in groups
- Usually runs on a schedule
- Higher latency
- Simpler to implement
- Suitable when real-time results are not required

---

## 2. Streaming Data

**Streaming data** is data that is processed continuously as it arrives.

```text
Event → Process
Event → Process
Event → Process
Event → Process
```

Instead of waiting for a large collection of records, the pipeline processes incoming data continuously.

### Examples

- Live sensor data
- GPS tracking
- Stock market data
- Live application monitoring
- Real-time recommendations
- Fraud detection

---

## 3. Real-Time Pipelines

A **real-time pipeline** processes incoming data with very low delay.

Example:

```text
Payment
   ↓
Event
   ↓
Pipeline
   ↓
Fraud Detection
   ↓
Approve / Reject
```

Real-time processing is useful when waiting for a scheduled batch would be too slow.

---

## 4. Event-Driven Processing

**Event-driven processing** means an event triggers a processing action.

An **event** represents something that happened in a system.

Examples:

- Order placed
- Payment completed
- User registered
- File uploaded
- Sensor reading received

General flow:

```text
Event Occurs
     ↓
Event Detected
     ↓
Processing Triggered
     ↓
Action / Result
```

Example:

```text
Order placed
     ↓
"Order Created" event
     ↓
Pipeline triggered
     ↓
Update inventory
     ↓
Send confirmation
```

---

# 5. Batch vs Streaming

| Feature | Batch Processing | Streaming |
|---|---|---|
| Processing | Groups of data | Continuous data |
| Timing | Scheduled | As data arrives |
| Latency | Higher | Very low |
| Complexity | Simpler | More complex |
| Example | Daily sales report | Fraud detection |
| Data handling | Large batches | Continuous events |

---

# 6. When to Use Batch Processing

Use batch processing when:

- Immediate results are not required
- Data can be collected before processing
- Large amounts of data can be processed together
- Processing can happen on a schedule

Example:

> Generate yesterday's sales report every morning.

---

# 7. When to Use Streaming

Use streaming when:

- Results are needed quickly
- Data continuously arrives
- Events need immediate processing
- Delays can affect the application

Example:

> Detect fraudulent transactions while payments are happening.

---

# 8. Core Mental Model

### Batch

```text
Collect
   ↓
Wait
   ↓
Process together
```

### Streaming

```text
Data arrives
   ↓
Process immediately
   ↓
Next data arrives
   ↓
Process immediately
```

### Event-Driven

```text
Event occurs
     ↓
Processing triggered
     ↓
Action performed
```

---

# Key Takeaways

- **Batch processing** → Process data periodically in groups.
- **Streaming** → Process data continuously as it arrives.
- **Real-time pipeline** → Process data with very low delay.
- **Event-driven processing** → An event triggers a processing action.
- Batch is generally **simpler** and suitable when immediate results are unnecessary.
- Streaming is generally **more complex** and useful when immediate processing is important.
