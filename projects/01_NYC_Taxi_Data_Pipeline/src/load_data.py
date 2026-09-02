import pandas as pd
from database import engine
from sqlalchemy import text

file_path = r'projects\01_NYC_Taxi_Data_Pipeline\data\processed'

df = pd.read_parquet(file_path)

print("Data loaded from Parquet")
print("Shape:", df.shape)

# validate dataset is not empty
if df.empty:
    raise ValueError('Dataset is empty')

# Validate required columns
required_columns = [
    "VendorID",
    "tpep_pickup_datetime",
    "tpep_dropoff_datetime",
    "trip_distance",
    "fare_amount",
    "total_amount"
]

missing_columns = [
    col for col in required_columns
    if col not in df.columns
]

if missing_columns:
    raise ValueError(
        f"Missing required columns: {missing_columns}"
    )

# Validate important data types
if not pd.api.types.is_numeric_dtype(df["trip_distance"]):
    raise TypeError("trip_distance must be numeric")

if not pd.api.types.is_numeric_dtype(df["fare_amount"]):
    raise TypeError("fare_amount must be numeric")

if not pd.api.types.is_numeric_dtype(df["total_amount"]):
    raise TypeError("total_amount must be numeric")


# Validate numeric values
if (df["trip_distance"] < 0).any():
    raise ValueError("trip_distance contains negative values")

if (df["fare_amount"] < 0).any():
    raise ValueError("fare_amount contains negative values")

if (df["total_amount"] < 0).any():
    raise ValueError("total_amount contains negative values")



# Create the table structure using the first row
df.head(0).to_sql(
    "taxi_trips",
    engine,
    if_exists="replace",
    index=False
)

print("Table created successfully")


# Insert data in chunks
chunk_size = 50000
total_rows = len(df)

for start in range(0, total_rows, chunk_size):

    end = min(start + chunk_size, total_rows)

    chunk = df.iloc[start:end]

    chunk.to_sql(
        "taxi_trips",
        engine,
        if_exists="append",
        index=False
    )

    print(f"Loaded {end:,} / {total_rows:,} rows")


print("All data loaded successfully into PostgreSQL!")


# Verify loaded row count
with engine.connect() as connection:
    result = connection.execute(
        text("SELECT COUNT(*) FROM taxi_trips")
    )
    loaded_rows = result.scalar()

print("Rows in PostgreSQL:", loaded_rows)

if loaded_rows != total_rows:
    raise ValueError(
        f"Row count mismatch! Expected {total_rows}, "
        f"but found {loaded_rows}"
    )

print("Pipeline verification successful!")