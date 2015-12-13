
-- load data local infile '/home/anton/Study/database/HW6/data/Blog.txt' into table Blog columns terminated by ',';
-- load data local infile '/home/anton/Study/database/HW6/data/BlogPost.txt' into table BlogPost columns terminated by ',';
-- load data local infile '/home/anton/Study/database/HW6/data/BlogReader.txt' into table BlogReader columns terminated by ',';
-- load data local infile '/home/anton/Study/database/HW6/data/Login.txt' into table Login columns terminated by ',';
-- load data local infile '/home/anton/Study/database/HW6/data/PersonalData.txt' into table PersonalData columns terminated by ',';


-- Получить количество пользователей с определённым логином и паролем
create index Log_Pass using hash on Login (login, passMd5);
select count(*) from Login
  where login = 'achromatic_color' and passMd5 = '0e40fde52d2de04e2dd398eb0b6fc44f';

-- Получить всех пользователей, родившихся в определённый месяц определённого года
create index Log using hash on Login (personalDataId);
create index Birth using btree on PersonalData (birthDate);
select * 
  from PersonalData
    join Login on Login.personalDataId = PersonalData.id
  where
      birthdate >= '1973-11-01' and birthdate <= '1973-11-31';
--    year(birthDate) = 1973 and month(birthDate) = 11;


-- Получить данные пользователя с заданным полным именем 
-- для таблицы Login используем индекс Log
create index Last_First_Names using hash on PersonalData (lastName, firstName);
select * 
  from PersonalData
    join Login on Login.personalDataId = PersonalData.id
    where lastName = 'Javier' and firstName = 'Sandy';
--  where concat(lastName, ' ', firstName) = 'Javier Sandy';
  -- функция concat() объединяет строки

-- Получить персональные данные некоторого списка пользователей
create index Person_Id using hash on PersonalData (id);
create index Log_Id using hash on Login (Id);
select * from Login, PersonalData 
  where PersonalData.id = Login.personalDataId
    and Login.Id in (123, 125, 256);

-- Получить все блоги, созданные некоторым пользователем
create index Owner_Id using hash on Blog (ownerId);
select * from Blog where ownerId = 1000;

-- Получить последние 100 созданных блогов и их создателей
-- для таблицы Blog используем индекс Owner_Id
-- для таблицы PersonalData используем индекс Person_id 
create index Blog_Creation_Date using btree on Blog (creationDate);
select * from Blog, Login, PersonalData
  where Blog.ownerId = Login.id and PersonalData.id = Login.personalDataId
  order by creationDate limit 100;

-- Получить все блоги, название которых начинается с thum
create index Blog_Name using btree on Blog (name);
select * from Blog
  where name like 'thum%';

-- Найти все посты некоторого пользователя, отсортированные по дате 
create index Poster_Id using hash on BlogPost (posterId);
create index BlogPost_Creation_Date using btree on BlogPost (creationDate);
select * from BlogPost
  where posterId = 1000
  order by creationDate;

-- Получить все посты некоторого блога, отсортированные по дате
-- для таблицы BlogPost используем индекс BlogPost_Creation_Date
create index BlogPost_Id using hash on BlogPost (blogId);
select * from BlogPost
  where blogId = 1000
  order by creationDate;


-- Найти всех читателей блога
create index Blog_Id using hash on BlogReader (blogId);
select readerId from BlogReader where blogId = 1000;

-- Найти все блоги, которые читает пользователь с некоторым id
create index Reader_Id using hash on BlogReader (readerId);
select blogId from BlogReader where readerId = 1000;
