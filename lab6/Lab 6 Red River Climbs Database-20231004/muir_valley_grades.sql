/*What climbing grades can be found on land owned by "John and Elizabeth Muir"?*/
SELECT DISTINCT grade_str
    FROM climbs
    INNER JOIN climb_grades ON (climbs.climb_grade = climb_grades.grade_id)
    INNER JOIN crags USING (crag_name)
    INNER JOIN regions USING (region_name)
    INNER JOIN owners USING (owner_name)
        WHERE (owner_name = 'John and Elizabeth Muir');