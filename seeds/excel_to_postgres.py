import pandas as pd
from sqlalchemy import create_engine

# Параметры подключения к базе PostgreSQL
db_user = "olhay"
db_pass = "Smbok.170417"
db_host = "localhost"
db_port = "5432"
db_name = "dbt_sales"

# Путь к Excel
excel_file = r"C:\Users\olhay\dbt_project\seeds\sales_data.xlsx"

# Имя таблицы в базе
table_name = "sales_data"

# Читаем Excel
df = pd.read_excel(excel_file)

# Создаем подключение к базе
engine = create_engine(f"postgresql+psycopg2://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}")

# Загружаем данные в базу (перезаписываем таблицу, если она уже есть)
df.to_sql(table_name, engine, if_exists='replace', index=False, schema='public')

print(f"Excel {excel_file} успешно загружен в таблицу {table_name} в схему public")
