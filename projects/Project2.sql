/*
 *  project2.sql
 * 
 *  author: Taewoo Kim
 *
 */


/*What year did Nymphadora Tonks start at Hogwarts? */
select start from hogwarts_students where last = 'Tonks';

/*What records do we have for students who started at Hogwarts before 1900? */
select * from hogwarts_students where start < 1900;

/*What house did Padma Patil sort into? */
select house from hogwarts_students where last = 'Patil' and first = 'Padma';

/*How many years was Percy Weasley at Hogwarts? */
select finish-start as "years spent" from hogwarts_students where last = 'Weasley' and first = 'Percy';

/*What students have a last name starting with "Q" or a first name starting with "Ph"? */
select first, last from hogwarts_students where (last like 'Q%') or (first like 'Ph%');

/*What students' houses are unknown? */
select first, last from hogwarts_students where house is null;

/*Who founded the house whose crest displays a badger? Hint: you may need the function lower() to answer this one. */
select founder from hogwarts_houses where animal = 'Badger';

/*What are the names of all Gryffindor students, given as "firstname lastname", without extra spaces, ordered by last name and first name? E.g., the answer should include strings like */
select concat(first,' ', last) as "names" from hogwarts_students where house = 'Gryffindor' order by last, first;

/*What defense against the dark arts teacher's first name started with 'A' whose last name did not start with 'M'? */
 select * from hogwarts_dada where first like 'A%' and last not like 'M%';

/*What are the names of the Gryffindor students who started in 1991, sorted by last name then first name? */
select first, last from hogwarts_students where start = 1991 order by last, first;

/*What unique ending years do we have student records for, ordered by ending year? */
select DISTINCT(finish) from hogwarts_students order by finish;


/*What are the names and years of all the students whose houses are known, together with their house colors, ordered by starting year? */
select first, last, start, finish, hogwarts_houses.colors from hogwarts_students, hogwarts_houses where hogwarts_students.house = hogwarts_houses.house order by start;

/*Who founded the house that Morag McDougal sorted into?  */
select founder from hogwarts_houses, hogwarts_students where hogwarts_students.house = hogwarts_houses.house and hogwarts_students.first = 'Morag' and hogwarts_students.last = 'McDougal';


/*What are the names and houses of the defense against the dark arts teachers (you only need worry about the teachers who also have student records)?  */
select hogwarts_students.first,hogwarts_students.last, house from hogwarts_students,hogwarts_dada where hogwarts_students.first = hogwarts_dada.first and hogwarts_students.last = hogwarts_dada.last;