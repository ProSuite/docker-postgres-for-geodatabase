# Variables
$imageName = "patrickfranzelin/postgres-for-geodatabase:latest"

# Build the Docker image
Write-Host "Building the Docker image..."
docker build -t $imageName .

# Push the image to Docker Hub
Write-Host "Pushing the image to Docker Hub..."
docker push $imageName
