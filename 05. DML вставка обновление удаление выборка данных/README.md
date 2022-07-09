# Оглавление

* [Описание задач](#tasks)
* [Схема БД](#scheme)
* [Задача 1](#t1)
* [Задача 2](#t2)
* [Задача 3](#t3)
* [Задача 4](#t4)
* [Задача 5](#t5)
* [Задача 6](#t6)

# <a name="tasks"></a>Описание задач

> 1. Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
> 2. Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на
     результат? Почему?
> 3. Напишите запрос на добавление данных с выводом информации о добавленных строках.
> 4. Напишите запрос с обновлением данные используя UPDATE FROM.
> 5. Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.
> 6. Приведите пример использования утилиты COPY

# <a name="scheme"></a>Схема БД

![](scheme.png)

# <a name="t1"></a>Задача 1

> Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.

Поиск клиента с именами "Petr" и "Pavel".

```postgresql
SELECT c.firstname
FROM prod.customer AS c
WHERE c.firstname SIMILAR TO 'P(e|a)%';
```

# <a name="t2"></a>Задача 2

> Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на
> результат? Почему?

Если необходимо вывести продукты у которых указана цена то используем INNER JOIN:

```postgresql
SELECT pro.name,
       pri.value
FROM prod.product AS pro
         INNER JOIN
     prod.price AS pri
     ON pri.product_id = pro.id
```

В случае, когда необходимо вывести все продукты, даже с отсутствующими ценами то используем LEFT JOIN:

```postgresql
SELECT pro.name,
       pri.value
FROM prod.product AS pro
         LEFT JOIN
     prod.price AS pri
     ON pri.product_id = pro.id
```

Если же поменять таблицы местами, то акцент будет на таблицу цен, а не продуктов.

# <a name="t3"></a>Задача 3

> Напишите запрос на добавление данных с выводом информации о добавленных строках.

```postgresql
INSERT INTO
    prod.product AS p
(name, supplier_id, manufacturer_id, isinstock, description, photourl, code)
VALUES ('Product #3', 1, 1, '0', 'Product 3', 'https://some-url.com/3', 123456),
       ('Product #4', 1, 1, '1', 'Product 4', 'https://some-url.com/4', 123457)
RETURNING (p.id, p.name)
```

# <a name="t4"></a>Задача 4

> Напишите запрос с обновлением данные используя UPDATE FROM.

К примеру, производители становятся поставщиками:

```postgresql
UPDATE prod.manufacturer
SET name = s.name
FROM prod.manufacturer AS m
         JOIN prod.supplier AS s ON m.id = s.id
```

# <a name="t5"></a>Задача 5

> Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.

```postgresql
DELETE
FROM prod.order AS o
    USING
        prod.order_status AS s
WHERE o.order_status_id = s.id
  AND s.value = 'Finished'
```

# <a name="t6"></a>Задача 6

> Приведите пример использования утилиты COPY

К примеру, экспортируем продукты в stdout:

```shell
postgres=# \c store
You are now connected to database "store" as user "postgres".
store=# COPY prod.product TO STDOUT (DELIMITER '|');
1|Product #1|1|1|1|Product|https://image.com|123456
2|Product #2|1|1|1|Product|https://image.com|123456
3|Product #3|1|1|0|Product 3|https://some-url.com/3|123456
4|Product #4|1|1|1|Product 4|https://some-url.com/4|123457
```

или экспортируем в файл:

```shell
store=# COPY prod.product TO '/ssd/products.csv' WITH CSV;
COPY 4
```

Удалим записи и восстановим из файла:

```shell
store=# DELETE FROM prod.product;
DELETE 4
store=# COPY prod.product FROM '/ssd/products.csv' WITH CSV;
COPY 4
```
