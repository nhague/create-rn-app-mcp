# React Native Project Creation MCP 🚀

**Author:** Nate Hague
**Version:** 1.0.0
**Description:** An interactive command-line tool that automates the complete workflow of creating a React Native (CLI) project, setting up GitHub repository, and syncing them together.

---

## 📋 Table of Contents

- [What This Tool Does](#what-this-tool-does)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Install](#quick-install)
  - [Manual Install](#manual-install)
- [Usage](#usage)
- [Features](#features)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Uninstallation](#uninstallation)
- [The Workflow Explained](#the-workflow-explained)

---

## 🎯 What This Tool Does

This MCP (Master Control Program) automates the entire process of creating a production-ready React Native project:

1. ✅ Creates a new React Native CLI project (non-Expo)
2. ✅ Installs iOS dependencies via CocoaPods
3. ✅ Creates a new GitHub repository
4. ✅ Initializes Git and pushes your code
5. ✅ Optionally launches the app in iOS simulator

**Without this tool:** 15+ manual commands, ~10 minutes
**With this tool:** One command, 3 minutes, zero mistakes

---

## 🔧 Prerequisites

Before installing, make sure you have these tools installed on your Mac:

### Required Tools

1. **Node.js & npm**
   ```bash
   brew install node
   ```

2. **React Native CLI** (installed via npx - no separate installation needed)

3. **Git**
   ```bash
   brew install git
   ```

4. **GitHub CLI**
   ```bash
   brew install gh
   gh auth login
   ```

5. **CocoaPods** (for iOS development)
   ```bash
   sudo gem install cocoapods
   ```

6. **Xcode** (download from Mac App Store)
   - Also install Xcode Command Line Tools:
     ```bash
     xcode-select --install
     ```

### Verify Prerequisites

Run this command to check if everything is installed:

```bash
command -v node && command -v npx && command -v git && command -v gh && command -v pod && echo "✅ All prerequisites met!"
```

---

## 📦 Installation

### Quick Install

1. Clone or download this repository
2. Run the installation script:

```bash
cd create-rn-app-mcp
chmod +x install.sh
./install.sh
```

3. Restart your terminal (or run `source ~/.zshrc`)

### Manual Install

1. Copy the script to your system PATH:

```bash
sudo cp create-rn-app /usr/local/bin/
sudo chmod +x /usr/local/bin/create-rn-app
```

2. Verify installation:

```bash
create-rn-app --help
```

---

## 🚀 Usage

### Basic Usage

```bash
create-rn-app "Your Project Name"
```

### Interactive Configuration

When you run the command, you'll be asked to configure:

1. **Repository Visibility**
   - Public (anyone can see)
   - Private (only you can see)

2. **iOS Dependencies**
   - Install iOS pods (recommended for macOS)
   - Skip iOS setup (for Linux/Windows or Android-only)

3. **Initial Test Run**
   - Launch app in simulator after setup
   - Skip test run (faster)

4. **Repository Description**
   - Optional description for your GitHub repo

### Example Session

```bash
$ create-rn-app "Food Delivery App"

🚀 React Native Project Creation MCP 🚀

➡️  Checking prerequisites...
✅ All prerequisites met! Logged in as: nhague

ℹ️  Sanitized project name: FoodDeliveryApp

Let's configure your project:

1. GitHub Repository Visibility
   1) Public (anyone can see)
   2) Private (only you can see)
   Select an option (1-2): 2

2. iOS Dependencies
   1) Install iOS pods (recommended for macOS)
   2) Skip iOS setup
   Select an option (1-2): 1

3. Initial Test Run
   1) Launch app in simulator after setup
   2) Skip test run (faster)
   Select an option (1-2): 2

4. Repository Description
   Enter a description (optional): A food delivery mobile app

Configuration Summary:
  - Project Name:    FoodDeliveryApp
  - Location:        /Users/nate/Documents/development/FoodDeliveryApp
  - Visibility:      private
  - Install iOS:     true
  - Run Test:        false
  - Description:     A food delivery mobile app
  - GitHub URL:      https://github.com/nhague/FoodDeliveryApp

Proceed with these settings? (y/n): y

[Project creation proceeds...]

✅ SUCCESS! ✅

Your project 'FoodDeliveryApp' is ready!

📍 Local path:  /Users/nate/Documents/development/FoodDeliveryApp
🌐 GitHub URL:  https://github.com/nhague/FoodDeliveryApp
```

---

## ✨ Features

### 🛡️ Bulletproof Error Handling

- **Automatic rollback:** If anything fails, the tool cleans up completely
  - Deletes incomplete local project directory
  - Removes created GitHub repository
- **Prerequisite checks:** Validates all required tools before starting
- **Authentication verification:** Ensures GitHub CLI is logged in
- **Input validation:** Checks for duplicate projects and invalid names

### 🎨 User Experience

- **Color-coded output:** Green for success, red for errors, cyan for info
- **Progress indicators:** Shows exactly what step is running (`[1/6]`, `[2/6]`, etc.)
- **Configuration summary:** Review all settings before proceeding
- **Final instructions:** Clear next steps after completion

### 🧠 Smart Features

- **Dynamic GitHub username:** Automatically detects your GitHub account
- **PascalCase conversion:** "my cool app" becomes "MyCoolApp"
- **Safe naming:** Removes special characters, ensures valid React Native names
- **Duplicate protection:** Won't overwrite existing projects

---

## ⚙️ Configuration

### Changing the Default Project Directory

Edit line 22 in the `create-rn-app` script:

```bash
DEV_DIR="/Users/nate/Documents/development"
```

Change to your preferred location:

```bash
DEV_DIR="/Users/yourname/Projects"
```

### Setting Different Defaults

The tool is interactive, so you choose options each time. If you want to hardcode defaults, modify the `ask_user_preferences()` function.

---

## 🔍 Troubleshooting

### "Command not found: create-rn-app"

**Solution:** The script isn't in your PATH. Run:

```bash
sudo cp create-rn-app /usr/local/bin/
sudo chmod +x /usr/local/bin/create-rn-app
```

Then restart your terminal.

---

### "GitHub CLI is not authenticated"

**Solution:** Log in to GitHub CLI:

```bash
gh auth login
```

Follow the prompts to authenticate.

---

### "Missing required tools: pod"

**Solution:** Install CocoaPods:

```bash
sudo gem install cocoapods
```

If you get permission errors:

```bash
sudo gem install -n /usr/local/bin cocoapods
```

---

### "Project directory already exists"

**Solution:** You've already created a project with that name. Either:
- Choose a different name
- Delete the old project: `rm -rf ~/Documents/development/YourProjectName`

---

### "Error: Project name must start with a letter"

**Solution:** React Native requires project names to start with a letter (A-Z, a-z), not a number or special character.

❌ `create-rn-app "123App"`
✅ `create-rn-app "App123"`

---

## 🗑️ Uninstallation

To remove the tool:

```bash
sudo rm /usr/local/bin/create-rn-app
```

---

## 📖 The Workflow Explained

### Traditional Workflow (Without This Tool)

```bash
# 1. Navigate to dev folder
cd ~/Documents/development

# 2. Create React Native project
npx @react-native-community/cli@latest init MyApp

# 3. Enter project
cd MyApp

# 4. Install iOS dependencies
cd ios
pod install
cd ..

# 5. Go to GitHub.com in browser

# 6. Click "New Repository"

# 7. Fill out form, click create

# 8. Copy commands from GitHub

# 9. Add remote
git remote add origin https://github.com/username/MyApp.git

# 10. Rename branch
git branch -M main

# 11. Push code
git push -u origin main

# 12. Test the app
npx react-native run-ios
```

**Total:** ~15 commands + browser interaction + manual copy/paste
**Time:** ~10 minutes
**Error potential:** High (typos, wrong URLs, forgotten steps)

---

### With This Tool (MCP Workflow)

```bash
create-rn-app "My App"
```

**Total:** 1 command + 4 interactive choices
**Time:** ~3 minutes
**Error potential:** Zero (automatic rollback on failure)

---

## 🎓 Understanding the Code Flow

The script executes in this order:

1. **Print Header** - Shows welcome message
2. **Check Prerequisites** - Validates all required tools
3. **Get Project Name** - Validates and sanitizes input
4. **Ask User Preferences** - Interactive configuration
5. **Create React Native Project** - Runs `npx init`
6. **Install iOS Dependencies** - Runs `pod install` (if selected)
7. **Create GitHub Repo** - Uses `gh repo create`
8. **Push to GitHub** - Runs `git push`
9. **Run Test** - Launches simulator (if selected)
10. **Print Success** - Shows final instructions

If **any step fails**, the trap handler triggers `cleanup_on_error()`:
- Deletes local project folder
- Deletes GitHub repository
- Shows error message

---

## 🤝 Contributing

Found a bug? Have a feature request?

Open an issue or submit a pull request!

---

## 📄 License

MIT License - Feel free to use, modify, and distribute.

---

## 🙏 Credits

Created by **Nate Hague** with assistance from **Claude Code**.

Inspired by the need to eliminate repetitive manual workflows and make React Native project creation a one-command experience.

---

## 📞 Support

For issues, questions, or suggestions:
- Create an issue in this repository
- Email: [your-email@example.com]

---

**Happy coding! 🎉**
