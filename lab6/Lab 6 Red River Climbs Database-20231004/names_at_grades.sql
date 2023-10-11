SELECT grade_str, GROUP_CONCAT(climb_name)
    FROM climbs
    LEFT OUTER JOIN climb_grades ON (climb_grade=grade_id)
        GROUP BY grade_id; 