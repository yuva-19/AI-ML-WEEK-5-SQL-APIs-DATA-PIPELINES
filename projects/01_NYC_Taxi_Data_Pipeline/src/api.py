from fastapi import FastAPI, HTTPException, Query
from typing import Optional
from pydantic import BaseModel
from database import engine
from sqlalchemy import text

app = FastAPI()

# Create your first endpoint
@app.get('/')
def home():
    return {
        'message' : 'NYC Taxi API is running'
    }

# HTTP methods + GET routes.
@app.get('/health')
def health_check():
    return{
        'status' : 'API is running'
    }


# Query Parameters.
@app.get('/trips')
def get_trips(
    limit : int = Query(10, ge=1, le=100),
    offset : int = Query(0,ge=0)
):
    query = text("""
        SELECT
             "VendorID",
             passenger_count,
             trip_distance,
             fare_amount,
             total_amount
        FROM taxi_trips
        LIMIT :limit
        OFFSET :offset
    """)

    with engine.connect() as connection:
        result = connection.execute(
            query,
            {'limit' : limit,
             'offset' : offset}
        )

        rows = result.mappings().all()

    return rows

# http://127.0.0.1:8000/trips will give you limit:10
# http://127.0.0.1:8000/trips?limit=5 will give you limit:5
#  http://127.0.0.1:8000/trips?limit=5&offset=10
# http://127.0.0.1:8000/trips?limit=-5 -->this will return validation error 422 coz its not in the limit


# Multiple Query Parameters

@app.get("/trips/filter")
def filter_trips(
    limit: int = Query(0,ge=0,le=100),
    offset: int = Query(0,ge=0),
    payment_type: Optional[int] = None
):
    if payment_type is None:
        query = text("""
            SELECT
                 "VendorID",
                 payment_type,
                 trip_distance,
                 fare_amount,
                 total_amount
            FROM taxi_trips
            LIMIT :limit
            OFFSET :offset
        """)

        params = {
            'limit' : limit,
            'offset' : offset
        }

    else:
        query = text("""
            SELECT
                 "VendorID",
                 payment_type,
                 trip_distance,
                 fare_amount,
                 total_amount
            FROM taxi_trips
            WHERE payment_type = :payment_type
            LIMIT :limit
            OFFSET :offset
        """)

        params = {
            'limit' : limit,
            'offset' : offset,
            'payment_type' : payment_type
        }

    with engine.connect() as connection:
        result = connection.execute(query,params)
        rows = result.mappings().all()

    return rows

# http://127.0.0.1:8000/trips/filter
# http://127.0.0.1:8000/trips/filter?limit=5&payment_type=1
# http://127.0.0.1:8000/trips/filter?limit=5&payment_type=1&offset=5



# JSON Request Body + POST
class Trip(BaseModel):
    passenger_count: int
    trip_distance: float
    fare_amount: float

@app.post('/trips', status_code=201)
def create_trip(trip: Trip):
    query= text("""
        INSERT INTO taxi_trips (
            passenger_count,
            trip_distance,
            fare_amount
        )
        VALUES(
            :passenger_count,
            :trip_distance,
            :fare_amount
        )
    """)

    with engine.begin() as connection:
        connection.execute(
            query,
            {
                'passenger_count' : trip.passenger_count,
                'trip_distance' : trip.trip_distance,
                'fare_amount' : trip.fare_amount
            }
        )

    return{
        'message' : 'Trip Created Successfully',
        'trip' : trip
    }
# http://127.0.0.1:8000/docs

@app.get('/db-test')
def database_test():
    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1"))
        value = result.scalar()

    return{
        'database' : 'connected',
        'test' : value
    }
# http://127.0.0.1:8000/db-test


# Read REAL taxi data

@app.get("/trips/data")
def get_trip_data():
    query = text("""
        SELECT *
        FROM taxi_trips
        LIMIT 5
    """)

    with engine.connect() as connection:
        result = connection.execute(query)
        rows = result.mappings().all()

    return rows

# http://127.0.0.1:8000/trips/data


# useful analytics 
@app.get("/trips/payment-summary")
def payment_summary():

    query = text("""
        SELECT
            payment_type,
            COUNT(*) AS trip_count
        FROM taxi_trips
        GROUP BY payment_type
        ORDER BY payment_type
    """)

    with engine.connect() as connection:
        result = connection.execute(query)
        rows = result.mappings().all()

    return rows

# http://127.0.0.1:8000/trips/payment-summary

# Overall Trip Summary
@app.get("/trips/summary")
def trip_summary():

    query = text("""
        SELECT
            COUNT(*) AS total_trips,
            ROUND(AVG(trip_distance)::numeric, 2) AS avg_distance,
            ROUND(AVG(fare_amount)::numeric, 2) AS avg_fare,
            ROUND(AVG(total_amount)::numeric, 2) AS avg_total_amount
        FROM taxi_trips
    """)

    with engine.connect() as connection:
        result = connection.execute(query)
        row = result.mappings().first()

    return row
# http://127.0.0.1:8000/trips/summary

# date-based filter
@app.get("/trips/date")
def trips_by_date(
    start_date: str,
    end_date: str,
    limit: int = Query(10, ge=1, le=100)
):
    query = text("""
        SELECT
            "VendorID",
            tpep_pickup_datetime,
            tpep_dropoff_datetime,
            passenger_count,
            trip_distance,
            fare_amount,
            total_amount
        FROM taxi_trips
        WHERE tpep_pickup_datetime >= :start_date
          AND tpep_pickup_datetime < :end_date
        ORDER BY tpep_pickup_datetime
        LIMIT :limit
    """)

    with engine.connect() as connection:
        result = connection.execute(
            query,
            {
                "start_date": start_date,
                "end_date": end_date,
                "limit": limit
            }
        )

        rows = result.mappings().all()

    return rows
# http://127.0.0.1:8000/trips/date?start_date=2026-01-01&end_date=2026-01-02&limit=10

# Path Parameters
@app.get('/trips/{trip_id}')
def get_trip(trip_id: int):
    if trip_id<1:
        raise HTTPException(
            status_code=404,
            detail='Trip not Found'
        )
    
    query = text("""
        SELECT *
        FROM taxi_trips
        OFFSET :trip_id
        LIMIT 1
    """)

    with engine.connect() as connection:
        result = connection.execute(
            query,
            {'trip_id' : trip_id }
        )

        row = result.mappings().first()

    if row is None:
        raise HTTPException(
            status_code= 404,
            detail= 'Trip not Found'
        )

    return row

# http://127.0.0.1:8000/trips/-1
# http://127.0.0.1:8000/trips/5
# http://127.0.0.1:8000/trips/99999999


# http://127.0.0.1:8000/docs