SELECT grade_str, COUNT(climb_name)
    FROM climb_grades
    LEFT OUTER JOIN climbs ON (climb_grade=grade_id)
        GROUP BY grade_id; 