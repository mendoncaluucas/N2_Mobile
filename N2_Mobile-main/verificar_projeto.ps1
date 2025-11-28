# Script de Verificação do Projeto Flutter
Write-Host "=== VERIFICAÇÃO DO PROJETO ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "📁 Estrutura do Projeto:" -ForegroundColor Yellow
if (Test-Path "pubspec.yaml") {
    Write-Host "  ✓ pubspec.yaml encontrado" -ForegroundColor Green
} else {
    Write-Host "  ✗ pubspec.yaml NÃO encontrado" -ForegroundColor Red
}

if (Test-Path "lib\main.dart") {
    Write-Host "  ✓ lib\main.dart encontrado" -ForegroundColor Green
} else {
    Write-Host "  ✗ lib\main.dart NÃO encontrado" -ForegroundColor Red
}

if (Test-Path "lib\services\chamada_service.dart") {
    Write-Host "  ✓ Serviço de chamada encontrado" -ForegroundColor Green
} else {
    Write-Host "  ✗ Serviço de chamada NÃO encontrado" -ForegroundColor Red
}

if (Test-Path "pubspec.lock") {
    Write-Host "  ✓ pubspec.lock encontrado (dependências já instaladas)" -ForegroundColor Green
} else {
    Write-Host "  ⚠ pubspec.lock não encontrado (precisa executar 'flutter pub get')" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🔍 Verificando Flutter SDK:" -ForegroundColor Yellow
$flutterFound = $false

# Verificar se flutter está no PATH
try {
    $flutterVersion = flutter --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Flutter encontrado no PATH" -ForegroundColor Green
        Write-Host "    $($flutterVersion[0])" -ForegroundColor Gray
        $flutterFound = $true
    }
} catch {
    # Flutter não está no PATH, verificar localizações comuns
}

if (-not $flutterFound) {
    Write-Host "  ✗ Flutter SDK não encontrado no PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "📋 Próximos Passos:" -ForegroundColor Cyan
    Write-Host "  1. Instale o Flutter SDK de: https://docs.flutter.dev/get-started/install/windows" -ForegroundColor White
    Write-Host "  2. Adicione o Flutter ao PATH do sistema" -ForegroundColor White
    Write-Host "  3. Abra um novo terminal e execute: flutter doctor" -ForegroundColor White
    Write-Host "  4. Depois execute: flutter pub get" -ForegroundColor White
    Write-Host "  5. Finalmente: flutter run" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "📋 Próximos Passos:" -ForegroundColor Cyan
    Write-Host "  1. flutter pub get" -ForegroundColor White
    Write-Host "  2. flutter devices (para ver dispositivos disponíveis)" -ForegroundColor White
    Write-Host "  3. flutter run" -ForegroundColor White
}

Write-Host ""
Write-Host "Para mais informações, consulte: RODAR_PROJETO.md" -ForegroundColor Gray

