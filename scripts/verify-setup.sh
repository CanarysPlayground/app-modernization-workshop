#!/bin/bash

# Setup Verification Script for Game Arena Workshop (macOS/Linux)
# Run this to verify all required tools are installed

echo "🎮 Game Arena Legends - Workshop Setup Verification"
echo "============================================================"
echo ""

ALL_GOOD=true

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Function to check if command exists
check_command() {
    local cmd=$1
    local name=$2
    local install_url=$3
    
    echo -n "Checking $name..."
    
    if command -v $cmd &> /dev/null; then
        version=$($cmd --version 2>&1 | head -n 1)
        echo -e " ${GREEN}✅ Installed${NC}"
        echo -e "  ${GRAY}Version: $version${NC}"
        return 0
    else
        echo -e " ${RED}❌ Not found${NC}"
        echo -e "  ${GRAY}Install from: $install_url${NC}"
        ALL_GOOD=false
        return 1
    fi
}

# Backend Requirements
echo -e "\n${YELLOW}📦 Backend Requirements:${NC}"
check_command "java" "Java JDK" "https://adoptium.net/"
check_command "mvn" "Maven" "https://maven.apache.org/download.cgi"
check_command "dotnet" ".NET SDK" "https://dotnet.microsoft.com/download"

# Frontend Requirements
echo -e "\n${YELLOW}🎨 Frontend Requirements:${NC}"
check_command "node" "Node.js" "https://nodejs.org/"
check_command "npm" "npm" "https://nodejs.org/"

# Container Requirements
echo -e "\n${YELLOW}🐳 Container Requirements:${NC}"
check_command "docker" "Docker" "https://www.docker.com/products/docker-desktop"

# Data Engineering Requirements
echo -e "\n${YELLOW}📊 Data Engineering Requirements:${NC}"
if ! check_command "python" "Python" "https://www.python.org/downloads/"; then
    check_command "python3" "Python3" "https://www.python.org/downloads/"
fi

# Development Tools
echo -e "\n${YELLOW}🔧 Development Tools:${NC}"
check_command "git" "Git" "https://git-scm.com/downloads"

# Check VS Code
echo -n "Checking Visual Studio Code..."
if command -v code &> /dev/null; then
    echo -e " ${GREEN}✅ Installed${NC}"
else
    echo -e " ${YELLOW}⚠️  Not found (recommended)${NC}"
    echo -e "  ${GRAY}Install from: https://code.visualstudio.com/${NC}"
fi

# GitHub Copilot
echo -e "\n${YELLOW}🤖 AI Assistant:${NC}"
echo -e "  ${GRAY}GitHub Copilot: Please verify in VS Code${NC}"
echo -e "  ${GRAY}- Open VS Code${NC}"
echo -e "  ${GRAY}- Check status bar for Copilot icon${NC}"
echo -e "  ${GRAY}- Ensure you're signed in and Copilot is active${NC}"
echo ""
echo -e "  ${YELLOW}Required VS Code Extensions:${NC}"
echo -e "  ${GRAY}1. GitHub Copilot Chat${NC}"
echo -e "  ${GRAY}2. GitHub Copilot App Modernization (vscjava.migrate-java-to-azure)${NC}"
echo -e "  ${GRAY}3. GitHub Copilot - Java Upgrade (vscjava.vscode-java-upgrade)${NC}"
echo -e "  ${GRAY}4. GitHub Copilot for .NET (ms-dotnettools.vscodedotnet-modernize)${NC}"
echo ""
echo -e "  ${GRAY}Quick install commands:${NC}"
echo -e "  ${CYAN}code --install-extension GitHub.copilot-chat${NC}"
echo -e "  ${CYAN}code --install-extension vscjava.migrate-java-to-azure${NC}"
echo -e "  ${CYAN}code --install-extension vscjava.vscode-java-upgrade${NC}"
echo -e "  ${CYAN}code --install-extension ms-dotnettools.vscodedotnet-modernize${NC}"

# Summary
echo ""
echo "============================================================"
if [ "$ALL_GOOD" = true ]; then
    echo -e "${GREEN}🎉 All required tools are installed!${NC}"
    echo -e "${GREEN}   You're ready to start the workshop!${NC}"
    echo -e "\n${CYAN}   Next step: Navigate to docs/README.md${NC}"
else
    echo -e "${YELLOW}⚠️  Some tools are missing${NC}"
    echo -e "${YELLOW}   Please install the missing tools and run this script again${NC}"
fi
echo "============================================================"

# Create directories if they don't exist
echo -e "\n${YELLOW}📁 Creating project directories...${NC}"
directories=("legacy-code" "modernized-code" "scripts" "docs")

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "  ${GRAY}Created: $dir${NC}"
    fi
done

echo -e "${GREEN}✅ Setup verification complete!${NC}"
