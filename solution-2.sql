
-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT S.* , `D`.`name` AS 'nome corso di laurea'
FROM `students` AS S
JOIN `degrees` AS D
ON `S`.`degree_id` = `D`.`id`
WHERE `D`.`name` = 'Corso di Laurea in Economia';

-- Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `DEG`.`name`
FROM `degrees` AS DEG
JOIN `departments` AS DEP
ON `DEG`.`department_id` = `DEP`.`id`
WHERE `DEP`.`name` = 'Dipartimento di Neuroscienze';

-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `C`.`name`, `T`.`name`, `T`.`surname`
FROM `courses` AS C
JOIN `course_teacher` AS CT
ON `C`.`id` = `CT`.`course_id`
JOIN `teachers` AS T
ON T.`id` = `CT`.`teacher_id`
WHERE `T`.`name` = 'Fulvio'
AND `T`.`surname` = 'Amato';

-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT  `S`.`surname`, `S`.`name`, `DEG`.`name` AS 'Corso di laurea', `DEP`.`name` AS 'Dipartimento'
FROM `students` as S
JOIN `degrees` AS DEG
ON `S`.`degree_id` = `DEG`.`id`
JOIN `departments` AS DEP
ON `DEG`.`department_id` = `DEP`.`id`
ORDER BY `S`.`name`, `S`.`surname`;

-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `D`.`name`, `C`.`name`, `T`.`name` AS 'Nome Insegnante', `T`.`surname` AS 'Cognome Insegnante' 
FROM `degrees` AS D
JOIN `courses` AS C
ON `D`.`id` = `C`.`degree_id`
JOIN `course_teacher` AS CT
ON `C`.`id` = `CT`.`course_id`
JOIN `teachers` AS T
ON `T`.`id` = `CT`.`teacher_id`;

-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `T`.`name`, `T`.`surname`
FROM `teachers` AS T
JOIN `course_teacher` AS CT
ON `T`.`id` = `CT`.`teacher_id`
JOIN `courses` AS C
ON `C`.`id` = `CT`.`course_id`
JOIN `degrees` AS DEG
ON `DEG`.`id` = `C`.`degree_id`
JOIN `departments` AS DEP
ON `DEP`.`id` = `DEG`.`department_id`
WHERE `DEP`.`name` = 'Dipartimento di Matematica';

-- BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT `S`.`name`, `S`.`surname`, `C`.`name` AS 'Nome Corso', COUNT(ES.`vote`) AS 'Numero Tentativi', MAX(ES.`vote`) AS `voto_massimo`
FROM `students` AS S
JOIN `exam_student` AS ES
ON `S`.`id` = `ES`.`student_id`
JOIN `exams` AS E
ON `E`.`id` = `ES`.`exam_id`
JOIN `courses` AS C
ON `C`.`id` = `E`.`course_id`
GROUP BY `S`.`id`, `C`.`id`
HAVING ES.`voto_massimo` >= 18;