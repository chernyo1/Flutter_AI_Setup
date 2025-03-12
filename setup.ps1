# ================================
# ✅ One-Click Automatic Setup Script for Flutter AI Assistant
# ================================

Write-Host "🚀 Starting Full Automatic Setup... Please Wait..." -ForegroundColor Cyan

# Step 1: Create Required Directories
$tempPath = "$env:TEMP\AI_Assistant"
$projectDir = "C:\Users\$env:UserName\Desktop\AI_Assistant"

if (!(Test-Path $tempPath)) {
    mkdir $tempPath -Force
}
if (!(Test-Path $projectDir)) {
    mkdir $projectDir -Force
}

# Step 2: Clone AI Assistant Project from GitHub
$repoUrl = "https://github.com/chernyo1/Flutter_AI_Setup.git"
if (!(Test-Path "$projectDir\.git")) {
    Write-Host "📥 Cloning AI Assistant Project..."
    git clone $repoUrl $projectDir
} else {
    Write-Host "✅ AI Assistant Project already exists. Pulling latest updates..."
    Set-Location -Path $projectDir
    git pull
}

# Step 3: Install Flutter & Dependencies
Write-Host "📦 Installing Flutter dependencies..."
Set-Location -Path $projectDir
flutter pub get

# Step 4: Setup Firebase (if required)
if (Test-Path "$projectDir/firebase_options.dart") {
    Write-Host "⚡ Setting up Firebase..."
    flutterfire configure
}

# Step 5: Build Flutter APK
Write-Host "📱 Building Flutter APK..."
flutter build apk

# Step 6: Run Backend (If Python Server is Required)
$backendPath = "$projectDir\backend"
if (Test-Path "$backendPath\app.py") {
    Write-Host "🚀 Starting Backend Server..."
    Start-Process -NoNewWindow -FilePath "python" -ArgumentList "$backendPath\app.py"
} else {
    Write-Host "⚠️ Backend Not Found. Skipping..."
}

# Step 7: Provide Download Link for APK
$apkPath = "$projectDir\build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    Write-Host "✅ Setup Complete! Download your APK from the following path:" -ForegroundColor Green
    Write-Host $apkPath -ForegroundColor Yellow
} else {
    Write-Host "❌ APK Build Failed! Please check errors." -ForegroundColor Red
}

Write-Host "🎉 Done! Enjoy your AI Assistant. 🚀"
