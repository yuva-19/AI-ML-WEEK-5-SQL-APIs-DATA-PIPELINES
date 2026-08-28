# Automation — Notes

## 1. What is Automation?

**Automation** means making a task run **automatically without manually executing it every time**.

Instead of:

```text
You → Run Python script → Pipeline executes
```

Automation does:

```text
Scheduler
    ↓
Python script
    ↓
Pipeline executes
```

---

## 2. Scheduled Python Jobs

A **scheduled Python job** is a Python program that runs automatically at a specific time or interval.

Examples:

- Run a data pipeline every morning.
- Fetch API data every hour.
- Update a database every night.
- Generate a report every day.

Example Python script:

```python
from datetime import datetime

print("Pipeline executed!")
print(datetime.now())
```

---

# 3. Windows Task Scheduler

On Windows, **Task Scheduler** can automatically execute programs at scheduled times.

Basic workflow:

```text
Task Scheduler
      ↓
Runs Python
      ↓
pipeline.py
      ↓
Data processing
```

You can configure:

- **When** the task runs
- **What** program runs
- How frequently it repeats

---

# 4. `.bat` Files

A `.bat` (batch) file contains Windows commands that can be executed automatically.

Example:

```bat
cd /d "Y:\Python\AI ML\Month 2\week 5-SQL APIs Data Pipelines\07_Data_Collection_Pipelines\13_Automation"

python pipeline.py
```

### What happens?

```text
cd /d ...
    ↓
Move to the required folder
    ↓
python pipeline.py
    ↓
Execute the Python pipeline
```

A scheduler can run the `.bat` file instead of directly dealing with the Python script.

---

# 5. Logging Pipeline Execution

When a pipeline runs automatically, `print()` output may not be visible because there is no interactive terminal.

Therefore, pipelines often **write execution information to a log file**.

Example:

```python
from pathlib import Path
from datetime import datetime

log_file = Path(__file__).parent / "pipeline_log.txt"

with open(log_file, "a") as file:
    file.write(f"Pipeline executed! {datetime.now()}\n")
```

Output:

```text
Pipeline executed! 2026-08-28 12:40:10
Pipeline executed! 2026-08-28 12:41:10
Pipeline executed! 2026-08-28 12:42:10
```

`"a"` means **append**, so previous logs are preserved.

---

# 6. `Path(__file__)`

```python
Path(__file__)
```

refers to the location of the **current Python file**.

```python
Path(__file__).parent
```

refers to the folder containing the Python file.

Therefore:

```python
log_file = Path(__file__).parent / "pipeline_log.txt"
```

means:

> Create/use `pipeline_log.txt` in the same folder as the Python script.

This is better than hardcoding:

```python
"Y:/Python/AI ML/Month 2/..."
```

because the code becomes more portable.

---

# 7. Relative vs Absolute Paths

### Absolute path

Contains the complete location:

```text
Y:\Python\AI ML\Month 2\week 5-SQL APIs Data Pipelines\...
```

### Relative path

Depends on the current working directory:

```python
"pipeline_log.txt"
```

The file is created relative to where the program is currently running.

### Safer approach for scripts

```python
Path(__file__).parent / "pipeline_log.txt"
```

This finds the file relative to the Python script itself.

---

# 8. Automation Pipeline Example

A simple automated data pipeline can look like:

```text
        Scheduler
            ↓
      run_pipeline.bat
            ↓
       pipeline.py
            ↓
    Extract / Process Data
            ↓
       Validate Data
            ↓
        Save Results
            ↓
       Write Log File
```

---

# 9. Why Automation Is Important in Data Engineering / ML

Without automation:

```text
Every day:
You → manually run script
```

With automation:

```text
Every day:
Scheduler → automatically runs script
```

This makes pipelines:

- **Consistent**
- **Repeatable**
- **Less dependent on manual work**
- **Easier to operate**
- **Suitable for production workflows**

---

## Key Points to Remember 🧠

```text
Automation
    = Run tasks automatically

Task Scheduler
    = Windows scheduling tool

.bat
    = Windows batch script

Path(__file__)
    = Location of current Python file

"a"
    = Append to existing file

Logging
    = Keep a record of pipeline execution
```

### Core concept

> **Automation = Scheduler + Script + Output/Logging**
