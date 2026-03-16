# TechServicesCR - Database Project

This repository contains an academic project developed for **Database I (UNED, 2026)**.  

## 🎯 Objective
Design and implement a relational database model (normalized up to 3NF) to manage technical support requests within an organization. The project includes both the conceptual ERD and the physical implementation in MySQL.

## 📊 Components
- **Entity-Relationship Diagram (Crow’s Foot notation)**  
- **Normalization process (up to 3NF)**  
- **MySQL Workbench creation script**  

## 🗂️ Entities
- **Users**: Employees reporting issues  
- **Technicians**: Staff assigned to solve requests  
- **Service Orders**: Requests with status tracking  
- **Order History**: Updates and actions performed  
- **Equipment**: Inventory of devices  

## 🚀 Usage
To create the database in MySQL:

```bash
mysql -u your_user -p < scripts/create_database.sql
