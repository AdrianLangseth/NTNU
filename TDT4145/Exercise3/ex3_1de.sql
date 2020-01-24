INSERT INTO Director VALUES (1, "Peyton Reed"), (2, "Tom Shadyac");

INSERT INTO Movie VALUES (1, "Yes Man", 2008, 1);

INSERT INTO Actor VALUES (1, "Jim Carrey", 1962);

INSERT INTO ActorInMovie VALUES (1, 1, "Carl");

UPDATE Actor SET Name = "James Eugene Carrey" WHERE Name = "Jim Carrey";

DELETE FROM Director WHERE Name = "Tom Shadyac";
