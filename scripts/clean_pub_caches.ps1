$ErrorActionPreference = 'Stop'
$pub = 'D:\.pub-cache\hosted\pub.dev'
Write-Output "Cleaning plugin build directories under $pub"
if (Test-Path $pub) {
    Get-ChildItem $pub -Directory | ForEach-Object {
        $androidBuild = Join-Path $_.FullName 'android\build'
        if (Test-Path $androidBuild) {
            Write-Output "Removing $androidBuild"
            Remove-Item -Recurse -Force $androidBuild -ErrorAction SilentlyContinue
        }
        $kotlinCache = Join-Path $_.FullName 'android\build\kotlin'
        if (Test-Path $kotlinCache) {
            Write-Output "Removing $kotlinCache"
            Remove-Item -Recurse -Force $kotlinCache -ErrorAction SilentlyContinue
        }
    }
} else {
    Write-Output "$pub not found"
}
