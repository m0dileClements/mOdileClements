SELECT climb_name, grade_str
    FROM sport_climbs_view
    INNER JOIN climb_grades
    ON (climb_grade = grade_id)
    WHERE (crag_name = "Slab City");
