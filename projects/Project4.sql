/*
* Taewoo Kim
* Project 4
*/


SELECT COUNT(*) FROM hogwarts_students WHERE house = 'Slytherin';

SELECT MIN(start) FROM hogwarts_students;

SELECT COUNT(*) FROM hogwarts_students WHERE house IS NULL OR start IS NULL OR finish IS NULL;

SELECT COUNT(*) FROM hogwarts_students WHERE house IS NOT NULL AND start IS NOT NULL and finish IS NOT NULL;

SELECT house,COUNT(*) FROM hogwarts_students GROUP BY house ORDER BY COUNT(*) desc;

SELECT first, last FROM hogwarts_students WHERE start IN (select MIN(start) FROM hogwarts_students);

SELECT house, COUNT(*) FROM hogwarts_students AS S INNER JOIN hogwarts_dada AS D ON S.start = D.start WHERE D.first = 'Alastor' AND D.last = 'Moody' GROUP BY S.house;      

SELECT S.first, S.last, S.house, H.colors FROM hogwarts_students AS S, hogwarts_houses AS H WHERE (S.first,S.last) IN (SELECT first, last FROM hogwarts_dada) AND H.house = S.house;   

SELECT S.first, S.last, S.house, S.start, S.finish FROM hogwarts_students as S INNER JOIN hogwarts_dada as D ON D.start between S.start and S.finish and D.finish between S.start and S.finish WHERE D.first = 'Gilderoy' and D.last = 'Lockhart' and S.house = 'Gryffindor';

SELECT substring(last,1,1), COUNT(*) from hogwarts_students WHERE house IS NULL OR start IS NULL OR finish IS NULL group by substring(last,1,1) HAVING COUNT(*) = 8;
