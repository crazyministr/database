DROP TABLE IF EXISTS BlogPost;
CREATE TABLE BlogPost (
  id int NOT NULL,
  blogId int NOT NULL, -- ссылается на id из таблицы Blog
  posterId int NOT NULL, -- ссылается на id из таблицы Login
  creationDate date NOT NULL,
  blogMessageText text NOT NULL
);

DROP TABLE IF EXISTS BlogReader;
CREATE TABLE BlogReader (
  blogId int NOT NULL, -- ссылается на id из таблицы Blog
  readerId int NOT NULL -- ссылается на id из таблицы Login
);

DROP TABLE IF EXISTS Blog;
CREATE TABLE Blog (
  id int NOT NULL,
  name varchar(256) NOT NULL,
  creationDate date NOT NULL,
  ownerId int NOT NULL -- ссылается на id из таблицы Login
);

DROP TABLE IF EXISTS PersonalData;
CREATE TABLE PersonalData (
  id int NOT NULL,
  lastName varchar(128) NOT NULL,
  firstName varchar(128) NOT NULL,
  isMale bit NOT NULL,
  birthDate date NOT NULL
);

DROP TABLE IF EXISTS Login;
CREATE TABLE Login (
  id int NOT NULL,
  personalDataId int NOT NULL, -- ссылается на id из таблицы PersonalData
  login varchar(128) NOT NULL,
  passMd5 varchar(32) NOT NULL
);
