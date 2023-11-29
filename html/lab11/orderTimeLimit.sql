-- DELIMITER //

-- CREATE OR REPLACE TRIGGER check_time_limit 
-- BEFORE DELETE ON OrderDishes FOR EACH ROW
-- IF orderTimeDiff > 1000 THEN
   -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Time limit has expired to cancel your order.';
-- END IF;

-- //

-- DELIMITER ;