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
CREATE carpet_gallery;
USE carpet_gallery;


/*Creation of the validation table for a rug's possible origin country.*/
CREATE TABLE rug_origins(
    rug_country VARCHAR(20);
    PRIMARY KEY (rug_country);
);

/*Creation of the validation table for a rug's possible primary materials.*/
CREATE TABLE rug_materials(
    rug_material VARCHAR(20);
    PRIMARY KEY (rug_material);
);

/*Creation of the validation table for a rug's possible primary materials.*/
CREATE TABLE rug_styles(
    rug_style VARCHAR(20);
    PRIMARY KEY (rug_style);
);

/*Creation of the Rug Inventory table*/
CREATE TABLE rugs(
    inventory_num INT 
)