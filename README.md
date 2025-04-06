# Starline and Starline-Stock Project

This project consists of two PHP-based applications: `Starline` and `Starline-Stock`. Both applications are containerized using Docker and share a common network (`starline-network`) to communicate with each other and a MySQL database.

## Project Structure

```
.
├── docker-compose.yml
├── docker/
│   ├── mysql/
│   │   └── init.sql
│   ├── ngnix/
│   │   └── conf.d/
│   │       ├── starline-service.conf
│   │       └── starline-stock.conf
│   └── php/
│       └── Dockerfile
├── Starline/
│   ├── index.php
│   ├── docker-compose.yml
├── starline-stock/
│   ├── index.php
│   ├── docker-compose.yml
```

## How It Works

### 1. MySQL Database
- The `docker-compose.yml` in the root directory sets up a MySQL container.
- The database is initialized using the `init.sql` file located in `docker/mysql/`.
- The database is accessible on port `3306` and is part of the `starline-network`.

### 2. Starline Application
- Located in the `Starline/` directory.
- The `index.php` file contains the application logic, including an endpoint to fetch data from the `users` table in the `starline_service_db` database.
- The `docker-compose.yml` in the `Starline/` directory sets up the application container using the common `Dockerfile` from `docker/php` and connects it to the `starline-network`.
- Accessible on port `80`.

### 3. Starline-Stock Application
- Located in the `starline-stock/` directory.
- The `index.php` file contains the application logic, including an endpoint to fetch data from the `products` table in the `starline_stock_db` database.
- The `docker-compose.yml` in the `starline-stock/` directory sets up the application container using the common `Dockerfile` from `docker/php` and connects it to the `starline-network`.
- Accessible on port `3001`.

### 4. Nginx Configuration
- The `docker/ngnix/conf.d/` directory contains configuration files for Nginx.
- These files are used to route traffic to the `Starline` and `Starline-Stock` applications.

## Steps to Run the Project

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Create the External Network**

   Before running the services, ensure the `starline-network` is created as an external network. Run the following command:

   ```bash
   docker network create starline-network
   ```

   This step is required to avoid errors when starting the containers.

3. **Start the MySQL Database**
   ```bash
   docker-compose up -d mysql
   ```

4. **Start the Starline Application**
   ```bash
   cd Starline
   docker-compose up -d
   ```

5. **Start the Starline-Stock Application**
   ```bash
   cd ../starline-stock
   docker-compose up -d
   ```

6. **Access the Applications**
   - Starline: [http://localhost:80](http://localhost:80)
   - Starline-Stock: [http://localhost:3001](http://localhost:3001)

7. **Verify Database Connection**
   - Ensure the `users` table in `starline_service_db` and the `products` table in `starline_stock_db` are accessible via the respective endpoints.

## Rebuilding and Restarting the Application

If you make changes to the application code, Dockerfiles, or any configuration files, you may need to rebuild and restart the containers to apply the changes.

### Steps to Rebuild and Restart

1. **Stop the Running Containers**
   ```bash
   docker-compose down
   ```

2. **Rebuild the Containers**
   Navigate to the respective application directories and rebuild the containers:
   - For the `Starline` application:
     ```bash
     cd Starline
     docker-compose up --build -d
     ```
   - For the `Starline-Stock` application:
     ```bash
     cd ../starline-stock
     docker-compose up --build -d
     ```

3. **Verify the Applications**
   - Ensure the applications are running by accessing their endpoints:
     - `Starline`: [http://localhost:80/users](http://localhost:80/users)
     - `Starline-Stock`: [http://localhost:3001/products](http://localhost:3001/products)

4. **Check Logs (Optional)**
   If you encounter any issues, check the container logs for debugging:
   ```bash
   docker logs <container-name>
   ```

## API Endpoints

### Starline Application
- **Endpoint to access users**:
  - URL: `http://localhost:80/users`
  - Method: `GET`
  - Description: Fetches all data from the `users` table in the `starline_service_db` database.

### Starline-Stock Application
- **Endpoint to access products**:
  - URL: `http://localhost:3001/products`
  - Method: `GET`
  - Description: Fetches all data from the `products` table in the `starline_stock_db` database.

## Notes
- Ensure Docker and Docker Compose are installed on your system.
- The `starline-network` must be created as an external network before running the services:
  ```bash
  docker network create starline-network
  ```
- Modify the `init.sql` file to customize the database schema and initial data.

## Troubleshooting
- Check container logs for errors:
  ```bash
  docker logs <container-name>
  ```
- Ensure the `starline-network` is active and properly configured.

## Testing the Project When Issues Arise

If you encounter issues while running the project, follow these steps to test and debug:

1. **Check Container Status**
   ```bash
   docker ps -a
   ```
   Ensure all required containers (`mysql`, `starline`, `starline-stock`) are running.

2. **Check Logs**
   - For the `Starline` application:
     ```bash
     docker logs starline
     ```
   - For the `Starline-Stock` application:
     ```bash
     docker logs starline-stock
     ```
   - For the MySQL database:
     ```bash
     docker logs mysql
     ```

3. **Verify Network Configuration**
   Ensure the `starline-network` is active:
   ```bash
   docker network ls
   ```
   If the network is missing, recreate it:
   ```bash
   docker network create starline-network
   ```

4. **Test Database Connectivity**
   Access the MySQL container and verify the databases and tables:
   ```bash
   docker exec -it mysql mysql -u root -p
   ```
   Use the following commands inside the MySQL shell:
   ```sql
   SHOW DATABASES;
   USE starline_service_db;
   SHOW TABLES;
   SELECT * FROM users;
   USE starline_stock_db;
   SHOW TABLES;
   SELECT * FROM products;
   ```

5. **Test API Endpoints**
   Use tools like `curl` or Postman to test the endpoints:
   - For the `Starline` application:
     ```bash
     curl http://localhost:80/users
     ```
   - For the `Starline-Stock` application:
     ```bash
     curl http://localhost:3001/products
     ```

6. **Rebuild and Restart Containers**
   If issues persist, rebuild the containers:
   ```bash
   docker-compose down
   docker-compose up --build -d
   ```

7. **Check File Permissions**
   Ensure the mounted files have the correct permissions:
   ```bash
   chmod -R 775 ./Starline
   chmod -R 775 ./starline-stock
   ```

8. **Validate Configuration Files**
   Verify the `docker-compose.yml` and Nginx configuration files for errors.