import arcpy

# Initialize the ArcGIS Pro license
arcpy.CheckOutExtension("Spatial")
arcpy.env.overwriteOutput = True

# Parameters for geodatabase creation
db_platform = "POSTGRESQL"  # Database management system
instance = "localhost"  # Replace with the PostgreSQL server address or container name
database = "EGDB"  # Database name (must already exist in PostgreSQL)
auth_type = "DATABASE_AUTH"  # Authentication type
db_admin = "postgres"  # PostgreSQL superuser username
db_admin_password = "postgres"  # PostgreSQL superuser password
gdb_admin = "sde"  # Geodatabase administrator username (will be created if not existing)
gdb_admin_password = "postgres"  # Password for the sde user
auth_file = r"C:path//to//keycodes"  # Path to the ArcGIS Server/Pro authorization file
spatial_type = "ST_GEOMETRY"  # Spatial type for the geodatabase

# Run the Create Enterprise Geodatabase tool
try:
    print("Starting the creation of the Enterprise Geodatabase...")
    arcpy.management.CreateEnterpriseGeodatabase(
        db_platform,  # PostgreSQL
        instance,  # Host or IP address of the PostgreSQL instance
        database,  # PostgreSQL database name
        auth_type,  # Authentication type
        db_admin,  # Database admin username (superuser)
        db_admin_password,  # Database admin password
        "SDE_SCHEMA",  # Schema type for PostgreSQL
        gdb_admin,  # Geodatabase admin username
        gdb_admin_password,  # Geodatabase admin password
        "",  # Leave tablespace empty for PostgreSQL
        auth_file,  # Authorization file (keycodes)
        spatial_type  # Spatial type for geodatabase
    )
    print("Enterprise Geodatabase created successfully!")

except Exception as e:
    print(f"An error occurred: {e}")
    for i in range(arcpy.GetMessageCount()):
        print(arcpy.GetMessage(i))
