# Define variables
$containerName = "egdb-dev"
$hostDataDir = "C:\\bin\\postgres\\data"
$dbName = "EGDB"
$dbUser = "postgres"
$dbPassword = "postgres"
$imageName = "patrickfranzelin/postgres-for-geodatabase:latest"

# Run the PostgreSQL container with data persistence
Write-Host "Starting PostgreSQL container with name: $containerName"

docker run -d `
    --name $containerName `
    -e POSTGRES_DB=$dbName `
    -e POSTGRES_USER=$dbUser `
    -e POSTGRES_PASSWORD=$dbPassword `
    -v ${hostDataDir}:/var/lib/postgresql/data `
    -p 5432:5432 `
    --restart unless-stopped `
    $imageName
