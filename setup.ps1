# Flutter Automatic Setup Script for Windows 11
Write-Host "🚀 Starting Full Automatic Setup... Please Wait..."

# 1️⃣ Flutter & Dart Installation
Write-Host "📥 Downloading Flutter & Dart..."
$flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.0-stable.zip"
$flutterZip = "$env:TEMP\flutter.zip"
Invoke-WebRequest -Uri $flutterUrl -OutFile $flutterZip
Expand-Archive -Path $flutterZip -DestinationPath "C:\flutter" -Force
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\flutter\bin", [System.EnvironmentVariableTarget]::Machine)

# 2️⃣ Android SDK & Java Installation
Write-Host "📦 Installing Android SDK & Java..."
choco install -y openjdk11
choco install -y android-sdk
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", "C:\Android\Sdk", [System.EnvironmentVariableTarget]::Machine)

# 3️⃣ Visual Studio Code Installation
Write-Host "🛠️ Installing VS Code..."
choco install -y vscode
code --install-extension Dart-Code.flutter

# 4️⃣ Clone Flutter Project
Write-Host "📥 Cloning Flutter Project..."
$projectPath = "C:\Users\$env:USERNAME\Desktop\Flutter_AI_Assistant"
if (!(Test-Path $projectPath)) {
    git clone https://github.com/chernyo1/Flutter_AI_Setup.git $projectPath
}
Set-Location $projectPath

# 5️⃣ Install Flutter Dependencies
Write-Host "📦 Installing Flutter dependencies..."
flutter pub get

# 6️⃣ Run Flutter Doctor
Write-Host "⚙️ Running Flutter Doctor..."
flutter doctor

# 7️⃣ Build APK
Write-Host "📱 Building Flutter APK..."
flutter build apk

Write-Host "🎉 Setup Completed Successfully! 🚀"
