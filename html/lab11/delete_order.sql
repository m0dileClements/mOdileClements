DELIMITER //
CREATE OR REPLACE PROCEDURE delete_order (
    IN delOrderID INT
)
BEGIN
    DECLARE orderTimeDiff INT;
    
    DECLARE EXIT HANDLER FOR 1644

    BEGIN 
        GET DIAGNOSTICS CONDITION 1
            @err_state = RETURNED_SQLSTATE,
            @err_message = MESSAGE_TEXT;

        SELECT 'Delete not executed' AS 'RESULT',
                @err_state AS 'Error State',
                @err_message AS 'Error Message';
    END; 
    
    START TRANSACTION;

    SET orderTimeDiff = CURRENT_TIMESTAMP - (SELECT OrderSubmissionTime FROM Orders WHERE (delOrderID = OrderID));
    

    -- LIMIT IF CUSTOMERS HAVE SAME NAME ETC
    -- IN 
    IF (orderTimeDiff) < 1000 THEN
        DELETE FROM OrderDishes WHERE (OrderDishes.OrderID = delOrderID);
    END IF;

    IF (orderTimeDiff) > 1000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The window to cancel your order has passed.';
    END IF;
    
    
    
COMMIT;




END;

//
DELIMITER ;