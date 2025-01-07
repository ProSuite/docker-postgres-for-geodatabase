# base image for PostgreSQL with PostGIS
from postgis/postgis:15-3.3

# set environment variables
env POSTGRES_USER=postgres
env POSTGRES_PASSWORD=postgres
env POSTGRES_DB=postgres

# Define an argument to pass the host path to st_geometry.so
arg HOST_ST_GEOMETRY_PATH= "C:\Users\jpfra\Downloads\ArcGISPro_34_ST_Geometry_PostgreSQL_192933\PostgreSQL\15\Linux64\st_geometry.so"

# Copy the st_geometry.so file to the correct location in the container
copy ${HOST_ST_GEOMETRY_PATH} /usr/lib/postgresql/15/lib/

# expose the default PostgreSQL port
expose 5432

# optional: add custom initialization scripts if needed
copy init-scripts/ /docker-entrypoint-initdb.d/

# start the container
cmd ["postgres"]
