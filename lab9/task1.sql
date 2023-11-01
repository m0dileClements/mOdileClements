--Write an SQL statement which will change all routes graded "5.10"
-- to grade "5.10a". The statement should use "5.10" and "5.10a" directly, 
--not grade_ids.
-- DROP FUNCTION IF EXISTS find_str;

-- A function that would replace the grade_id with the grade_str was implemented originally in the changeRouteGrade procedure. 
-- But since the code did not switch over the information, it was removed from the function


-- CREATE FUNCTION find_str(find_grade_id INT)
-- RETURNS VARCHAR(5)
    -- RETURN (SELECT grade_str FROM climb_grades WHERE (find_grade_id = grade_id));

USE red_river_climbs; 

DROP PROCEDURE IF EXISTS changeRouteGrade;
DELIMITER //
CREATE PROCEDURE changeRouteGrade()
    BEGIN
        UPDATE climbs
        SET climb_grade = 12
        WHERE (climb_grade = 11);
    END //
    DELIMITER ;
