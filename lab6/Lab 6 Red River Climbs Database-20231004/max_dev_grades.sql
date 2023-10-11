SELECT climber_first_name, climber_last_name, grade_str

FROM (SELECT climber_first_name, climber_last_name, MAX(climb_grade) AS max_grade
    FROM developed_climbs
    INNER JOIN climbers USING (climber_id)
    INNER JOIN climbs USING (climb_id)
    GROUP BY (climber_id)
    ) AS max_dev_grade


    INNER JOIN climb_grades ON (grade_id = max_grade);
