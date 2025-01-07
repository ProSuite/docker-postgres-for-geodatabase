# base image for PostgreSQL with PostGIS
from postgis/postgis:15-3.3

# set environment variables
env POSTGRES_USER=postgres
env POSTGRES_PASSWORD=postgres
env POSTGRES_DB=postgres

# copy st_geometry.so library
copy st_geometry.so /usr/lib/postgresql/15/lib/

# expose the default PostgreSQL port
expose 5432

# optional: add custom initialization scripts if needed
copy init-scripts/ /docker-entrypoint-initdb.d/

# start the container
cmd ["postgres"]
