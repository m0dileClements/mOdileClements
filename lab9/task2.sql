USE red_river_climbs;

DROP FUNCTION IF EXISTS find_past_year;

CREATE FUNCTION find_past_year(curr_time DATETIME)
    RETURNS DATE
    RETURN (SELECT DATE_ADD(curr_time, INTERVAL -1 YEAR)); 



 DROP PROCEDURE IF EXISTS remove_pastyr_entries;
    DELIMITER //
 CREATE PROCEDURE remove_pastyr_entries(curr_time DATETIME)
    BEGIN
        DELETE FROM developed_climbs
        WHERE (SELECT (developed_date) > (SELECT curr_time));

        DELETE FROM climbs
        WHERE (SELECT )
    END //
    DELIMITER ; 

SELECT * FROM climbs
INNER JOIN climb_grades ON (climb_grade=grade_id)
WHERE (grade_id = 12);