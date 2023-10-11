SELECT climb_name, grade_str, climb_len_ft, crag_name, region_name
    FROM climbs
    NATURAL JOIN crags
    INNER JOIN climb_grades ON (climb_grade=grade_id)
        WHERE grade_id = ( 
            SELECT grade_id
                FROM climb_grades
                    WHERE grade_str = '5.9')

    