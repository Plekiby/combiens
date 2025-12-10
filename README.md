# Combiens - Real Estate AI Agent

A Docker-based development environment for a Real Estate AI Agent using n8n and MySQL.

## Overview

This project provides a complete Docker setup with:
- **MySQL 8.0**: Database for storing real estate property data
- **n8n**: Workflow automation platform for AI agent orchestration

## Prerequisites

- Docker installed on your system
- Docker Compose installed (usually included with Docker Desktop)

## Getting Started

### 1. Start the Environment

Run the following command to start all services:

```bash
docker-compose up
```

To run in detached mode (background):

```bash
docker-compose up -d
```

### 2. Access n8n

Once the containers are running, open your browser and navigate to:

```
http://localhost:5678
```

n8n will be ready to use without authentication (for development purposes).

### 3. Connect n8n to MySQL

To connect n8n workflows to the MySQL database:

1. In n8n, create a new workflow or open an existing one
2. Add a **MySQL** node to your workflow
3. Configure the credentials with these settings:
   - **Host**: `mysql` (or `localhost` if connecting from host machine)
   - **Database**: `combiens`
   - **User**: `root`
   - **Password**: `root`
   - **Port**: `3306`

### 4. Database Schema

The `biens` table is automatically created with the following structure:

```sql
CREATE TABLE biens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    rent DECIMAL(10, 2),
    private_info TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## Managing the Environment

### Stop the Environment

```bash
docker-compose down
```

### Stop and Remove All Data

To stop the containers and remove all volumes (this will delete all data):

```bash
docker-compose down -v
```

### View Logs

To view logs from all services:

```bash
docker-compose logs -f
```

To view logs from a specific service:

```bash
docker-compose logs -f n8n
docker-compose logs -f mysql
```

### Connect to MySQL from Host

You can connect to MySQL from your host machine using any MySQL client:

```bash
mysql -h 127.0.0.1 -P 3306 -u root -proot combiens
```

Or use a GUI tool like MySQL Workbench, DBeaver, or phpMyAdmin with:
- Host: `127.0.0.1`
- Port: `3306`
- User: `root`
- Password: `root`
- Database: `combiens`

## Project Structure

```
.
├── docker-compose.yml    # Docker Compose configuration
├── init.sql             # MySQL initialization script
└── README.md            # This file
```

## Persistent Data

All data is persisted in Docker volumes:
- `mysql_data`: MySQL database files
- `n8n_data`: n8n workflows and configuration

These volumes persist even when containers are stopped, ensuring your data is not lost.

## Troubleshooting

### Port Already in Use

If you get an error that port 3306 or 5678 is already in use, you can either:
1. Stop the service using that port
2. Change the port mapping in `docker-compose.yml`:
   - For MySQL: Change `"3306:3306"` to `"3307:3306"` (or any other free port)
   - For n8n: Change `"5678:5678"` to `"5679:5678"` (or any other free port)

### MySQL Connection Issues

If n8n cannot connect to MySQL, ensure:
1. The MySQL container is healthy: `docker-compose ps`
2. The MySQL service has finished initializing: `docker-compose logs mysql`
3. You're using `mysql` as the hostname (not `localhost`) when connecting from n8n

## Development

This is a development environment. For production use, consider:
- Using strong passwords and securing credentials
- Enabling authentication for n8n
- Using environment variables for sensitive data
- Setting up proper backup strategies
- Implementing network security measures