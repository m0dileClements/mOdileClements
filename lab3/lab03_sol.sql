/*
  Lab 03: Tables and Fields in SQL
  CSC 362 Database Systems
  By Odile Clements
  This script creates a small database to store a movie rental store's movie and
  customer information, as well as ratings the consumer gives to a movie.
*/



/*Check for already existing database and create if no other instance.*/
DROP DATABASE IF EXISTS movie_ratings;
/*Create and establish the usage of the movie_ratings table.*/
CREATE DATABASE movie_ratings;

USE movie_ratings;

/*Create the movie and consumer tables*/
CREATE TABLE movies(
  
    movie_id INT AUTO_INCREMENT,
    movie_title VARCHAR(64),
    movie_release_date VARCHAR(20),
    movie_genre VARCHAR(64),
    PRIMARY KEY (movie_id)
);

CREATE TABLE consumers(
  
    consumer_id INT AUTO_INCREMENT,
    consumer_first_name VARCHAR(20),
    consumer_last_name VARCHAR(20),
    consumer_address VARCHAR (32),
    consumer_city VARCHAR(20),
    consumer_state VARCHAR(20),
    consumer_zip_code VARCHAR(20),
    PRIMARY KEY (consumer_id)
);
/*populate the movies table*/
INSERT INTO movies(movie_title, movie_release_date, movie_genre)
  VALUES ('The Hunt for Red October', '1990-03-02', 'Action, Adventure, Thriller'),
         ('Lady Bird', '2017-12-01', 'Comedy, Drama'),
         ('Inception', '2010-08-16', 'Action, Adventure, Science Fiction'),
         ('Monty Python and the Holy Grail', '1975-04-03', 'Comedy');

SELECT * FROM movies;

/*populate the consumers table*/
INSERT INTO consumers(consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip_code)
  VALUES ('Toru', 'Okada', '800 Glenridge Ave', 'Hobart', 'IN', '46343'),
         ('Kumiko', 'Okada', '864 NW Bohemia St', 'Vincentown', 'NJ', '08088'),
         ('Noboru', 'Wataya', '342 Joy Ridge St', 'Hermitage', 'TN', '37076'),
         ('May', 'Kasahara', '5 Kent RD', 'East Haven', 'CT', '06512');

SELECT * FROM consumers;

/*create the ratings table*/
CREATE TABLE ratings(
  /*establish the datatypes of the movie_id and consumer_id values.*/
  movie_id int,
  consumer_id int,
  /*create the Foreign key reference for movies and consumer ids.*/
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN Key (consumer_id) REFERENCES consumers(consumer_id),
  when_rated VARCHAR(20),
  number_stars INT(5) 
);

/*populate the ratings table*/
INSERT INTO ratings(movie_id, consumer_id, when_rated, number_stars)
  VALUES('1', '1', '2010-09-02 10:54:19', '4'),
        ('1', '3', '2012-08-05 15:00:01', '3'),
        ('1', '4', '2016-10-02 23:58:12', '1'),
        ('2', '3', '2017-03-27 00:12:48', '2'),
        ('2', '4', '2018-08-02 00:54:42', '4');

SELECT * FROM ratings;


SELECT consumer_first_name, consumer_last_name, movie_title, number_stars
  FROM movies
    NATURAL JOIN ratings
    NATURAL JOIN consumers;

/*In the movie field, there are multiple genres for each movie. Instead, there should
be a separate table for each genre. To solve this, there needs to be a validation table for 
genres, and a linking table to connect it to the movies  */

/*REDESIGNED TABLES*/

DROP DATABASE IF EXISTS movie_ratings;

CREATE DATABASE movie_ratings;

USE movie_ratings;

CREATE TABLE movies(
  
    movie_id INT AUTO_INCREMENT,
    movie_title VARCHAR(64),
    movie_release_date VARCHAR(20),
    PRIMARY KEY (movie_id)
);


CREATE TABLE consumers(
  
    consumer_id INT AUTO_INCREMENT,
    consumer_first_name VARCHAR(20),
    consumer_last_name VARCHAR(20),
    consumer_address VARCHAR (32),
    consumer_city VARCHAR(20),
    consumer_state VARCHAR(20),
    consumer_zip_code VARCHAR(20),
    PRIMARY KEY (consumer_id)
);

/*populate the movies table*/
INSERT INTO movies(movie_title, movie_release_date)
  VALUES ('The Hunt for Red October', '1990-03-02'),
         ('Lady Bird', '2017-12-01'),
         ('Inception', '2010-08-16'),
         ('Monty Python and the Holy Grail', '1975-04-03');

INSERT INTO consumers(consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip_code)
  VALUES ('Toru', 'Okada', '800 Glenridge Ave', 'Hobart', 'IN', '46343'),
         ('Kumiko', 'Okada', '864 NW Bohemia St', 'Vincentown', 'NJ', '08088'),
         ('Noboru', 'Wataya', '342 Joy Ridge St', 'Hermitage', 'TN', '37076'),
         ('May', 'Kasahara', '5 Kent RD', 'East Haven', 'CT', '06512');

SELECT * FROM consumers;

/*create the ratings table*/
CREATE TABLE ratings(
  /*establish the datatypes of the movie_id and consumer_id values.*/
  movie_id int,
  consumer_id int,
  /*create the Foreign key reference for movies and consumer ids.*/
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN Key (consumer_id) REFERENCES consumers(consumer_id),
  when_rated VARCHAR(20),
  number_stars INT(5) 
);

/*populate the ratings table*/
INSERT INTO ratings(movie_id, consumer_id, when_rated, number_stars)
  VALUES('1', '1', '2010-09-02 10:54:19', '4'),
        ('1', '3', '2012-08-05 15:00:01', '3'),
        ('1', '4', '2016-10-02 23:58:12', '1'),
        ('2', '3', '2017-03-27 00:12:48', '2'),
        ('2', '4', '2018-08-02 00:54:42', '4');

SELECT * FROM ratings;


SELECT consumer_first_name, consumer_last_name, movie_title, number_stars
  FROM movies
    NATURAL JOIN ratings
    NATURAL JOIN consumers;



CREATE TABLE genres(
  
  genre_id INT AUTO_INCREMENT,
  genre_name VARCHAR(20), 
  PRIMARY KEY (genre_id)
);

INSERT INTO genres(genre_name)
  VALUES ('Action'),
         ('Adventure'),
         ('Comedy'),
         ('Drama'),
         ('Science Fiction'),
         ('Thriller');

SELECT * FROM genres;

CREATE TABLE movie_genre(
  /*establish the datatypes of the movie_id and genre_id values.*/
  movie_id INT,
  genre_id INT,
  /*create the Foreign key reference for movies and genre ids.*/
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN Key (genre_id) REFERENCES genres(genre_id)
 
);

INSERT INTO movie_genre(movie_id, genre_id)
  VALUES ('1','1'),
         ('1','2'),
         ('1','6'),
         ('2','3'),
         ('2','4'),
         ('3','1'),
         ('3','2'),
         ('3','5'),
         ('4','3');

SELECT * FROM movie_genre;

SELECT movie_title, genre_name
  FROM movie_genre
    NATURAL JOIN movies
    NATURAL JOIN genres;


