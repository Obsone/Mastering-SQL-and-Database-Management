CREATE TABLE "Student" (
	id serial PRIMARY KEY,
  	NAME VARCHAR(255),
  	lastName VARCHAR(255),
  	age INT
);


INSERT INTO "Student" (NAME, lastName, age) VALUES (
  'STUDENT 1',
  NULL,
  NULL
);

INSERT INTO "Student" (NAME, lastName, age) VALUES (
  'STUDENT 2',
  NULL,
  25
);

INSERT INTO "Student" (NAME, lastName, age) VALUES (
  NULL,
  'LAST NAME 3',
  20
);

INSERT INTO "Student" (NAME, lastName, age) VALUES (
  NULL,
  NULL,
  34
);

INSERT INTO "Student" (NAME, lastName, age) VALUES (
  'STUDENT 5',
  NULL,
  58
);