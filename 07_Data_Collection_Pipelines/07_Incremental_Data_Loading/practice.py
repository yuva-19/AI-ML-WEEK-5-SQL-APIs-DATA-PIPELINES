import pandas as pd
df = pd.read_csv("07_Data_Collection_Pipelines/07_Incremental_Data_Loading/customers.csv")
# 

print(df)

filt = (df['customer_id']>105)

print(df.loc[filt])

print(len(df.loc[filt]))


# Q2 — ID-Based Incremental Loading

last_processed_id = 105

new_data = df[df['customer_id']>last_processed_id]
print(new_data)

last_processed_id = max(df['customer_id'])
new_data = df[df['customer_id']>last_processed_id]
print(new_data)


# Q3 — Timestamp-Based Incremental Loading

last_processed_time = "2026-08-27 00:00:00"

df['updated_at'] = pd.to_datetime(df['updated_at'],format="%Y-%m-%d %H:%M:%S")

print(df[df['updated_at']>last_processed_time])

print(len(df[df['updated_at']>last_processed_time]))


# Q4 — The Important One: New + Updated Records

df = pd.read_csv("07_Data_Collection_Pipelines/07_Incremental_Data_Loading/customers_updated.csv")
df['updated_at'] = pd.to_datetime(df['updated_at'],format="%Y-%m-%d %H:%M:%S")

last_processed_time = "2026-08-27 00:00:00"

filt = (df['updated_at'] > last_processed_time)

changed_data = df.loc[filt]

print(changed_data)
print(len(changed_data))


old_df = pd.read_csv("07_Data_Collection_Pipelines/07_Incremental_Data_Loading/customers.csv")

old_id = old_df['customer_id']

new_records = changed_data[
    ~changed_data['customer_id'].isin(old_id)
]

print("New Records: ")
print(new_records)

filt = (df["updated_at"] > last_processed_time)
changed_data = df.loc[filt]

updated_records = changed_data[
    changed_data['customer_id'].isin(old_id)
]

print(('Updated Records: '))
print(updated_records)

