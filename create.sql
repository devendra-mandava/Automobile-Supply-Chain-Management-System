DROP TABLE IF EXISTS CustomerFeedback;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS CustomerAddress;
DROP TABLE IF EXISTS ContactInfo;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS CarDetail;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS SupplierAddress;
DROP TABLE IF EXISTS Supplier;

-- Creating the Supplier table
CREATE TABLE Supplier (
    SupplierID SERIAL PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    SupplierContactDetails TEXT
);

-- Creating the SupplierAddress table
CREATE TABLE SupplierAddress (
    AddressID SERIAL PRIMARY KEY,
    SupplierID INTEGER NOT NULL,
    SupplierAddress TEXT NOT NULL,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Creating the Product table
CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    CarMaker VARCHAR(100) NOT NULL,
    CarModel VARCHAR(100) NOT NULL,
    CarPrice DECIMAL NOT NULL,
    SupplierID INTEGER NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Creating the CarDetail table
CREATE TABLE CarDetail (
    CarDetailID SERIAL PRIMARY KEY,
    ProductID INTEGER NOT NULL,
    CarColor VARCHAR(50),
    CarModelYear INTEGER,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Creating the Customer table
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    JobTitle VARCHAR(100)
);

-- Creating the ContactInfo table
CREATE TABLE ContactInfo (
    ContactID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    PhoneNumber VARCHAR(20),
    EmailAddress VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Creating the CustomerAddress table
CREATE TABLE CustomerAddress (
    CustomerAddressID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    CustomerAddress TEXT NOT NULL,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Creating the Order table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    ShipDate DATE,
    ShipMode VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Creating the OrderDetail table
CREATE TABLE OrderDetail (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL,
    Sales DECIMAL,
    Discount DECIMAL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Creating the Payment table
CREATE TABLE Payment (
    PaymentID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    CreditCardType VARCHAR(50),
    CreditCard VARCHAR(20),
    Shipping VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Creating the CustomerFeedback table
CREATE TABLE CustomerFeedback (
    FeedbackID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    FeedbackText TEXT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
