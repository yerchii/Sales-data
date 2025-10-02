input_file = r"C:\Users\olhay\dbt_project\seeds\sales_data.csv"

# Читаем файл в Windows-1251, потому что там русские буквы
with open(input_file, "r", encoding="cp1251") as f:
    content = f.read()

# Перезаписываем в UTF-8
with open(input_file, "w", encoding="utf-8") as f:
    f.write(content)

print("Файл sales_data.csv успешно перекодирован в UTF-8 с сохранением русских букв")
