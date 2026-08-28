import pandas as pd
import numpy as np
# Q1 — Schema Validation
# Read the CSV into Pandas.
# Expected schema:
# customer_id → integer
# name        → string
# age         → integer
# salary      → integer/float
# city        → string
# status      → string
# start_date  → date
# end_date    → date
# Your tasks:
# 1. Print the columns.
# 2. Print the data types.
# 3. Create a list containing the expected columns.
# 4. Check whether any expected columns are missing.
# 5. Check whether there are unexpected extra columns.
# 6. Check whether the important columns have the expected data types.
# Don't fix anything yet.
# Your job is only to detect and report problems.

df = pd.read_csv('07_Data_Collection_Pipelines/05_Data_Validation/data_validation_practice.csv')
print(df.columns)
print()
print(df.dtypes)

expected_columns = ['customer_id', 'name', 'age', 'salary', 'city', 'status', 'start_date','end_date']

extra_columns = []
missing_columns = []

for column in df.columns:
    if column not in expected_columns:
        extra_columns.append(column)

for column in expected_columns:
    if column not in df.columns:
        missing_columns.append(column)


print("Extra columns are: ",extra_columns)
print("Missing columns are: ",missing_columns)

# age must be int & status must be category start and end dates must be in date time format



# 🔥 Q2 — Business Rules + Consistency
# Using the same dataset, validate these rules:
# Rule 1 — Age
# Customer must be:
# 18 <= age <= 120
# Find the invalid records.
# Rule 2 — Salary
# Salary cannot be negative:
# salary >= 0
# Find invalid records.
# Rule 3 — Status
# Allowed statuses are:
# ["active", "inactive", "premium"]
# Find unexpected values.
# Rule 4 — Dates
# end_date cannot be earlier than start_date.
# end_date >= start_date
# Find inconsistent records.
# Rule 5 — Required fields
# customer_id and name should not be missing.
# Find those records.


df['age'] = df['age'].replace('thirty-two',32)
df['age'] = df['age'].replace('Nan',np.nan)

df['age'] = pd.to_numeric(df['age'], errors='coerce').astype('Int64')
print(df)
print()

# age filter
age_filt = (df['age']>=18) & (df['age']<=120)
print(df.loc[~age_filt])
print()

# salary filter
salary_filt = (df['salary']>0)
print(df.loc[~salary_filt])
print()

# status filter
allowed_status =["active", "inactive", "premium"]
print(df[~df['status'].isin(allowed_status)])
print()

# date filter
df['start_date'] = pd.to_datetime(df['start_date'],format="%Y-%m-%d")
df['end_date'] = pd.to_datetime(df['end_date'],format="%Y-%m-%d")

date_fitler = (df['end_date']>=df['start_date'])

print(df.loc[~date_fitler])
print()

# name and customer_id filter

df['name'] = df['name'].replace(['nan','NaN'],np.nan)

name_filter = (df['name'].notna())
id_filter = (df['customer_id'].notna())

print(df.loc[~name_filter])
print(df.loc[~id_filter])

# Q3 — Production-Style Validation Report
# Now combine everything.
# Create a validation program that produces something like:
# ========== DATA VALIDATION REPORT ==========

# Missing Values:
# customer_id    → 0
# name           → 1
# age            → 1
# ...

# Duplicate Records:
# → 1

# Invalid Ages:
# → 1

# Invalid Salaries:
# → 1

# Unexpected Status:
# → 1

# Invalid Dates:
# → 1

# Missing Required Fields:
# → 1

print("Missing_values_in_each_column")
print(df.isna().sum())
print()

print("Duplicate Records: ",(df.duplicated()).sum())
print()

print("Invalid Ages: ",len(df.loc[~age_filt]))

print("Unexpected Status: ",len(df[~df['status'].isin(allowed_status)]))

print("Invalid Dates: ",len(df[~df['status'].isin(allowed_status)]))

print("Invalid Salaries: ",len(df.loc[~salary_filt]))

print("Missing Required Fields: ",len(df.loc[~name_filter]) + len(df.loc[~id_filter]))