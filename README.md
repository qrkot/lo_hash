# Intro
A user-defined Python function for PostgreSQL to calculate hashes of very large objects.


## Installation
- Install an appropriate `plpython` package for Postgres, e.g. `dnf install postgresql15-plpython3`;
- Clone the repository: `git clone https://github.com/qrkot/lo_hash.git`;
- Create the `plpython` extension in psql: `create extension plpython3u`;
- Import the function: `\i /path/to/lo_hash/lo_hash_py.sql`.

## Usage
`select lo_hash(LARGE_OBJECT_ID, HASH_TYPE);`

## Copyright and licence.
The code is taken from (Postgres mailing lists)[https://www.postgresql.org/message-id/2099704620.64179.1690649864815%40office.mailbox.org] and licenced under PostgreSQL licence, as per (PostgreSQL archive policy)[https://www.postgresql.org/about/policies/archives/].
