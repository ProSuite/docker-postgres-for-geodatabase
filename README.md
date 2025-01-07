# Docker-Postgres-for-Geodatabase

This repository provides tools to create an Esri Enterprise Geodatabase in Docker based on a PostgreSQL/PostGIS image. The setup supports SQL access using PostGIS spatial functions and Esri's `st_geometry` spatial type.

## Features

- Build a Docker image with PostgreSQL/PostGIS and Esri's `st_geometry` library.
- Create and configure a Esri Enterprise geodatabase inside a container.
---

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- PostgreSQL with PostGIS (PostGIS is included in the Docker image).
- ArcGIS installation files for the `st_geometry` library (`st_geometry.so` for Linux or `st_geometry.dll` for Windows).

---

## Contents

### Scripts

1. **`Build-Image.ps1`**: Automates the Docker image build process.
2. **`Run-Container.ps1`**: Starts the PostgreSQL container with the configured settings.
3. **`Create-SpatialType.ps1`**: Configures spatial extensions like `postgis` and `st_geometry`.
4. **`Create-ArcGIS-Enterprise-Geodatabase.py`**: Creates an Esri Enterprise Geodatabase using ArcGIS Python tools.

### Files

- **Dockerfile**: Specifies the image setup with `st_geometry` and initialization scripts.
- **`st_geometry.so`**: The Esri spatial library (to be added manually).
- Go to https://my.esri.com > Downloads > ArcGIS Pro
   - Scroll down to ArcGIS Pro ST_Geometry Libraries (Oracle)
   - Click Download to get a Zip archive that contains st_shapelib for Windows, Linux, and others
   - My Esri often changes, so be prepared to spend some time searching
   - You can specifie the path where the st_geometry file lies in the dockerfile
-  You will need to specifie the location to your **keycode** file.
---

## Setup Instructions

### 1. Build the Docker Image

Use the `Build-Image.ps1` script to create a Docker image:

```powershell
.\Build-Image.ps1
```
#### Adjustable Parameters:
- `POSTGRES_PASSWORD`: Password for the PostgreSQL database superuser.
- `POSTGRES_DB`: Default database name.
- `POSTGRES_USER`: Default database user (superuser).
#### Required Adjustments:
Ensure the `st_geometry.so` file is present in the same directory as the `Dockerfile`.

### 2. Start Docker Container
Use the `Run-Container.ps1` to start up the docker containere:

```powershell
.\Run-Container.ps1
```
#### Adjustable Parameters:
- `containerName`: The name of the Docker container.
- `hostDataDir`: Path on your host machine to store PostgreSQL data persistently.
- `dbName`: Name of the database to be created.
- `dbUser`: The PostgreSQL superuser name.
- `dbPassword`: Password for the PostgreSQL superuser.
-  `imageName` : 

### 3. Create Geodatabase

Use the `Create-SpatialType.ps1` to configures spatial extensions
```powershell
.\Create-SpatialType.ps1
```
#### Adjustable Parameters:
- `containerName`: The name of the Docker container.
- `dbName`: Name of the database to be created.
- `dbUser`: The PostgreSQL superuser name.
- `dbPassword`: Password for the PostgreSQL superuser.

### 4. Create ArcGIS Enterprise Geodatabase
```powershell
python .\Create-ArcGIS-Enterprise-Geodatabase.py
```
The path to your keyfile (`auth_file`)  need to be updated.
-------------------------------------------------------------------------------------------------------------------------------------
## If you get a problem regarding the spatial_type:

### Copy `st_geometry` to the Docker Container

After building and running the Docker container, you need to copy the `st_geometry` library into the container. Follow these steps:

1. **Locate the `st_geometry` library**  
   Ensure you have the correct version of `st_geometry.so` for your PostgreSQL version. You can obtain this file from your ArcGIS installation under the appropriate folder for PostgreSQL.

2. **Copy the library into the container**  
   Use the `docker cp` command to copy the library into the correct directory within the container:
   ```powershell
   docker cp "C:\path\to\st_geometry.so" <container_name>:/usr/lib/postgresql/15/lib/st_geometry.so
   ```

3. **Set proper permissions for the library**  
   Once copied, log into the container and set the correct permissions:
   ```bash
   docker exec -it <container_name> bash
   chmod 755 /usr/lib/postgresql/15/lib/st_geometry.so
   ```

4. **Update `postgresql.conf`**  
   Ensure that the `shared_preload_libraries` parameter in your PostgreSQL configuration file (`postgresql.conf`) includes the `st_geometry` library:
   ```bash
   nano /etc/postgresql/15/main/postgresql.conf
   ```
   Add or update:
   ```
   shared_preload_libraries = 'st_geometry'
   ```

5. **Restart the PostgreSQL service**  
   To apply the changes, restart the PostgreSQL service inside the container:
   ```bash
   service postgresql restart
   ```

6. **Verify the `st_geometry` library is loaded**  
   Log into the PostgreSQL instance and load the library to confirm:
   ```sql
   psql -U postgres -d EGDB
   LOAD 'st_geometry';
   ```