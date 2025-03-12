# 1️⃣ Execution Policy सेट करें
Set-ExecutionPolicy Unrestricted -Scope Process -Force

# 2️⃣ Windows अपडेट करें
Write-Host "🔄 Windows अपडेट चेक कर रहे हैं..."
Start-Process "ms-settings:windowsupdate" -Wait

# 3️⃣ Git & Chocolatey इंस्टॉल करें (अगर पहले से नहीं है)
if (-Not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "🔄 Git इंस्टॉल किया जा रहा है..."
    Invoke-WebRequest -Uri "https://git-scm.com/download/win" -OutFile "$env:TEMP\git.exe"
    Start-Process "$env:TEMP\git.exe" -ArgumentList "/silent" -Wait
}

if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "🔄 Chocolatey इंस्टॉल कर रहे हैं..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# 4️⃣ Flutter और Android SDK इंस्टॉल करें
if (-Not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "🚀 Flutter और Android SDK इंस्टॉल कर रहे हैं..."
    choco install flutter android-sdk -y
    refreshenv
}

# 5️⃣ Python और आवश्यक पैकेज इंस्टॉल करें
if (-Not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "🐍 Python इंस्टॉल कर रहे हैं..."
    choco install python -y
    refreshenv
}

Write-Host "🔄 Python dependencies इंस्टॉल कर रहे हैं..."
pip install flask openai pyttsx3 speechrecognition

# 6️⃣ प्रोजेक्ट डाउनलोड करें और सेटअप करें
Write-Host "📥 AI Assistant का कोड डाउनलोड कर रहे हैं..."
git clone https://github.com/yourusername/yourrepo.git "$env:TEMP\AI_Assistant"
cd "$env:TEMP\AI_Assistant"

Write-Host "🚀 Backend सर्वर स्टार्ट कर रहे हैं..."
Start-Process -NoNewWindow -FilePath "python" -ArgumentList "backend/app.py"

Write-Host "⚙️ Flutter ऐप सेटअप कर रहे हैं..."
cd frontend
flutter pub get
flutter build apk

Write-Host "📲 APK इंस्टॉल कर रहे हैं..."
adb install build/app/outputs/flutter-apk/app-release.apk

Write-Host "✅ 🎉 सब कुछ इंस्टॉल हो गया! अब आप अपने मोबाइल पर ऐप चला सकते हैं!"
