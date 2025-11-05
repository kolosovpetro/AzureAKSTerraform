$esPassword = kubectl get secret elasticsearch-master-credentials -n elk `
-o jsonpath='{.data.password}' | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }

Write-Host "Elasticsearch password: $esPassword"
