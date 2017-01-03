USE news_site;

-- 1.	Написать запрос, считающий суммарное количество имеющихся на сайте новостей и обзоров.
-- В результате выполнения запроса должно получиться:
-- SUM
-- 7

SELECT SUM(sum) AS SUM
FROM (
       SELECT COUNT(*) AS sum
       FROM news
       UNION
       SELECT COUNT(*) AS sum
       FROM reviews
     ) AS united;

-- 2.	Написать запрос, показывающий список категорий новостей и количество новостей в каждой категории.
-- В результате выполнения запроса должно получиться:
-- nc_name 	COUNT(`n_id`)
-- Финансы 	1
-- Законодательство 	0
-- Логистика 	4
-- Строительство 	0

SELECT
  nc_name,
  COUNT(n_id)
FROM news_categories
  LEFT JOIN news ON news.n_category = news_categories.nc_id
GROUP BY nc_name
ORDER BY nc_id;

-- 3.	Написать запрос, показывающий список категорий обзоров и количество обзоров в каждой категории.
-- В результате выполнения запроса должно получиться:
-- rc_name 	COUNT(`r_id`)
-- Технологии 	2
-- Товары и услуги 	0

SELECT
  rc_name,
  COUNT(r_id)
FROM reviews_categories
  LEFT JOIN reviews ON reviews_categories.rc_id = reviews.r_category
GROUP BY rc_name
ORDER BY rc_id;

-- 4.	Написать запрос, показывающий список категорий новостей, категорий обзоров и дату самой свежей публикации в каждой категории.
-- В результате выполнения запроса должно получиться:
-- category_name 	last_date
-- Технологии 	2012-12-12 06:31:13
-- Финансы 	2012-12-03 04:15:27
-- Логистика 	2012-12-20 06:11:42


SELECT
  category_name,
  last_date
FROM (
       SELECT
         rc_name AS category_name,
         last_date
       FROM reviews_categories
         LEFT JOIN (SELECT
                      r_category,
                      MAX(r_dt) AS last_date
                    FROM reviews
                    GROUP BY r_category) AS reviews1
           ON reviews1.r_category = reviews_categories.rc_id
       UNION
       SELECT
         nc_name AS category_name,
         last_date
       FROM news_categories
         LEFT JOIN (SELECT
                      n_category,
                      MAX(n_dt) AS last_date
                    FROM news
                    GROUP BY n_category) AS news1
           ON news1.n_category = news_categories.nc_id
     ) AS united
WHERE last_date IS NOT NULL;

-- 5.	Написать запрос, показывающий список страниц сайта верхнего уровня (у таких страниц нет родительской страницы) и список баннеров для каждой такой страницы.
-- В результате выполнения запроса должно получиться:
-- p_name 	b_id 	b_url
-- Юридическим лицам 	1 	http://tut.by
-- Юридическим лицам 	2 	http://tut.by
-- Юридическим лицам 	7 	http://habrahabr.ru
-- Физическим лицам 	1 	http://tut.by

SELECT
  p_name,
  m2m_banners_pages.b_id,
  b_url
FROM banners
  JOIN m2m_banners_pages
    ON m2m_banners_pages.b_id = banners.b_id
  JOIN pages
    ON pages.p_id = m2m_banners_pages.p_id
WHERE p_parent IS NULL;

-- 6.	Написать запрос, показывающий список страниц сайта, на которых есть баннеры.
-- В результате выполнения запроса должно получиться:
-- p_name
-- Юридическим лицам
-- Физическим лицам
-- Образцы договоров
-- Банковские реквизиты
-- Схема проезда к офису

SELECT p_name
FROM pages
WHERE pages.p_id IN (SELECT m2m_banners_pages.p_id
                     FROM m2m_banners_pages);

-- 7.	Написать запрос, показывающий список страниц сайта, на которых нет баннеров.
-- В результате выполнения запроса должно получиться:
-- p_name
-- Почта и телефон
-- Договоры оптовых закупок

SELECT p_name
FROM pages
  LEFT JOIN m2m_banners_pages
    ON pages.p_id = m2m_banners_pages.p_id
WHERE b_id IS NULL;

-- 8.	Написать запрос, показывающий список баннеров, размещённых хотя бы на одной странице сайта.
-- В результате выполнения запроса должно получиться:
-- b_id 	b_url
-- 1 	http://tut.by
-- 2 	http://tut.by
-- 7 	http://habrahabr.ru
-- 4 	http://onliner.by
-- 3 	http://onliner.by

SELECT DISTINCT
  banners.b_id,
  b_url
FROM banners
  RIGHT JOIN m2m_banners_pages
    ON banners.b_id = m2m_banners_pages.b_id AND m2m_banners_pages.p_id IN (SELECT p_id
                                                                            FROM m2m_banners_pages);

-- 9.	Написать запрос, показывающий список баннеров, не размещённых ни на одной странице сайта.
-- В результате выполнения запроса должно получиться:
-- b_id 	b_url
-- 5 	http://google.by
-- 6 	http://google.com
-- 8 	http://habrahabr.ru
-- 9 	http://gismeteo.by
-- 10 	http://gismeteo.ru

SELECT
  banners.b_id,
  b_url
FROM banners
  LEFT JOIN m2m_banners_pages
    ON banners.b_id = m2m_banners_pages.b_id
WHERE p_id IS NULL;

-- 10.	Написать запрос, показывающий баннеры, для которых отношение кликов к показам >= 80% (при условии, что баннер был показан хотя бы один раз).
-- В результате выполнения запроса должно получиться:
-- b_id 	b_url 	rate	
-- 2 	http://tut.by 	150.0000	Да-да, в исходных данных ошибка. Потому тут – 150%.
-- 3 	http://onliner.by 	90.0000	
-- 5 	http://google.by 	100.0000	
-- 6 	http://google.com 	100.0000	
-- 7 	http://habrahabr.ru 	99.7998	
-- 8 	http://habrahabr.ru 	98.0000

SELECT
  b_id,
  b_url,
  (b_click / b_show * 100) AS rate
FROM (SELECT *
      FROM banners
      WHERE b_show > 0) AS all_shown
HAVING rate > 80;

-- 11.	Написать запрос, показывающий список страниц сайта, на которых показаны баннеры с текстом (в поле `b_text` не NULL).
-- В результате выполнения запроса должно получиться:
-- p_name
-- Юридическим лицам
-- Физическим лицам
-- Банковские реквизиты
-- Схема проезда к офису

SELECT DISTINCT p_name
FROM pages
  LEFT JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
  LEFT JOIN banners ON m2m_banners_pages.b_id = banners.b_id
WHERE b_text IS NOT NULL;

-- 12.	Написать запрос, показывающий список страниц сайта, на которых показаны баннеры с картинкой (в поле `b_pic` не NULL).
-- В результате выполнения запроса должно получиться:
-- p_name
-- Юридическим лицам
-- Образцы договоров
-- Банковские реквизиты
-- Схема проезда к офису

SELECT DISTINCT p_name
FROM pages
  LEFT JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
  JOIN (SELECT *
        FROM banners
        WHERE b_pic IS NOT NULL) AS banners_with_pics
    ON m2m_banners_pages.b_id = banners_with_pics.b_id;

-- 13.	Написать запрос, показывающий список публикаций (новостей и обзоров) за 2011-й год.
-- В результате выполнения запроса должно получиться:
-- header 	date
-- Контрабанда железобетонных плит 	2011-09-14 06:19:08
-- Почта России: вчера, сегодня и снова вчера 	2011-08-17 09:06:30
-- Роботы на страже строек 	2011-10-03 05:17:37

SELECT
  header,
  date
FROM (
       SELECT
         n_header AS header,
         n_dt     AS date
       FROM news
       UNION
       SELECT
         r_header AS header,
         r_dt     AS date
       FROM reviews
     ) AS united
WHERE date_format(date, '%Y') = '2011';

-- 14.	Написать запрос, показывающий список категорий публикаций (новостей и обзоров), в которых нет публикаций.
-- В результате выполнения запроса должно получиться:
-- category
-- Законодательство
-- Строительство
-- Товары и услуги

SELECT category
FROM (
       SELECT nc_name AS category
       FROM news_categories
         LEFT JOIN news ON news_categories.nc_id = news.n_category
       WHERE n_id IS NULL
       UNION
       SELECT rc_name AS category
       FROM reviews_categories
         LEFT JOIN reviews ON reviews_categories.rc_id = reviews.r_category
       WHERE r_id IS NULL
     ) AS united;

-- 15.	Написать запрос, показывающий список новостей из категории «Логистика» за 2012-й год.
-- В результате выполнения запроса должно получиться:
-- n_header 	n_dt
-- Самолётом или поездом? 	2012-12-20 06:11:42
-- Куда всё катится? 	2012-12-11 04:36:17

SELECT
  n_header,
  n_dt
FROM news
  JOIN news_categories ON news.n_category = news_categories.nc_id
WHERE nc_name = 'Логистика' AND date_format(n_dt, '%Y') = '2012';

-- 16.	Написать запрос, показывающий список годов, за которые есть новости, а также количество новостей за каждый из годов.
-- В результате выполнения запроса должно получиться:
-- year 	COUNT(*)
-- 2011 	2
-- 2012 	3

SELECT
  date_format(n_dt, '%Y') AS year,
  COUNT(*)
FROM news
GROUP BY year;

-- 17.	Написать запрос, показывающий URL и id таких баннеров, где для одного и того же URL есть несколько баннеров.
-- В результате выполнения запроса должно получиться:
-- b_url 	b_id
-- http://tut.by 	1
-- http://tut.by 	2
-- http://onliner.by 	3
-- http://onliner.by 	4
-- http://habrahabr.ru 	7
-- http://habrahabr.ru 	8

SELECT
  banners.b_url,
  banners.b_id
FROM banners
  JOIN banners AS banners1
    ON banners1.b_id <> banners.b_id AND banners1.b_url = banners.b_url
ORDER BY b_id;

-- 18.	Написать запрос, показывающий список непосредственных подстраниц страницы «Юридическим лицам» со списком баннеров этих подстраниц.
-- В результате выполнения запроса должно получиться:
-- p_name 	b_id 	b_url
-- Образцы договоров 	4 	http://onliner.by
-- Банковские реквизиты 	1 	http://tut.by
-- Банковские реквизиты 	2 	http://tut.by

SELECT
  p_name,
  banners.b_id,
  b_url
FROM (SELECT
        pages1.p_name,
        pages1.p_id
      FROM pages
        JOIN pages AS pages1 ON pages.p_id = pages1.p_parent
      WHERE pages.p_name = 'Юридическим лицам') AS pages_selected
  JOIN m2m_banners_pages ON pages_selected.p_id = m2m_banners_pages.p_id
  JOIN banners ON m2m_banners_pages.b_id = banners.b_id;

-- 19.	Написать запрос, показывающий список всех баннеров с картинками (поле `b_pic` не NULL), отсортированный по убыванию отношения кликов по баннеру к показам баннера.
-- В результате выполнения запроса должно получиться:
-- b_id 	b_url 	rate	
-- 2 	http://tut.by 	1.5000	Да-да, в исходных данных ошибка. Потому тут – 150%.
-- 5 	http://google.by 	1.0000	
-- 6 	http://google.com 	1.0000	
-- 7 	http://habrahabr.ru 	0.9980	
-- 4 	http://onliner.by 	0.0200

SELECT
  b_id,
  b_url,
  (b_click / b_show) AS rate
FROM (SELECT *
      FROM banners
      WHERE b_show > 0 AND b_pic IS NOT NULL) AS shown_banners
ORDER BY rate DESC;

-- 20.	Написать запрос, показывающий самую старую публикацию на сайте (не важно – новость это или обзор).
-- В результате выполнения запроса должно получиться:
-- header 	date
-- Почта России: вчера, сегодня и снова вчера 	2011-08-17 09:06:30


SELECT
  header,
  dt AS date
FROM (
       SELECT
         n_header AS header,
         n_dt     AS dt
       FROM news
       UNION
       SELECT
         r_header AS header,
         r_dt     AS dt
       FROM reviews
     ) AS united
WHERE dt = (SELECT MIN(dt)
            FROM (
                   SELECT
                     n_header AS header,
                     n_dt     AS dt
                   FROM news
                   UNION
                   SELECT
                     r_header AS header,
                     r_dt     AS dt
                   FROM reviews
                 ) AS united1);
-- ИЛИ

SELECT
  header,
  dt AS date
FROM (
       SELECT
         n_header AS header,
         n_dt     AS dt
       FROM news
       UNION
       SELECT
         r_header AS header,
         r_dt     AS dt
       FROM reviews
     ) AS united
ORDER BY date
LIMIT 1;

-- 21.	Написать запрос, показывающий список баннеров, URL которых встречается в таблице один раз.
-- В результате выполнения запроса должно получиться:
-- b_url 	b_id
-- http://google.by 	5
-- http://google.com 	6
-- http://gismeteo.by 	9
-- http://gismeteo.ru 	10

SELECT
  b_url,
  b_id
FROM banners AS primarie
WHERE 1 = (SELECT COUNT(b_url)
           FROM banners AS second
           WHERE second.b_url = primarie.b_url);
-- ИЛИ
SELECT
  b_url,
  b_id
FROM banners
GROUP BY b_url
HAVING COUNT(b_id) = 1
ORDER BY b_id;

-- 22.	Написать запрос, показывающий список страниц сайта в порядке убывания количества баннеров, расположенных на странице. Для случаев, когда на нескольких страницах расположено одинаковое количество баннеров, этот список страниц должен быть отсортирован по возрастанию имён страниц.
-- В результате выполнения запроса должно получиться:
-- p_name 	banners_count
-- Схема проезда к офису 	3
-- Юридическим лицам 	3
-- Банковские реквизиты 	2
-- Образцы договоров 	1
-- Физическим лицам 	1

SELECT
  p_name,
  COUNT(b_id) AS banners_count
FROM pages
  JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id
GROUP BY m2m_banners_pages.p_id
ORDER BY banners_count DESC, p_name ASC;

-- 23.	Написать запрос, показывающий самую «свежую» новость и самый «свежий» обзор.
-- В результате выполнения запроса должно получиться:
-- header 	date
-- Самолётом или поездом? 	2012-12-20 06:11:42
-- Когда всё это кончится?! 	2012-12-12 06:31:13

SELECT
  header,
  dt AS date
FROM (
       SELECT
         n_header AS header,
         n_dt     AS dt
       FROM news
     ) AS ordered_news
WHERE dt = (SELECT MAX(dt)
            FROM (
                   SELECT
                     n_header AS header,
                     n_dt     AS dt
                   FROM news
                 ) AS ordered_news_1)
UNION
SELECT
  header,
  dt AS date
FROM (
       SELECT
         r_header AS header,
         r_dt     AS dt
       FROM reviews
     ) AS ordered_reviews
WHERE dt = (SELECT MAX(dt)
            FROM (
                   SELECT
                     r_header AS header,
                     r_dt     AS dt
                   FROM reviews
                 ) AS ordered_reviews_1);

-- 24.	Написать запрос, показывающий баннеры, в тексте которых встречается часть URL, на который ссылается баннер.
-- В результате выполнения запроса должно получиться:
-- b_id 	b_url 	b_text
-- 1 	http://tut.by 	TUT.BY
-- 3 	http://onliner.by 	ONLINER.BY
-- 5 	http://google.by 	GOOGLE.BY
-- 8 	http://habrahabr.ru 	HABRAHABR.RU

SELECT
  b_id,
  b_url,
  b_text
FROM banners
WHERE LOCATE(SUBSTR(b_url, 8), b_text) > 0

-- 25.	Написать запрос, показывающий страницу, на которой размещён баннер с самым высоким отношением кликов к показам.
-- В результате выполнения запроса должно получиться:
-- p_name
-- Юридическим лицам

SELECT p_name
FROM pages
  JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id
  JOIN (SELECT *
        FROM banners
        WHERE b_show > 0) AS showed_banners ON m2m_banners_pages.b_id = showed_banners.b_id
ORDER BY showed_banners.b_click / showed_banners.b_click
LIMIT 1;

-- 26.	Написать запрос, считающий среднее отношение кликов к показам по всем баннерам, которые были показаны хотя бы один раз.
-- В результате выполнения запроса должно получиться:
-- AVG(`b_click`/`b_show`)
-- 0.81224975

SELECT AVG(`b_click` / `b_show`)
FROM (SELECT *
      FROM banners
      WHERE b_show > 0) AS showed_banners;

-- 27.	Написать запрос, считающий среднее отношение кликов к показам по баннерам, у которых нет графической части (поле `b_pic` равно NULL).
-- В результате выполнения запроса должно получиться:
-- AVG(`b_click`/`b_show`)
-- 0.66000000

SELECT AVG(`b_click` / `b_show`)
FROM (SELECT *
      FROM banners
      WHERE b_show > 0 AND b_pic IS NULL) AS showed_banners;

-- 28.	Написать запрос, показывающий количество баннеров, размещённых на страницах сайта верхнего уровня (у таких страниц нет родительских страниц).
-- В результате выполнения запроса должно получиться:
-- COUNT
-- 4

SELECT COUNT(b_id) AS COUNT
FROM m2m_banners_pages
  JOIN pages ON m2m_banners_pages.p_id = pages.p_id
WHERE p_parent IS NULL;

-- 29.	Написать запрос, показывающий баннер(ы), который(ые) показаны на самом большом количестве страниц.
-- В результате выполнения запроса должно получиться:
-- b_id 	b_url 	COUNT
-- 1 	http://tut.by 	4

SELECT
  banners.b_id,
  b_url,
  COUNT(m2m_banners_pages.p_id) AS COUNT
FROM banners
  JOIN m2m_banners_pages ON banners.b_id = m2m_banners_pages.b_id
GROUP BY b_id
HAVING COUNT(m2m_banners_pages.p_id) = (SELECT MAX(sub_count)
                                        FROM (SELECT COUNT(m2m_banners_pages.p_id) AS sub_count
                                              FROM banners
                                                JOIN m2m_banners_pages ON banners.b_id = m2m_banners_pages.b_id
                                              GROUP BY m2m_banners_pages.b_id) AS sub_query_2);

-- 30.	Написать запрос, показывающий страницу(ы), на которой(ых) показано больше всего баннеров.
-- В результате выполнения запроса должно получиться:
-- p_name 	COUNT
-- Юридическим лицам 	3
-- Схема проезда к офису 	3

SELECT
  p_name,
  COUNT(m2m_banners_pages.b_id) AS COUNT
FROM pages
  JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id
GROUP BY p_name
HAVING COUNT(m2m_banners_pages.b_id) = (SELECT MAX(sub_count)
                                        FROM (SELECT COUNT(m2m_banners_pages.b_id) AS sub_count
                                              FROM pages
                                                JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id
                                              GROUP BY p_name)AS sub_query_2)
ORDER BY p_name DESC;

