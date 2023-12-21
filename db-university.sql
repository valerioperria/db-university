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


-- GROUP_BY ------------------------------------------------------------------------

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


-- JOIN ------------------------------------------------------------------------

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT *
FROM `students`
JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT *
FROM `degrees`
JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`name`
LIKE 'Corso di Laurea Magistrale%'
AND `departments`.`name`
LIKE 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT *
FROM `courses`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `course_teacher`.`teacher_id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT
`students`.`surname` AS `student_surname`,
`students`.`name` AS `student_name`,
`degrees`.`name` AS`degrees_name`,
`degrees`.`level` AS`degrees_level`,
`degrees`.`address` AS`degrees_address`,
`degrees`.`email` AS`degrees_email`,
`degrees`.`website` AS`degrees_website`,
`departments`.`name` AS `department_name`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`,`students`.`name` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT
`degrees`.`name` AS `degree_name`,
`courses`.`name` AS `course_name`,
`teachers`.`name` AS `teacher_name`
FROM `degrees`
JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT `teachers`.`id`, `teachers`.`name`, `teachers`.`surname`
FROM `teachers`
JOIN `course_teacher`
ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `courses`.`degree_id` = `degrees`.`id`
JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';