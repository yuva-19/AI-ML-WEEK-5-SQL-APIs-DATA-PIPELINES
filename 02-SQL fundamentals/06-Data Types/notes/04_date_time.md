# DATE, TIME and TIMESTAMP

## DATE

DATE stores a calendar date.

Example:

birth_date DATE

Example value:

2026-08-18

Format:

YYYY-MM-DD

DATE does not store the time of day.

## TIME

TIME stores the time of day.

Example:

login_time TIME

Example value:

21:30:45

TIME does not store the calendar date.

## TIMESTAMP

TIMESTAMP stores both date and time.

Example:

created_at TIMESTAMP

Example value:

2026-08-18 21:30:45

## Comparison

DATE:
Date only

TIME:
Time only

TIMESTAMP:
Date + time

## AI/ML Relevance

Date and time fields are common in real-world datasets.

A TIMESTAMP can be used to derive features such as:

- Year
- Month
- Day
- Hour
- Day of week
- Time since an event

These can be useful during feature engineering.