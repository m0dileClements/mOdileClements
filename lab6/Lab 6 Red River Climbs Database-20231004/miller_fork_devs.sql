/*Show the first and last names (as separate columns) of everyone 
who has developed a climb in the 'Miller Fork' Region. Each name 
should only be shown once.*/
SELECT DISTINCT climber_first_name, climber_last_name
    FROM climbers
        INNER JOIN developed_climbs USING (climber_id)
        INNER JOIN crags

            WHERE (region_name = "Miller Fork");