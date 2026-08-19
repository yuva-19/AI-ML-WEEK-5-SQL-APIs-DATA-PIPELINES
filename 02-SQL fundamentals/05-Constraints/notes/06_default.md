# DEFAULT Constraint

DEFAULT automatically provides a value when no value is
specified during INSERT.

Example:

department VARCHAR(50) DEFAULT 'EEE'

If department is not provided:

department → EEE

Example:

status VARCHAR(20) DEFAULT 'active'

If status is not provided:

status → active

DEFAULT does not necessarily prevent NULL.

To prevent NULL and provide a default:

department VARCHAR(50) NOT NULL DEFAULT 'EEE'

## Common Uses

DEFAULT is useful for:

- Status
- Created date
- Department
- Boolean flags
- Counters

Example:

status VARCHAR(20) DEFAULT 'active'