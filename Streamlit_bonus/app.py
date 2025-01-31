import streamlit as st
import pandas as pd
import psycopg2
import os

st.set_option('deprecation.showfileUploaderEncoding', False)

# Securely fetch credentials from environment variables
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_DATABASE = os.getenv("DB_DATABASE", "carsupplychain")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD",'Devendra@9900')

if not DB_PASSWORD:
    st.error("Database password not set in environment variables.")
    st.stop()

# Establish connection to PostgreSQL
# @st.cache_data
def get_connection():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            database=DB_DATABASE,
            user=DB_USER,
            password=DB_PASSWORD
        )
        return conn
    except psycopg2.Error as e:
        st.error('Failed to connect to the database: ' + str(e))
        st.stop()
@st.cache_data
# Fetch supplier data for given car make and model
def get_suppliers_by_car(carmaker, carmodel):
    conn = get_connection()
    query = """
    SELECT s.SupplierName, s.SupplierContactDetails, sa.City, sa.State, sa.Country
    FROM Supplier s
    JOIN Product p ON s.SupplierID = p.SupplierID
    JOIN SupplierAddress sa ON s.SupplierID = sa.SupplierID
    WHERE p.CarMaker = %s AND p.CarModel = %s;
    """
    df = pd.read_sql(query, conn, params=(carmaker, carmodel))
    # conn.close()
    return df
@st.cache_data
# Fetch customer data for given car make and model
def get_customers_by_car(carmaker, carmodel):
    conn = get_connection()
    query = """
    SELECT c.CustomerName, c.Gender, ci.PhoneNumber, ca.City, ca.State, ca.Country
    FROM Customer c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetail od ON o.OrderID = od.OrderID
    JOIN Product p ON od.ProductID = p.ProductID
    JOIN ContactInfo ci ON c.CustomerID = ci.CustomerID
    JOIN CustomerAddress ca ON c.CustomerID = ca.CustomerID
    WHERE p.CarMaker = %s AND p.CarModel = %s;
    """
    df = pd.read_sql(query, conn, params=(carmaker, carmodel))
    # conn.close()
    return df
@st.cache_data
# Fetch distinct car makers from the database
def get_car_makers():
    conn = get_connection()
    df = pd.read_sql("SELECT DISTINCT CarMaker FROM Product ORDER BY CarMaker;", conn)
    # conn.close()
    return df['carmaker'].unique()
@st.cache_data
# Fetch car models for a specific car maker
def get_car_models(carmaker):
    conn = get_connection()
    query = "SELECT DISTINCT CarModel FROM Product WHERE CarMaker = %s ORDER BY CarModel;"
    df = pd.read_sql(query, conn, params=[carmaker])
    # conn.close()
    return df['carmodel'].unique()

car_makers = get_car_makers()

tab1, tab2 = st.tabs(["Customers", "Suppliers"])

with tab1:
    st.header("Find Suppliers by Car")
    car_maker = st.selectbox("Choose Car Maker", car_makers, key="maker1")
    car_models = get_car_models(car_maker)  # Fetch models based on selected maker
    car_model = st.selectbox("Choose Car Model", car_models, key="model1")
    if st.button("Search Suppliers"):
        suppliers_data = get_suppliers_by_car(car_maker, car_model)
        if not suppliers_data.empty:
            st.table(suppliers_data)
        else:
            st.error("No suppliers found for the specified car.")

with tab2:
    st.header("Find Customers by Car")
    car_maker = st.selectbox("Choose Car Maker", car_makers, key="maker2")
    car_models = get_car_models(car_maker)  # Fetch models based on selected maker
    car_model = st.selectbox("Choose Car Model", car_models, key="model2")
    if st.button("Search Customers"):
        st.balloons()
        customers_data = get_customers_by_car(car_maker, car_model)
        if not customers_data.empty:
            st.table(customers_data)
        else:
            st.error("No customers found for the specified car.")
