import pandas as pd

# Путь к Excel
excel_file = r"C:\Users\olhay\dbt_project\seeds\sales_data.xlsx"
# Путь к CSV для dbt
csv_file = r"C:\Users\olhay\dbt_project\seeds\sales_data.csv"

# Читаем Excel
df = pd.read_excel(excel_file)

# Сохраняем CSV с запятой и UTF-8 без BOM
df.to_csv(csv_file, index=False, sep=',', encoding='utf-8')

print("Excel успешно сохранён как CSV с запятой для dbt.")
