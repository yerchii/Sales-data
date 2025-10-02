Проект Sales-data
Опис

Цей проект аналізує продажі за допомогою dbt.
У проекті використані SQL-моделі, тести даних та seed-файли для завантаження початкових даних.

Використана база даних

СУБД: PostgreSQL

Таблиці та колонки:

sales_data (seed)

Основні колонки: reference_id, product_name, sales_agents, country, source, campaign_name, revenue_total, revenue_rebill, number_of_rebills, discount_amount, returned_amount, order_date_kyiv, order_date_utc, order_date_ny, return_date_kyiv, return_date_utc, return_date_ny, days_diff

Як запускати проект
Встановлення dbt

Встановити dbt (версія 1.10.13):

pip install dbt-postgres==1.10.13

Налаштування профілю dbt

У файлі profiles.yml (зазвичай ~/.dbt/) налаштувати підключення до PostgreSQL:

dbt_project:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: <ваш_логін>
      password: <ваш_пароль>
      port: 5432
      dbname: <назва_бази>
      schema: public

Запуск проекту
dbt clean
dbt deps
dbt seed
dbt run
dbt test

Використані інструменти

DBeaver — для роботи з базою даних

Підключення до PostgreSQL через JDBC

Можна переглядати дані та перевіряти SQL-запити

dbt — для управління моделями та тестами даних

Пояснення по проекту

Всі моделі зберігаються у папці models/

Тести даних знаходяться у tests/ та schema.yml

Seed-файл sales_data.csv завантажується через dbt seed

Основні цілі проекту:

Очистка та підготовка даних про продажі

Аналіз знижок та доходів

Виявлення агентів, які надають знижки вище середнього