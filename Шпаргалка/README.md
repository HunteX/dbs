# Оглавление

* [DDL](#ddl)

# <a name="ddl"></a>DDL

| Описание                       | CLI                | SQL                                                          |
|:-------------------------------|:-------------------|:-------------------------------------------------------------|
| Получение списка БД            | \l                 | SELECT datname, datistemplate, datallowconn FROM pg_database |
| Выбор БД                       | \с [database_name] |                                                              |
| Выбор Схемы                    |                    | SET search_path TO public, other_scheme                      |
| Просмотр схемы по дефолту      |                    | SHOW search_path                                             |
| Получение списка пользователей | \du                | SELECT rolname FROM pg_roles                                 |
| Получение схем БД              | \dn                |                                                              |
| Просмотр таблиц                | \dt (\dt+)         | SELECT * FROM pg_catalog.pg_tables                           |
