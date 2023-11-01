-- Write SQL code which will produce the output table seen on the browse 
--climbs page. This is one of the Example Pages and Source.

-- climb_length_ft, crag_name, GROUP CONCAT(climber_first_name, " ", climber_last_name), 
USE red_river_climbs;

SELECT climb_name, grade_str, climb_len_ft, crag_name -- , GROUP CONCAT(climber_id) AS first_climbers
    FROM climbs
    INNER JOIN climb_grades ON (climb_grade = grade_id)
    INNER JOIN crags USING (crag_name)
    -- RIGHT OUTER JOIN first_ascents USING (climb_id);
