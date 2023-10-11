/*Show the name and grade of every traditional (trad) climb in the database.*/

SELECT climb_name, grade_str
    FROM climbs
        INNER JOIN trad_climbs
            USING (climb_id)
        INNER JOIN climb_grades
            WHERE (climb_grade = grade_id);