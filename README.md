# Automobile-Supply-Chain-Management-System

Project Data Source and Preprocessing Information
-------------------------------------------------

Data Source:
------------
- **Dataset URL**: [Supply Chain Management for Car](https://www.kaggle.com/datasets/prashantk93/supply-chain-management-for-car)
- **Description**: This dataset provides comprehensive information related to the supply chain management for car manufacturing. It encompasses various aspects of the supply chain, making it ideal for demonstrating complex SQL queries within our database system.

Data Preprocessing:
-------------------
- **Preprocessing Notebook**: [Google Colab Notebook](https://colab.research.google.com/drive/1Hl2ocgDHfR-BgauiosTObbUIVeFYhX2f?usp=sharing)
- **Description**: Initial data preprocessing was performed using a Python script in a Google Colab notebook. Key preprocessing steps included:
  - **Cleaning**: Removal of unnecessary or corrupt data entries.
  - **Validating**: Assurance that all data adheres to required quality standards for analytical accuracy.
  - **Organizing**: Data was segmented and structured into separate tables to match the relational database schema.

Data Import and Database Setup:
-------------------------------
- **Database System**: PostgreSQL
- **Methodology**:
  - Post-preprocessing, the data was segmented and exported into CSV files, tailored for each specific table according to our database design.
  - These CSV files were then manually loaded into our PostgreSQL database using SQL scripts specifically developed to ensure accurate placement of data within the respective tables.
  - The choice of manual data import was made to ensure stringent control over data insertion, thus preserving the integrity and consistency of data throughout our database system.
