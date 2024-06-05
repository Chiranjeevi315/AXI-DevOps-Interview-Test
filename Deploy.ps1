# Define variables
$AppPath = "C:\super-service\src"
$TestPath = "C:\super-service\test"
$DockerImageName = "super-service-webapi"
$DockerContainerName = "super-service-webapi-container"
$Dockerfile = "$AppPath\Dockerfile"

# Step 1: Run automated tests
Write-Host "Running automated tests..."
dotnet test $TestPath
if ($LASTEXITCODE -ne 0) {
    Write-Host "Tests failed. Continuing deployment..."
} else {
    Write-Host "Tests passed successfully."
}

# Step 2: Package the application as a Docker image
Write-Host "Building Docker image..."
docker build -t $DockerImageName $AppPath
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker build failed. Aborting deployment."
    exit 1
}
Write-Host "Docker image built successfully."

# Step 3: Deploy and run the Docker container locally
Write-Host "Running Docker container..."
docker run -d --name $DockerContainerName -p 80:80 $DockerImageName
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker run failed. Aborting deployment."
    exit 1
}
Write-Host "Docker container is running successfully."

Write-Host "Deployment completed."
