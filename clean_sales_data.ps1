# Путь к CSV
$inputFile = "C:\Users\olhay\dbt_project\seeds\sales_data.csv"

# Чтение файла как Windows-1252 (часто безопаснее для смешанных символов)
$content = Get-Content -Path $inputFile -Encoding Default

# Очистка некорректных байтов и символов
$cleanContent = $content -replace '[^\u0000-\uFFFF]', ''

# Сохранение обратно в UTF-8 без BOM
Set-Content -Path $inputFile -Value $cleanContent -Encoding utf8

Write-Host "Файл sales_data.csv очищен от подозрительных символов и перекодирован в UTF-8"
