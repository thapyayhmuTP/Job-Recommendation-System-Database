# Job-Recommendation-System-Database
SQL project for building a job recommendation system with candidate-job matching logic and ML-ready queries.

This repository showcases a **Job Recommendation System** built using **MySQL**, designed to match candidates with the right job opportunities based on skills, experience, and preferences. The project was developed as part of a university course assignment for **CPSC-500-7: SQL Databases**.

## 👥 Teamwork and Contribution

This project was completed in collaboration with my team as part of a group assignment.

- **Team Contribution:**
  - Collaboratively discussed and designed the overall structure.
  - My team members helped generate the data for the dataset.
  - The team also contributed to the creation of **Data Query Language (DQL)** queries.

- **My Responsibilities:**
  - Final decisions on **database schema design**, including tables, attributes, and relationships.
  - Writing and testing all **Data Definition Language (DDL)**, **Data Manipulation Language (DML)**, and **Machine Learning (ML)** queries.
  - Importing datasets into MySQL and resolving data handling issues.
  - Structuring the database to support real-world job matching scenarios.
  - Preparing the repository and documentation for GitHub.

## 📁 Project Structure

- `Jobs.sql`: SQL script to create the database and all tables with constraints.
- `ImportData.sql`: Bulk data import using `LOAD DATA INFILE`.
- `DML_queries.sql`: Real-world insert, update, and delete operations.
- `DQL_queries.sql`: Analytical queries for insights like salary trends and interview patterns.
- `ML_queries.sql`: SQL outputs structured for machine learning tasks (regression, classification, clustering, time series).
- `sample_data/`: Contains `.csv` files used to populate the database.

## 🧠 ML-Ready SQL Outputs

- **Regression:** Predict salary based on experience, education, and skill count.
- **Classification:** Predict candidate qualification based on job requirements.
- **Clustering:** Group candidates by dominant skill sets.
- **Time Series:** Analyze application volume trends over time.

## 🛠 Technologies Used

- MySQL 8.0
- MySQL Workbench
- Microsoft Excel (for CSV generation)
- Optional ML: Python / Jupyter Notebooks

## 📌 Note

This repository only includes the database-related files, SQL queries, and datasets. The full report and personal details have been excluded for privacy and simplicity.
