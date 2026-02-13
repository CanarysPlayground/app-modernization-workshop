# Setup Verification Script for Game Arena Workshop
# Run this to verify all required tools are installed

Write-Host "🎮 Game Arena Legends - Workshop Setup Verification" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

$allGood = $true

# Function to check if command exists
function Test-Command {
    param($CommandName, $MinVersion, $DisplayName)
    
    Write-Host "Checking $DisplayName..." -NoNewline
    
    try {
        $version = & $CommandName --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host " ✅ Installed" -ForegroundColor Green
            Write-Host "  Version: $version" -ForegroundColor Gray
            return $true
        }
    }
    catch {
        Write-Host " ❌ Not found" -ForegroundColor Red
        return $false
    }
    
    Write-Host " ❌ Not found" -ForegroundColor Red
    return $false
}

# Check Java
Write-Host "`n📦 Backend Requirements:" -ForegroundColor Yellow
$javaOk = Test-Command "java" "17" "Java JDK"
if (-not $javaOk) {
    Write-Host "  Install from: https://adoptium.net/" -ForegroundColor Gray
    $allGood = $false
}

$mavenOk = Test-Command "mvn" "3.8" "Maven"
if (-not $mavenOk) {
    Write-Host "  Install from: https://maven.apache.org/download.cgi" -ForegroundColor Gray
    $allGood = $false
}

# Check .NET
$dotnetOk = Test-Command "dotnet" "8.0" ".NET SDK"
if (-not $dotnetOk) {
    Write-Host "  Install from: https://dotnet.microsoft.com/download" -ForegroundColor Gray
    $allGood = $false
}

# Check Node.js
Write-Host "`n🎨 Frontend Requirements:" -ForegroundColor Yellow
$nodeOk = Test-Command "node" "20" "Node.js"
if (-not $nodeOk) {
    Write-Host "  Install from: https://nodejs.org/" -ForegroundColor Gray
    $allGood = $false
}

$npmOk = Test-Command "npm" "10" "npm"
if (-not $npmOk) {
    Write-Host "  Comes with Node.js" -ForegroundColor Gray
    $allGood = $false
}

# Check Docker
Write-Host "`n🐳 Container Requirements:" -ForegroundColor Yellow
$dockerOk = Test-Command "docker" "24" "Docker"
if (-not $dockerOk) {
    Write-Host "  Install from: https://www.docker.com/products/docker-desktop" -ForegroundColor Gray
    $allGood = $false
}

# Check Python (for data pipeline)
Write-Host "`n📊 Data Engineering Requirements:" -ForegroundColor Yellow
$pythonOk = Test-Command "python" "3.11" "Python"
if (-not $pythonOk) {
    # Try python3
    $pythonOk = Test-Command "python3" "3.11" "Python3"
    if (-not $pythonOk) {
        Write-Host "  Install from: https://www.python.org/downloads/" -ForegroundColor Gray
        $allGood = $false
    }
}

# Check Git
Write-Host "`n🔧 Development Tools:" -ForegroundColor Yellow
$gitOk = Test-Command "git" "2.40" "Git"
if (-not $gitOk) {
    Write-Host "  Install from: https://git-scm.com/downloads" -ForegroundColor Gray
    $allGood = $false
}

# Check VS Code (optional but recommended)
Write-Host "`nChecking Visual Studio Code..." -NoNewline
$vscodeInstalled = Get-Command code -ErrorAction SilentlyContinue
if ($vscodeInstalled) {
    Write-Host " ✅ Installed" -ForegroundColor Green
} else {
    Write-Host " ⚠️  Not found (recommended)" -ForegroundColor Yellow
    Write-Host "  Install from: https://code.visualstudio.com/" -ForegroundColor Gray
}

# Check GitHub Copilot
Write-Host "`n🤖 AI Assistant:" -ForegroundColor Yellow
Write-Host "  GitHub Copilot: Please verify in VS Code" -ForegroundColor Gray
Write-Host "  - Open VS Code" -ForegroundColor Gray
Write-Host "  - Check status bar for Copilot icon" -ForegroundColor Gray
Write-Host "  - Ensure you're signed in and Copilot is active" -ForegroundColor Gray
Write-Host ""
Write-Host "  Required VS Code Extensions:" -ForegroundColor Yellow
Write-Host "  1. GitHub Copilot Chat" -ForegroundColor Gray
Write-Host "  2. GitHub Copilot App Modernization (vscjava.migrate-java-to-azure)" -ForegroundColor Gray
Write-Host "  3. GitHub Copilot - Java Upgrade (vscjava.vscode-java-upgrade)" -ForegroundColor Gray
Write-Host "  4. GitHub Copilot for .NET (ms-dotnettools.vscodedotnet-modernize)" -ForegroundColor Gray
Write-Host ""
Write-Host "  Quick install command:" -ForegroundColor Gray
Write-Host "  code --install-extension GitHub.copilot-chat" -ForegroundColor Cyan
Write-Host "  code --install-extension vscjava.migrate-java-to-azure" -ForegroundColor Cyan
Write-Host "  code --install-extension vscjava.vscode-java-upgrade" -ForegroundColor Cyan
Write-Host "  code --install-extension ms-dotnettools.vscodedotnet-modernize" -ForegroundColor Cyan

# Summary
Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
if ($allGood) {
    Write-Host "🎉 All required tools are installed!" -ForegroundColor Green
    Write-Host "   You're ready to start the workshop!" -ForegroundColor Green
    Write-Host "`n   Next step: Navigate to docs/README.md" -ForegroundColor Cyan
} else {
    Write-Host "⚠️  Some tools are missing" -ForegroundColor Yellow
    Write-Host "   Please install the missing tools and run this script again" -ForegroundColor Yellow
}
Write-Host ("=" * 60) -ForegroundColor Cyan

# Create directories if they don't exist
Write-Host "`n📁 Creating project directories..." -ForegroundColor Yellow
$directories = @(
    "legacy-code",
    "modernized-code",
    "scripts",
    "docs"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
        Write-Host "  Created: $dir" -ForegroundColor Gray
    }
}

Write-Host "✅ Setup verification complete!" -ForegroundColor Green
