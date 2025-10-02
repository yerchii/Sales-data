import pandas as pd

# Путь к Excel файлу
excel_file = r"C:\Users\olhay\dbt_project\seeds\sales_data.xlsx"

# Путь для сохранения CSV, который будет seed-файлом dbt
csv_file = r"C:\Users\olhay\dbt_project\seeds\sales_data.csv"

# Читаем Excel
df = pd.read_excel(excel_file)

# Сохраняем в CSV в кодировке UTF-8 без BOM
df.to_csv(csv_file, index=False, encoding='utf-8')

print("Excel успешно сохранён как UTF-8 CSV для dbt seed")
