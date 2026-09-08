$ErrorActionPreference = 'Stop'
$old = 'C:\Users\Eduardo\AppData\Local\Pub\Cache'
if (Test-Path $old) {
    Write-Output "Removing $old"
    Remove-Item -Recurse -Force $old -ErrorAction SilentlyContinue
    Write-Output "$old removed"
} else {
    Write-Output "$old not found"
}
