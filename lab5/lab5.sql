/*
  Lab 05: Implementing a Database
  CSC 362 Database Systems
  By Odile Clements
  This script creates a database for the company Flying Carpets Gallery
  to maintian information about their inventory, rug rentals, purchases, and customers.
*/


/*Check if the database already exists. If it exists, then the database 
is dropped and created anew.*/
DROP DATABASE IF EXISTS carpet_gallery;
CREATE DATABASE carpet_gallery;
USE carpet_gallery;


/*Creation of the validation table for a rug's possible origin country.*/
CREATE TABLE rug_origins (
    rug_country VARCHAR(20),
    /*CHECK (rug_country = 'Turkey' OR rug_country =  'Iran' OR rug_country = 'India'), */
    PRIMARY KEY (rug_country)
 );

/*Adds all possible values for the rugs's origins into the validation table*/
INSERT INTO rug_origins (rug_country)
    VALUES('Turkey'), ('Iran'), ('India');

/*Creation of the validation table for a rug's possible primary materials.*/
CREATE TABLE rug_materials (
    rug_material VARCHAR(20),
    PRIMARY KEY (rug_material)
    
 );

/*Adds all possible values for the rugs's materials into the validation table*/
INSERT INTO rug_materials (rug_material)
    VALUES('Silk'), ('Wool');

/*Creation of the validation table for a rug's possible primary materials.*/
CREATE TABLE rug_styles (
    rug_style VARCHAR(20),
     PRIMARY KEY (rug_style)
 );
/*Adds all possible values for the rugs's styles into the validation table*/
 INSERT INTO rug_styles (rug_style)
    VALUES ('Agra'), ('Tabriz'), ('Ushak');

/*Creation of the Rug Inventory table*/
CREATE TABLE rugs(
    /*create or reference the primary and foreign keys*/
    inventory_id INT,
    rug_country VARCHAR(20),
    rug_material VARCHAR(20),
    rug_style VARCHAR(20),
    /*create references to validation tables through foreign keys*/
     FOREIGN KEY (rug_country) REFERENCES rug_origins(rug_country),
     FOREIGN Key (rug_material) REFERENCES rug_materials(rug_material),
     FOREIGN Key (rug_style) REFERENCES rug_styles(rug_style),
     /*create other variables for rug information*/
     year_made INT,
     rug_length INT,
     rug_width INT,
     purchase_price DECIMAL,
     date_acquired DATE, 
     price_markup INT,
    /*Assign the primary key to integer*/
    PRIMARY KEY (inventory_id)
 );

/*Adds rug objects into the database*/
INSERT INTO rugs (inventory_id, rug_country, rug_material, rug_style, year_made, rug_length, rug_width, purchase_price, date_acquired, price_markup)
    VALUES('1214', 'Turkey', 'Wool', 'Ushak','1925', '5', '7', '625.00', '2017-04-06', '100'),
          ('1219', 'Iran', 'Silk', 'Tabriz','1910', '10', '14', '28000.00', '2017-04-06', '75'),
          ('1277', 'India', 'Wool', 'Agra','2017', '8', '10', '1200.00', '2017-06-15', '100'),
          ('1278', 'India', 'Wool', 'Agra', '2017', '4', '6', '450.00', '2017-06-15', '120');

/*Creation of the validation table for a customer's possible home state.*/
CREATE TABLE customer_states( 
    customer_state VARCHAR (2) NOT NULL,
    PRIMARY KEY(customer_state)
 );
/*Adds all possible values for the customer's state into the validation table*/
 INSERT INTO customer_states(customer_state)
    VALUES("AL"), ("AK"), ("AZ"), ("AR"), ("CA"), ("CO"), ("CT"), ("DE"), ("FL"), ("GA"), ("HI"), ("ID"), ("IL"), ("IN"), ("IA"),
          ("KS"), ("KY"), ("LA"), ("ME"), ("MD"), ("MA"), ("MI"), ("MN"), ("MS"), ("MO"), ("MT"), ("NE"), ("NV"), ("NH"), ("NJ"),
          ("NM"), ("NY"), ("NC"), ("ND"), ("OH"), ("OK"), ("OR"), ("PA"), ("RI"), ("SC"), ("SD"), ("TN"), ("TX"), ("UT"), ("VT"),
          ("VA"), ("WA"), ("WV"), ("WI");

/*Create table for the customer information*/
CREATE TABLE customers (
    /*establishing basic customer information*/
    customer_id INT AUTO_INCREMENT,
     PRIMARY KEY (customer_id),
     customer_first_name VARCHAR(20),
     customer_last_name VARCHAR(20),
    /*establishing customer addresses*/
     customer_street_address VARCHAR(64) NOT NULL,
     customer_city VARCHAR(64) NOT NULL,
     /*references the foreign key for the validation states table*/
     customer_state VARCHAR(2),
     FOREIGN KEY (customer_state) REFERENCES customer_states(customer_state),
     customer_zip_code INT NOT NULL,
     /*establishing additional customer information*/
     customer_phone_number VARCHAR(20) UNIQUE,
     customer_is_Active BOOLEAN DEFAULT TRUE
 );

/*Adds customers to the database*/
INSERT INTO customers (customer_first_name, customer_last_name, customer_street_address, 
                       customer_city, customer_state, customer_zip_code, customer_phone_number)
    VALUES ('Akira', 'Ingram', '68 Country Drive', 'Roseville', 'MI', '48066', '(926) 252-6716'),
           ('Meredith', 'Spencer', '9044 Piper Lane', 'North Royalton', 'OH', '44133', '(817) 530-5994'),
           ('Marco', 'Page', '747 East Harrison Lane', 'Atlanta', 'GA', '30303', '(588) 799-6535'),
           ('Sandra', 'Page', '47 East Harrison Lane', 'Atlanta', 'GA', '30303', '(997) 697-2666'),
           ('Gloria', 'Gomez', '78 Corona Rd', 'Fullerton', 'CA', '92831', NULL),
           ('Bria', 'Le', '386 Silver Spear Ct', 'Coraopolis', 'PA', '15108', NULL);


/*Establishing the table for the trial linking table*/
CREATE TABLE trials (
    inventory_id INT,
    FOREIGN KEY (inventory_id) REFERENCES rugs(inventory_id),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    starting_date DATE,
    expected_date DATE,
    ending_date DATE
 );

/*Establishing the table for the transactions linking table*/
CREATE TABLE transactions (
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    inventory_id INT,
    FOREIGN KEY (inventory_id) REFERENCES rugs(inventory_id),
    sale_date DATE,
    price DECIMAL,
    return_date DATE
 );

/*Adds the customer's transactions into the database*/
INSERT INTO transactions (customer_id, inventory_id, sale_date, price, return_date)
    VALUES ('5', '1214', '2017-12-14', '990.00', NULL),
           ('6', '1277', '2017-12-24', '2400.00', NULL),
           ('2', '1219', '2017-12-24', '40000.00', '2017-12-26');
/*These statements create the views to check the inputted objects in the database.


This displays the rugs that have been placed in the inventory. */
Select inventory_id, rug_country, rug_material, rug_style, year_made, rug_length, rug_width, 
       purchase_price, date_acquired, price_markup
     FROM rugs;


/*The statement below displays the rugs that have been placed in the inventory.*/
SELECT customer_first_name, customer_last_name, customer_street_address, 
       customer_city, customer_state, customer_zip_code, customer_phone_number
     FROM customers; 

/*Displays all of the transactions made by customers*/
SELECT customer_first_name, customer_last_name, customer_street_address, customer_city, customer_state, customer_zip_code, 
       inventory_id, rug_country, rug_style, rug_length, rug_width, rug_material, sale_date, purchase_price, return_date
    FROM transactions
    NATURAL JOIN customers
    NATURAL JOIN rugs;

