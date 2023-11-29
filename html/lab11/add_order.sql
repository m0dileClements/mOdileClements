/* 
    Change SQL's delimiter to something other than a semicolon, so that we can
    place multiple statements inside our CREATE statement.
*/
DELIMITER //
CREATE PROCEDURE add_order (
    IN numBurger INT,
    IN numOkra INT,
    IN numFries INT,
    IN numQuesillada INT,
    IN custName VARCHAR(64),
    IN custLat FLOAT,
    IN custLong FLOAT
)
BEGIN    
    DECLARE specOrderID INT;
    DECLARE count INT = 0;
    DECLARE OrderSubTime DATETIME = CURRENT_TIMESTAMP;
    DECLARE OrderDeLTime DATETIME = CURRENT_TIMESTAMP;


-- calculate order deliver time function

--calculate function to find nearest store

--function to find if any customer match, find new customerID

INSERT INTO Orders (FranchiseID, CustomerID, DeliveryLocationLat, DeliveryLocationLon, OrderSubmissionTime, OrderDeliveryTime)
    VALUES(1, 1, custLat, custLong, OrderSubTime, OrderDeLTime),

WHILE count < numBurger
    BEGIN
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
            VALUES(1, specOrderID, "");
    SET count = count + 1;
    END;
    
WHILE count < numOkra
    BEGIN
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
            VALUES(2, specOrderID, "");
        SET count = count + 1;
    END;

WHILE count < numFries
    BEGIN
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
            VALUES(3, specOrderID, "");
    SET count = count + 1;
    END;
    
WHILE count < numQuesillada
    BEGIN
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
            VALUES(4, specOrderID, "");
    SET count = count + 1;
    END;




END;

//
DELIMITER ;