# Variables
$containerName = "egdb-dev"
$dbName = "EGDB"
$dbUser = "postgres"
$dbPassword = "postgres"

# Run SQL to create a database
docker exec -it $containerName psql -U $dbUser -c "CREATE DATABASE $dbName;"
