SELECT * FROM Movie;

SELECT Name FROM Actor WHERE BirthYear > 1960;

SELECT Name FROM Actor WHERE BirthYear >= 1980 AND BirthYear < 1990 ORDER BY Name DESC;

SELECT Title, Role FROM Actor
  NATURAL JOIN ActorInMovie
  NATURAL JOIN Movie
  WHERE Name = "Morgan Freeman";

SELECT Title FROM Movie
  NATURAL JOIN Director
  INNER JOIN Actor ON Director.Name = Actor.Name;

SELECT COUNT(Name) FROM Actor
  WHERE LEFT(Name, 1) = "C";

SELECT Name, COUNT(MovieID) FROM GenreInMovie
  NATURAL JOIN Genre
  GROUP BY GenreID;

SELECT DISTINCT Name FROM ActorInMovie
  NATURAL JOIN Movie
  NATURAL JOIN Actor
  WHERE Title = "Ace Ventura: Pet Detective"
  AND Name NOT IN (
    SELECT DISTINCT Name FROM ActorInMovie
      NATURAL JOIN Movie
      NATURAL JOIN Actor
      WHERE Title = "Ace Ventura: When Nature Calls");

SELECT Title, MovieID, AVG(BirthYear) AS AvgBirthYear FROM Movie
  NATURAL JOIN ActorInMovie
  NATURAL JOIN Actor
  GROUP BY MovieID
  HAVING AvgBirthYear > (SELECT AVG(BirthYear) FROM Actor);
