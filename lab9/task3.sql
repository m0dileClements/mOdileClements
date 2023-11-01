-- Write a query which will produce a list of the top three route equippers 
-- in the database, and the number of routes they have helped to establish. 
-- The output should contain only the top three equippers, in decreasing order
-- by number of routes.
USE red_river_climbs;

SELECT CONCAT(climber_first_name," ", climber_last_name) AS Climber_Name, COUNT(climb_id) AS num_routes
    FROM climbers
    INNER JOIN developed_climbs USING (climber_id)
    INNER JOIN climbs USING (climb_id)
    GROUP BY climber_first_name
    ORDER BY num_routes DESC
    Limit 3; 