DELIMITER //
CREATE OR REPLACE PROCEDURE add_order (
    IN numBurger INT,
    IN numOkra INT,
    IN numFries INT,
    IN numQuesillada INT,
    IN custName VARCHAR(64),
    IN custLat FLOAT,
    IN custLong FLOAT,
    IN custID INT
)
BEGIN    
    DECLARE specOrderID INT;
    DECLARE count INT;
    DECLARE custSplitNamefirst VARCHAR(64);
    DECLARE custSplitNamelast VARCHAR(64);
    DECLARE currTime DATETIME;

START TRANSACTION;
    SET count = 0;
    SET currTime = CURRENT_TIMESTAMP;

-- check if has ID (will not if has value of 0), create new customerID.
    IF custID = 0 THEN 
        SET custSplitNamefirst = (SELECT SUBSTRING_INDEX(custName, ' ', 1));
        SET custSplitNamelast = (SELECT SUBSTRING_INDEX(custName, ' ', -1));
        INSERT INTO Customers (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong)
            VALUES (custSplitNamefirst, custSplitNamelast, "filler@gmail.com", custLat, custLong);
        SET custID = (SELECT CustomerID FROM Customers WHERE (custSplitNamefirst = CustomerFirstName && custSplitNamelast = CustomerLastName));
    END IF;

    INSERT INTO Orders(FranchiseID, CustomerID, DeliveryLocationLat, DeliveryLocationLon, OrderSubmissionTime, OrderDeliveryTime)
        VALUES(1, custID, custLat, custLong, currTime, currTime + 1000 );
    SET specOrderID = (SELECT OrderID FROM Orders WHERE (OrderSubmissionTime = currTime));

    REPEAT 
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
        VALUES(1, specOrderID, "");
        SET count = count + 1;
    UNTIL count >= numBurger END REPEAT;
    SET count = 0;
    SELECT count;

    REPEAT 
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
        VALUES(2, specOrderID, "");
        SET count = count + 1;
    UNTIL count >= numBurger END REPEAT;
    SET count = 0;

    REPEAT 
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
        VALUES(3, specOrderID, "");
        SET count = count + 1;
    UNTIL count >= numBurger END REPEAT;
    SET count = 0;

    REPEAT 
        INSERT INTO OrderDishes(DishID, OrderID, DishNotes)
        VALUES(4, specOrderID, "");
        SET count = count + 1;
    UNTIL count >= numBurger END REPEAT;
    SET count = 0;

-- calculate function to find nearest store
COMMIT;
END;
//
DELIMITER ;