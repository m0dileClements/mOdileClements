USE robo_rest_fall_2023;

INSERT INTO Customers (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong)
    VALUES("Sally", "Smith", "sallysmith@yahoo.com", 5, 10), 
          ("Rick", "Sanchez", "ricky@gmail.com", 2, 4), 
          ("Rachel", "Stowe", "stowaway@aol.com", 6, 12);

INSERT INTO Dishes (DishName, DishPrice, DishWeightGrams)
    VALUES("Deluxe Black Bean Burger", 11.99, 200),
          ("Fried Okra Poppers", 9.99, 30),
          ("Fries", 3.99, 200),
          ("Quesilladas", 5.99, 400);

INSERT INTO Franchises (FranchiseLocationLat, FranchiseLocationLon, FranchiseStreet, FranchiseCity, FranchiseState, FranchiseZIP)
    VALUES(6, 11, "Easy Street", "Smilesville", "Kentucky", 12345),
          (2, 3, "Robot Lane", "Tomorrowland", "California", 54321);

INSERT INTO Drones (DroneCapacityGrams, DroneCallsign, PurchaseDate, FranchiseID)
    VALUES(2000, "Wall-E", "2022-05-07", 1),
          (4000, "Eva", "2021-02-01", 1),
          (2000, "Crash and Burn","2022-06-07", 2),
          (4000, "Porch Pirate","2023-11-09", 2); 

INSERT INTO Orders (FranchiseID, CustomerID, DeliveryLocationLat, DeliveryLocationLon, OrderSubmissionTime, OrderDeliveryTime)
    VALUES(1, 1, 5, 10, "2023-11-09 01:23:45", "2023-11-09 01:45:45"),
          (1, 1, 5, 10, "2023-11-12 01:23:45", "2023-11-12 01:50:45"),
          (2, 2, 2, 3, "2023-12-02 00:30:29", "2023-10-11 01:40:45");

INSERT INTO OrderDishes (DishID, OrderID, DishNotes)
    VALUES(3, 1, ""),
          (2, 1, ""),
          (2, 2, ""),
          (1, 2, ""),
          (1, 3, ""),
          (2, 3, ""),
          (3, 3, ""),
          (4, 3, "");

--  SELECT OrderID, GROUP_CONCAT(CustomerFirstName, CustomerLastName) AS Names, DishList, Total
 --    FROM Orders



SELECT OrderID, CONCAT(CustomerFirstName, ' ', CustomerLastName) AS 'Customer', GROUP_CONCAT(' ', DishName) AS 'Description', ROUND(SUM(DishPrice), 2) AS 'Price'
    FROM Orders
    INNER JOIN Customers USING (CustomerID)
    INNER JOIN OrderDishes USING (OrderID)
    INNER JOIN Dishes WHERE (Dishes.DishID = OrderDishes.DishID)
    GROUP BY OrderID;

