$inputFile = "C:\Users\olhay\dbt_project\seeds\sales_data.csv"
$content = Get-Content -Path $inputFile -Encoding Default
Set-Content -Path $inputFile -Value $content -Encoding utf8
Write-Host "Файл sales_data.csv перекодирован в чистый UTF-8 (без BOM)"
