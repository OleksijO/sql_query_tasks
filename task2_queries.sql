-- Задание:

-- 1.	Написать запрос, показывающий список преподавателей с количеством обучаемых ими студентов.
-- В результате выполнения запроса должно получиться:
-- tt_id 	tt_name 	students_count
-- 1 	Профессор Иванов 	5
-- 2 	Доцент Петров 	4
-- 3 	Ассистент Сидоров 	3
-- 4 	Ассистент Неизвестный 	0

SELECT
  tt_id,
  tt_name,
  COUNT(ed_student) AS students_count
FROM (
  SELECT DISTINCT
    tt_id,
    tt_name,
    ed_student
  FROM TUTORS
    LEFT JOIN EDUCATION ON TUTORS.TT_ID = EDUCATION.ED_TUTOR
)
GROUP BY tt_id, tt_name
ORDER BY tt_id;

-- 2.	Написать запрос, показывающий список студентов с количеством преподавателей, у которых они обучаются.
-- В результате выполнения запроса должно получиться:
-- st_id 	st_name 	tutors_count
-- 1 	Воробьёв В.В. 	3
-- 2 	Соколов С.С. 	3
-- 3 	Орлов О.О. 	2
-- 4 	Беркутов Б.Б. 	3
-- 5 	Филинов Ф.Ф. 	1

SELECT
  st_id,
  st_name,
  COUNT(ed_tutor) AS tutor_count
FROM (
  SELECT DISTINCT
    st_id,
    st_name,
    ed_tutor
  FROM STUDENTS
    LEFT JOIN EDUCATION ON STUDENTS.ST_ID = EDUCATION.ED_STUDENT
  WHERE ed_tutor IS NOT NULL
)
GROUP BY st_id, st_name
ORDER BY st_id;

-- 3.	Написать запрос, показывающий id и имя преподавателя (преподавателей), проведшего больше всего занятий в сентябре 2012 года.
-- В результате выполнения запроса должно получиться:
-- tt_id 	tt_name 	classes_count
-- 2 	Доцент Петров 	4

SELECT
  ed_tutor AS tt_id,
  tt_name,
  classes_count
FROM (
  SELECT
    ed_tutor,
    COUNT(1) AS classes_count
  FROM education
  WHERE 09 = EXTRACT(MONTH FROM ed_date) AND 2012 = EXTRACT(YEAR FROM ed_date)
  GROUP BY ED_TUTOR
  HAVING COUNT(1) = (
    SELECT MAX(COUNT(1))
    FROM education
    WHERE 09 = EXTRACT(MONTH FROM ed_date) AND 2012 = EXTRACT(YEAR FROM ed_date)
    GROUP BY ED_TUTOR
  )
  )
  JOIN tutors ON ed_tutor = tt_id;

-- 4.	Написать запрос, показывающий список студентов и их средние баллы.
-- В результате выполнения запроса должно получиться:
-- st_id 	st_name 	AVG(`ed_mark`)
-- 1 	Воробьёв В.В. 	6.2000
-- 2 	Соколов С.С. 	8.0000
-- 3 	Орлов О.О. 	6.5000
-- 4 	Беркутов Б.Б. 	6.3333
-- 5 	Филинов Ф.Ф. 	8.0000
-- 6 	Прогульщиков П.П. 	NULL

SELECT
  st_id,
  st_name,
  AVG(ed_mark)
FROM education
  RIGHT JOIN students ON EDUCATION.ED_STUDENT = STUDENTS.ST_ID
GROUP BY st_id, st_name
ORDER BY st_id


-- 5.	Написать запрос, показывающий список студентов и названия предметов, по которым они получили самые высокие оценки.
-- В результате выполнения запроса должно получиться:
-- st_id 	st_name 	GROUP_CONCAT(`sb_name`) 	ed_mark
-- 1 	Воробьёв В.В. 	Химия 	10
-- 2 	Соколов С.С. 	Математика 	10
-- 3 	Орлов О.О. 	Физика 	7
-- 4 	Беркутов Б.Б. 	Химия,Английский язык 	10
-- 5 	Филинов Ф.Ф. 	Физика 	8
-- 6 	Прогульщиков П.П. 	NULL	NULL

SELECT
  t2.st_id,
  st_name,
  LISTAGG(convert(sb_name, 'UTF8', 'AL16UTF16'), ',')
  WITHIN GROUP (
    ORDER BY sb_name DESC) AS GROUP_CONCAT,
  ed_mark
FROM (
       SELECT DISTINCT
         t1.ed_student AS st_id,
         sb_name,
         ed_mark
       FROM EDUCATION ed
         JOIN (
                SELECT
                  ed_student,
                  MAX(ed_mark) AS max_mark
                FROM education
                GROUP BY ed_student
              ) t1 ON t1.ed_student = ed.ed_student AND
                      t1.max_mark = ed.ed_mark
         JOIN subjects ON ed.ED_SUBJECT = SUBJECTS.SB_ID
     ) t2
  RIGHT JOIN students ON t2.st_id = STUDENTS.ST_ID
GROUP BY t2.st_id, students.st_name, t2.ed_mark
ORDER BY st_id;

-- 6.	Написать запрос, показывающий имя преподавателя (преподавателей), поставившего самую низкую оценку студенту Соколову С.С.
-- В результате выполнения запроса должно получиться:
-- tt_name
-- Профессор Иванов
-- Доцент Петров

SELECT tt_name
FROM EDUCATION ed
  JOIN (
         SELECT
           ed_student,
           MIN(ed_mark) AS max_mark
         FROM education
         GROUP BY ed_student
       ) t1 ON t1.ed_student = ed.ed_student AND
               t1.max_mark = ed.ed_mark
  JOIN tutors ON ed.ED_TUTOR = TUTORS.TT_ID
  JOIN students ON ed.ED_STUDENT = STUDENTS.ST_ID
WHERE st_name = 'Соколов С.С.';

-- 7.	Написать запрос, проверяющий, не закралась ли в базу ошибка, состоящая в том, что оценка была выставлена по типу занятий, для которого не бывает оценок. Оценки допустимы только для экзаменов и лабораторных работ. Запрос должен возвращать 1 (TRUE), если ошибка есть, и 0 (FALSE), если ошибки нет.
-- В результате выполнения запроса должно получиться:
-- answer
-- 1

SELECT CASE
       WHEN results > 0
         THEN 1
       ELSE 0
       END
  AS answer
FROM
  (
    SELECT COUNT(ed_mark) AS results
    FROM EDUCATION
    WHERE ED_CLASS_TYPE = 1 AND ED_MARK IS NOT NULL
  );

-- 8.	Написать запрос, показывающий 2012-й год по месяцам, причём для каждого месяца вывести название предмета (предметов), по которому было проведено больше всего занятий.
-- В результате выполнения запроса должно получиться:
-- short_date 	subjects_list 	classes
-- 201212 	Химия,Физика 	1
-- 201211 	Английский язык 	5
-- 201210 	Физика 	2
-- 201209 	Химия 	3
-- 201204 	Английский язык 	1
-- 201203 	Физика 	1
-- 201201 	Физика 	1

WITH tmp AS (
    SELECT
      to_char(ed_date, 'yyyymm') AS short_date,
      ed_subject                 AS subjects_list,
      COUNT(1)                   AS classes
    FROM education
    WHERE EXTRACT(YEAR FROM ed_date) = 2012
    GROUP BY to_char(ed_date, 'yyyymm'), ed_subject
)
SELECT
  tmp.short_date,
  LISTAGG(convert(sb_name, 'UTF8', 'AL16UTF16'), ',')
  WITHIN GROUP (
    ORDER BY sb_name DESC) AS subjects_list,
  tmp.classes
FROM tmp
  JOIN subjects ON tmp.subjects_list = SUBJECTS.SB_ID
  JOIN (SELECT
          short_date,
          MAX(classes) AS classes
        FROM tmp
        GROUP BY short_date
       ) t1
    ON tmp.short_date = t1.short_date AND tmp.classes = t1.classes
GROUP BY tmp.short_date, tmp.classes
ORDER BY tmp.short_date DESC;

-- 9.	Написать запрос, показывающий список студентов, чей средний балл ниже среднего балла по университету.
-- В результате выполнения запроса должно получиться:
-- st_id	st_name	avg
-- 1 	Воробьёв В.В. 	6.2000
-- 2 	Соколов С.С. 	7.2000
-- 3 	Орлов О.О. 	6.5000

SELECT
  ed_student AS st_id,
  st_name,
  avg
FROM (
       SELECT
         ed_student,
         AVG(ed_mark) AS avg
       FROM education
       GROUP BY ed_student
       HAVING AVG(ed_mark) < (
         SELECT AVG(ed_mark)
         FROM education
       )
     ) t1
  JOIN students ON t1.ed_student = students.st_id
ORDER BY st_id;

-- 10.	Написать запрос, показывающий список студентов, не изучавших химию и физику.
-- В результате выполнения запроса должно получиться:
-- st_id	st_name
-- 5 	Филинов Ф.Ф. -- был на физике. ed_id=127
-- 6 	Прогульщиков П.П.

SELECT
  st_id,
  st_name
FROM students
  LEFT JOIN EDUCATION ON STUDENTS.ST_ID = EDUCATION.ED_STUDENT
WHERE st_id NOT IN (
  SELECT DISTINCT ed_student
  FROM education
  WHERE ed_subject IN (
    SELECT sb_id
    FROM subjects
    WHERE SB_NAME IN ('Химия', 'Физика')
  )
)

-- 11.	Написать запрос, показывающий список студентов, ни разу не получавших 10-ки.
-- В результате выполнения запроса должно получиться:
-- st_id	st_name
-- 3 	Орлов О.О.
-- 5 	Филинов Ф.Ф.
-- 6 	Прогульщиков П.П.

SELECT DISTINCT
  st_id,
  st_name
FROM students
  LEFT JOIN EDUCATION ON STUDENTS.ST_ID = EDUCATION.ED_STUDENT
WHERE st_id NOT IN (
  SELECT ed_student
  FROM education
  WHERE ed_mark = 10
)
ORDER BY st_id;

-- 12.	Написать запрос, показывающий список предметов, успеваемость студентов по которым выше средней успеваемости по всем предметам в университете.
-- В результате выполнения запроса должно получиться:
-- sb_id	sb_name	avg
-- 2 	Химия 	7.5000
-- 5 	Английский язык 	10.0000

SELECT
  /*+ gather_plan_statistics */
  sb_id,
  sb_name,
  avg
FROM
  (SELECT DISTINCT
     ed_subject,
     AVG(ed_mark)
     OVER (PARTITION BY ed_subject) AS avg,
     AVG(ed_mark)
     OVER ()                        AS avg_sum
   FROM education
  ) t1
  JOIN subjects ON sb_id = ed_subject
WHERE t1.avg > t1.avg_sum
ORDER BY sb_id;
SELECT *
FROM TABLE (dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));
----------- ИЛИ
SELECT
  /*+ gather_plan_statistics */
  sb_id,
  sb_name,
  avg
FROM
  (SELECT
     ed_subject,
     AVG(ed_mark) AS avg
   FROM education
   GROUP BY ed_subject
   HAVING AVG(ed_mark) > (SELECT AVG(ed_mark)
                          FROM education)
  ) t1
  JOIN subjects ON sb_id = ed_subject
ORDER BY sb_id;
SELECT *
FROM TABLE (dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-- 13.	Написать запрос, показывающий, сколько в среднем раз в месяц проходят занятия по каждому предмету. Периодом проведения занятий считать весь диапазон дат от первого до последнего зарегистрированного занятия по каждому предмету в отдельности.
-- В результате выполнения запроса должно получиться:
-- sb_id	sb_name	classes_per_month
-- 1 	Программирование 	0.3333
-- 2 	Химия 	0.3846
-- 3 	Физика 	0.3125
-- 4 	Математика 	2.0000
-- 5 	Английский язык 	0.8571

SELECT
  sb_id,
  sb_name,
  to_char(classes_per_month, 'FM99999999999999990.0000') AS classes_per_month
FROM
  (SELECT
     ed_subject,
     count(ed_subject) / MONTHS_BETWEEN(MAX(ed_date), MIN(ed_date)) AS classes_per_month
   FROM education
   GROUP BY ed_subject
  ) t1
  JOIN subjects ON t1.ED_SUBJECT = SUBJECTS.SB_ID
ORDER BY sb_id;

-- 14.	Написать запрос, показывающий список студентов в порядке убывания среднего балла по предметам, по которым они ещё не сдавали экзамен.
-- В результате выполнения запроса должно получиться:
-- st_id	st_name	sb_id	sb_name	avg
-- 5 	Филинов Ф.Ф. 	3 	Физика 	8.0000
-- 2 	Соколов С.С. 	2 	Химия 	4.0000
-- 1 	Воробьёв В.В. 	1 	Программирование 	4.0000
-- 3 	Орлов О.О. 	1 	Программирование 	NULL

SELECT
  st_id,
  st_name,
  sb_id,
  sb_name,
  to_char(avg, 'FM99999999999999990.0000') AS avg
FROM
  (SELECT
     ed_subject,
     ed_student,
     AVG(ed_mark) AS avg
   FROM EDUCATION
   WHERE (ed_student, ed_subject) NOT IN (
     SELECT DISTINCT
       ed_student,
       ed_subject
     FROM EDUCATION
     WHERE ED_CLASS_TYPE = 2
   )
   GROUP BY ed_subject,
     ed_student) t1
  JOIN students ON st_id = t1.ED_STUDENT
  JOIN subjects ON sb_id = t1.ed_subject
ORDER BY avg DESC NULLS LAST;

-- 15.	Написать запрос, показывающий список преподавателей и количество проведённых каждым преподавателем занятий.
-- В результате выполнения запроса должно получиться:
-- tt_id	tt_name	classes
-- 1 	Профессор Иванов 	13
-- 2 	Доцент Петров 	10
-- 3 	Ассистент Сидоров 	6
-- 4 	Ассистент Неизвестный 	0

SELECT
  tt_id,
  tt_name,
  count(ed_subject) AS classes
FROM education
  RIGHT JOIN tutors ON EDUCATION.ED_TUTOR = TUTORS.TT_ID
GROUP BY tt_id, tt_name
ORDER BY classes DESC;

-- 16.	Написать запрос, показывающий имя преподавателя (преподавателей), не поставившего ни одной оценки.
-- В результате выполнения запроса должно получиться:
-- tt_id	tt_name
-- 4 	Ассистент Неизвестный

SELECT DISTINCT
  tt_id,
  tt_name
FROM (
  SELECT DISTINCT
    tt_id,
    tt_name,
    count(ed_mark)
    OVER (PARTITION BY tt_id) AS mark_count
  FROM tutors
    LEFT JOIN EDUCATION ON TUTORS.TT_ID = EDUCATION.ED_TUTOR
)
WHERE mark_count = 0;

-- 17.	Написать запрос, показывающий список преподавателей и количества поставленных ими оценок в порядке убывания этого количества.
-- В результате выполнения запроса должно получиться:
-- tt_id	tt_name	marks
-- 1 	Профессор Иванов 	8
-- 2 	Доцент Петров 	7
-- 3 	Ассистент Сидоров 	3
-- 4 	Ассистент Неизвестный 	0

SELECT DISTINCT
  tt_id,
  tt_name,
  count(ed_mark)
  OVER (PARTITION BY tt_id) AS mark_count
FROM tutors
  LEFT JOIN EDUCATION ON TUTORS.TT_ID = EDUCATION.ED_TUTOR
ORDER BY mark_count DESC

-- 18.	Написать запрос, показывающий список предметов и средних баллов каждого студента по каждому предмету в порядке убывания среднего балла.
-- В результате выполнения запроса должно получиться:
-- sb_name	st_name	avg
-- Английский язык 	Беркутов Б.Б. 	10.0000
-- Английский язык 	Воробьёв В.В. 	NULL
-- Английский язык 	Орлов О.О. 	NULL
-- Математика 	Соколов С.С. 	7.6667
-- Математика 	Орлов О.О. 	6.0000
-- Программирование 	Беркутов Б.Б. 	8.0000
-- Программирование 	Воробьёв В.В. 	4.0000
-- Программирование 	Орлов О.О. 	NULL
-- Физика 	Соколов С.С. 	9.0000
-- Физика 	Филинов Ф.Ф. 	8.0000
-- Физика 	Орлов О.О. 	7.0000
-- Физика 	Воробьёв В.В. 	5.5000
-- Физика 	Беркутов Б.Б. 	4.0000
-- Химия 	Беркутов Б.Б. 	10.0000
-- Химия 	Воробьёв В.В. 	8.0000
-- Химия 	Соколов С.С. 	4.0000

SELECT
  sb_name,
  st_name,
  to_char(avg, 'FM99999999999999990.0000') AS avg
FROM (
  SELECT DISTINCT
    sb_name,
    st_name,
    AVG(ed_mark)
    OVER (PARTITION BY sb_name, st_name) AS avg
  FROM EDUCATION
    LEFT JOIN students ON EDUCATION.ED_STUDENT = STUDENTS.ST_ID
    LEFT JOIN subjects ON EDUCATION.ED_SUBJECT = SUBJECTS.SB_ID
  ORDER BY sb_name ASC, avg DESC NULLS LAST
);

-- 19.	Написать запрос, показывающий средний балл каждого студента по каждому месяцу обучения.
-- В результате выполнения запроса должно получиться:
-- st_name	short_date	avg
-- Беркутов Б.Б. 	201212 	10.0000
-- Беркутов Б.Б. 	201211 	9.3333
-- Беркутов Б.Б. 	201209 	4.0000
-- Воробьёв В.В. 	201212 	7.0000
-- Воробьёв В.В. 	201210 	4.0000
-- Воробьёв В.В. 	201209 	8.0000
-- Воробьёв В.В. 	201204 	NULL
-- Воробьёв В.В. 	201111 	NULL
-- Орлов О.О. 	201211 	NULL
-- Орлов О.О. 	201210 	6.0000
-- Орлов О.О. 	201209 	NULL
-- Орлов О.О. 	201201 	7.0000
-- Соколов С.С. 	201211 	9.5000
-- Соколов С.С. 	201209 	4.0000
-- Соколов С.С. 	201203 	9.0000
-- Соколов С.С. 	201111 	NULL
-- Соколов С.С. 	201109 	NULL
-- Соколов С.С. 	201004 	NULL
-- Филинов Ф.Ф. 	201210 	8.0000

SELECT
  st_name,
  short_date,
  to_char(avg, 'FM99999999999999990.0000') AS avg
FROM (
  SELECT DISTINCT
    st_name,
    to_char(ed_date, 'yyyymm')                              AS short_date,
    AVG(ed_mark)
    OVER (PARTITION BY st_name, to_char(ed_date, 'yyyymm')) AS avg
  FROM EDUCATION
    LEFT JOIN students ON EDUCATION.ED_STUDENT = STUDENTS.ST_ID
  ORDER BY st_name ASC, avg DESC NULLS LAST
);

-- 20.	Написать запрос, показывающий список студентов и максимальный балл, когда либо полученный данным студентом.
-- В результате выполнения запроса должно получиться:
-- st_name	max
-- Беркутов Б.Б. 	10
-- Воробьёв В.В. 	10
-- Соколов С.С. 	10
-- Филинов Ф.Ф. 	8
-- Орлов О.О. 	7

SELECT /*+ gather_plan_statistics */ DISTINCT
  st_name,
  MAX(ed_mark)
  OVER (PARTITION BY st_name) AS max
FROM students
  JOIN education ON STUDENTS.ST_ID = EDUCATION.ED_STUDENT
ORDER BY max DESC;
SELECT *
FROM TABLE (dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-- 21.	Написать запрос, показывающий студента (студентов) получивших максимальное количество баллов ниже 5.
-- В результате выполнения запроса должно получиться:
-- st_name	bad_marks
-- Воробьёв В.В. 	2
-- Соколов С.С. 	2


-- 22.	Написать запрос, показывающий студента (студентов) посетивших наибольшее количество занятий.
-- В результате выполнения запроса должно получиться:
-- st_name	classes
-- Соколов С.С. 	9


-- 23.	Написать запрос, показывающий список преподавателей и количество проведённых ими занятий и порядке убывания этого количества.
-- В результате выполнения запроса должно получиться:
-- tt_id	tt_name	classes
-- 1 	Профессор Иванов 	13
-- 2 	Доцент Петров 	10
-- 3 	Ассистент Сидоров 	6
-- 4 	Ассистент Неизвестный 	0


-- 24.	Написать запрос, показывающий студента (если такой есть), посетившего большее количество занятий, чем любой другой студент.
-- В результате выполнения запроса должно получиться:
-- st_name	classes
-- Соколов С.С. 	9


-- 25.	Написать запрос, показывающий информацию о том, какой преподаватель по какому предмету поставил какой максимальный балл какому студенту.
-- В результате выполнения запроса должно получиться:
-- tt_name	sb_name	st_name	max
-- Профессор Иванов 	Программирование 	Воробьёв В.В. 	4
-- Профессор Иванов 	Программирование 	Беркутов Б.Б. 	8
-- Профессор Иванов 	Химия 	Соколов С.С. 	4
-- Профессор Иванов 	Физика 	Воробьёв В.В. 	4
-- Профессор Иванов 	Физика 	Беркутов Б.Б. 	4
-- Профессор Иванов 	Физика 	Филинов Ф.Ф. 	8
-- Профессор Иванов 	Математика 	Соколов С.С. 	9
-- Профессор Иванов 	Математика 	Орлов О.О. 	6
-- Доцент Петров 	Химия 	Воробьёв В.В. 	10
-- Доцент Петров 	Физика 	Соколов С.С. 	9
-- Доцент Петров 	Физика 	Орлов О.О. 	7
-- Доцент Петров 	Математика 	Соколов С.С. 	10
-- Доцент Петров 	Английский язык 	Беркутов Б.Б. 	10
-- Ассистент Сидоров 	Химия 	Беркутов Б.Б. 	10
-- Ассистент Сидоров 	Физика 	Воробьёв В.В. 	7
-- Ассистент Сидоров 	Английский язык 	Беркутов Б.Б. 	10


-- 26.	Написать запрос, показывающий студента (студентов), набравшего минимальную сумму баллов.
-- В результате выполнения запроса должно получиться:
-- st_name	sum
-- Филинов Ф.Ф. 	8


-- 27.	Написать запрос, показывающий список предметов, по которым не было ни оценок, ни занятий (занятиями считается любой вид учебной деятельности).
-- В результате выполнения запроса должно получиться:
-- sb_name	classes
-- История КПСС 	0


-- 28.	Написать запрос, показывающий список лабораторных работ по химии, по которым были случаи «студент был на занятии, но не получил оценки».
-- В результате выполнения запроса должно получиться:
-- ed_id	ed_student	ed_tutor	ed_subject	ed_class_type	ed_mark	ed_date
-- 62 	2 	2 	2 	3 	NULL	2011-11-19 15:20:00


-- 29.	Написать запрос, показывающий предмет (предметы), по которому в 2012 году было проведено больше всего экзаменов.
-- В результате выполнения запроса должно получиться:
-- sb_name	exams
-- Физика 	3
-- Английский язык 	3


-- 30.	Написать запрос, показывающий среднее количество экзаменов, проводимых по программированию в месяц.
-- В результате выполнения запроса должно получиться:
-- sb_id	sb_name	exams_per_month
-- 1 	Программирование 	0.0833