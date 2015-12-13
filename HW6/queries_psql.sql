-- Получить количество пользователей с определённым логином и паролем
select count(*) from Login
  where login = 'achromatic_color' and passMd5 = '0e40fde52d2de04e2dd398eb0b6fc44f';

-- Получить всех пользователей, родившихся в определённый месяц определённого года
select * 
  from PersonalData
    join Login on Login.personalDataId = PersonalData.id
  where
    extract(year from birthDate) = 1973 and extract(month from birthDate) = 11;

-- Получить данные пользователя с заданным полным именем 
select * 
  from PersonalData
    join Login on Login.personalDataId = PersonalData.id
  where concat(lastName, ' ', firstName) = 'Javier Sandy';
  -- функция concat() объединяет строки

-- Получить персональные данные некоторого списка пользователей
select * from Login, PersonalData 
  where PersonalData.id = Login.personalDataId
    and Login.Id in (123, 125, 256);

-- Получить все блоги, созданные некоторым пользователем
select * from Blog where ownerId = 1000;

-- Получить последние 100 созданных блогов и их создателей
select * from Blog, Login, PersonalData
  where Blog.ownerId = Login.id and PersonalData.id = Login.personalDataId
  order by creationDate limit 100;

-- Получить все блоги, название которых начинается с thum
select * from Blog
  where name like 'thum%';

-- Найти все посты некоторого пользователя, отсортированные по дате
select * from BlogPost
  where posterId = 1000
  order by creationDate;

-- Получить все посты некоторого блога, отсортированные по дате
select * from BlogPost
  where blogId = 1000
  order by creationDate;


-- Найти всех читателей блога
select readerId from BlogReader where blogId = 1000;

-- Найти все блоги, которые читает пользователь с некоторым id
select blogId from BlogReader where readerId = 1000;
