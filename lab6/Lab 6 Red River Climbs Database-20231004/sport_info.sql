SELECT climb_name, climb_bolts, GROUP_CONCAT(climber_handle)
    FROM climbs 
    INNER JOIN first_ascents USING (climb_id)
    INNER JOIN sport_climbs USING (climb_id)
    INNER JOIN climbers USING (climber_id)

        GROUP BY climb_name;
        