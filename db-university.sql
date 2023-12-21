-- 1. Selezionare tutti gli studenti nati nel 1990 (160)

SELECT *
FROM `students`
WHERE `date_of_birth` LIKE '1990-%';

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT *
FROM `courses`
WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni

SELECT *
FROM `students`
WHERE date_of_birth <= CURDATE() - INTERVAL 30 YEAR;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT *
FROM `courses`
WHERE `period` LIKE 'I semestre' AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT *
FROM `exams`
WHERE `date` LIKE '2020-06-20' AND `hour` BETWEEN '14:00:00' AND '16:45:00';

SELECT *
FROM `exams`
WHERE `date` LIKE '2020-06-20' AND HOUR(hour) > '13:59:59';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT *
FROM `degrees`
WHERE `name` LIKE 'Corso di Laurea Magistrale%';

-- 7. Da quanti dipartimenti è composta l'università? (12)

SELECT *
FROM `departments`;

SELECT COUNT(*)
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT *
FROM `teachers`
WHERE `phone` IS NULL;

SELECT COUNT(*)
FROM `teachers`
WHERE `phone` IS NULL;


--GROUP_BY------------------------------------------------------------------------

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT COUNT(*) as `num_students`, YEAR(`enrolment_date`) as `enrolment_date`
FROM `students`
GROUP BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) as `num_teachers`, `office_address`
FROM `teachers`
GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT `exam_id`, AVG(`vote`) as `media_voti`
FROM `exam_student`
GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT COUNT(*) as `num_corsi`, `department_id`
FROM `degrees`
GROUP BY `department_id`;

