USE movie_ratings;

/*

SELECT movie_title
    FROM movies

SELECT movie_title, ratings
    FROM movies
        NATURAL JOIN ratings

SELECT movie_title, ratings
    FROM movies 
        INNER JOIN ratings
        USING (movie_id);

SELECT movie_title, ratings
    FROM movies 
        INNER JOIN ratings
        ON movies.movie_id = ratings.movie_id;

SELECT consumer_first_name, consumer_last_name, movie_title
    FROM consumers
        LEFT OUTER JOIN ratings
        USING (consumer_id)
        LEFT OUTER JOIN movies
        USING (movie_id);

SELECT consumer_first_name, consumer_last_name, movie_title
    FROM consumers
        LEFT OUTER JOIN ratings
        ON (consumers.consumer_id = ratings.consumer_id)
        LEFT OUTER JOIN movies
        USING (movie_id);

SELECT movie_title AS "Movie Title", COUNT(number_stars) AS "# Ratings"
    FROM movies
        INNER JOIN ratings
        USING (movie_id)
 GROUP BY movie_id;
*/
SELECT consumer_first_name,
       consumer_last_name,
       COUNT(number_stars)
    FROM consumers
        INNER JOIN ratings
        USING (consumer_id)
 GROUP BY (consumer_id)
HAVING COUNT(number_stars) > 1; 


SELECT consumer_first_name,
       consumer_last_name,
       COUNT(number_stars)
    FROM consumers
        INNER JOIN ratings
        USING (consumer_id)
 GROUP BY (consumer_id)
 ORDER BY COUNT(number_stars) DESC
 LIMIT 3;

