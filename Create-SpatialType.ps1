# Variables
$containerName = "egdb-dev"
$dbName = "EGDB"
$dbUser = "postgres"

# Enable PostGIS extension
docker exec -it $containerName psql -U $dbUser -d $dbName -c "CREATE EXTENSION IF NOT EXISTS postgis;"
docker exec -it $containerName psql -U $dbUser -d $dbName -c "LOAD 'st_geometry';"