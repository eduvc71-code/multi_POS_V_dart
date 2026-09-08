$ErrorActionPreference = 'Stop'
$old = "$env:LOCALAPPDATA\Pub\Cache"
$new = "D:\.pub-cache"
Write-Output "Old pub cache: $old"
Write-Output "New pub cache: $new"
if (Test-Path $old) {
    Write-Output "Copying pub cache from C: to D:..."
    robocopy $old $new /MIR | Out-Null
    Write-Output "Removing old pub cache..."
    Remove-Item -Recurse -Force $old -ErrorAction SilentlyContinue
} else {
    Write-Output "Old pub cache not found, creating target..."
    New-Item -ItemType Directory -Force -Path $new | Out-Null
}
Write-Output "Setting PUB_CACHE environment variable (user)..."
setx PUB_CACHE "D:\.pub-cache" | Out-Null
$env:PUB_CACHE = "D:\.pub-cache"
Write-Output "PUB_CACHE now: $env:PUB_CACHE"

cd "d:/multi-pos-1"
Write-Output "Running flutter clean..."
flutter clean

$env:GRADLE_OPTS = '-Xmx4096m -Dorg.gradle.daemon=false -Dkotlin.compiler.execution.strategy=in-process -Dkotlin.incremental=false'
Write-Output "GRADLE_OPTS set to: $env:GRADLE_OPTS"
Write-Output "Starting flutter build apk --release --no-shrink"
flutter build apk --release --no-shrink

if (Test-Path "build/app/outputs/flutter-apk/app-release.apk") {
    Write-Output "BUILD_OK"
    Get-Item "build/app/outputs/flutter-apk/app-release.apk" | Select-Object FullName,Length
} else {
    Write-Output "BUILD_FAILED"
}
