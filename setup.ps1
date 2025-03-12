Write-Host "🚀 Starting Full Automatic Setup... Please Wait..."

# Step 1: सही डायरेक्टरी में जाना
$projectPath = "C:\Users\$env:UserName\Desktop\AI_Assistant"
if (Test-Path $projectPath) {
    Set-Location -Path $projectPath
} else {
    Write-Host "⚠️ Error: AI_Assistant फोल्डर नहीं मिला!"
    exit
}

# Step 2: अपडेट चेक और डाउनलोड करना
Write-Host "✅ AI Assistant Project already exists. Pulling latest updates..."
git pull

# Step 3: Flutter dependencies इंस्टॉल करना
Write-Host "📦 Installing Flutter dependencies..."
if (Test-Path "pubspec.yaml") {
    flutter pub get
} else {
    Write-Host "❌ Error: pubspec.yaml नहीं मिला। कृपया सही डायरेक्टरी में जाएं।"
    exit
}

# Step 4: APK बिल्ड करना
Write-Host "📱 Building Flutter APK..."
flutter build apk

# Step 5: APK का पाथ दिखाना
$apkPath = "$projectPath\build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    Write-Host "✅ APK तैयार है: $apkPath"
} else {
    Write-Host "❌ APK Build Failed! कृपया त्रुटि जांचें।"
}
