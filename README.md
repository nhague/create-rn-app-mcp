# Create RN App MCP 🚀

**Author:** Nate Hague  
**Version:** 2.0.0  
**Description:** A single command that scaffolds either a React Native mobile app or a React web app (standard or PWA), configures device targets/mockups, and syncs a private GitHub repository end‑to‑end.

---

## 📋 Table of Contents

- [What This Tool Does](#what-this-tool-does)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Install](#quick-install)
  - [Manual Install](#manual-install)
- [Usage](#usage)
- [Features](#features)
- [Configuration Details](#configuration-details)
- [Troubleshooting](#troubleshooting)
- [Uninstallation](#uninstallation)

---

## 🎯 What This Tool Does

The MCP automates the entire project bootstrap workflow:

1. ✅ Prompts for **React Native vs React Web** and records the downstream decisions.
2. ✅ Creates the project (React Native CLI or Vite React) and installs dependencies.
3. ✅ Optionally enables **PWA** behaviour for web projects with `vite-plugin-pwa`.
4. ✅ Scaffolds native-style **mockups** for web projects (phone, tablet, or both) including Android tablet chrome, reset button, country selector, and flows/audit drawers.
5. ✅ Configures device/orientation support in native projects (Info.plist, AndroidManifest).
6. ✅ Initializes Git, creates a **private GitHub repository**, and pushes `main`.

**Without MCP:** 15+ commands, platform-specific edits, a GitHub browser session.  
**With MCP:** One command, guided prompts, finished repo in minutes.

---

## 🔧 Prerequisites

Install the tools you need for the platform(s) you plan to scaffold.

### Core Requirements (Native + Web)

- **Node.js + npm + npx**
  ```bash
  brew install node
  ```
- **Git**
  ```bash
  brew install git
  ```
- **GitHub CLI** (authenticated)
  ```bash
  brew install gh
  gh auth login
  ```

### Additional for React Native Projects

- **CocoaPods** (iOS)
  ```bash
  sudo gem install cocoapods
  ```
- **Xcode** and command-line tools (from the App Store)  
- **Android Studio** + SDK + JDK 11+ (`brew install openjdk@11`)  
  Ensure `ANDROID_HOME` / `ANDROID_SDK_ROOT` are exported in your shell profile.

### Verify Setup

```bash
command -v node && command -v npm && command -v npx && command -v git && command -v gh && echo "✅ Core tools installed"

# Optional platform checks
command -v pod && echo "✅ iOS tooling ready"
echo $ANDROID_HOME && command -v java && echo "✅ Android tooling ready"
```

---

## 📦 Installation

### Quick Install

```bash
cd /Users/nate/Documents/development/create-rn-app-mcp
chmod +x install.sh
./install.sh
```

Restart your terminal (or `source ~/.zshrc`).

### Manual Install

```bash
sudo cp create-rn-app /usr/local/bin/
sudo chmod +x /usr/local/bin/create-rn-app
```

Verify:

```bash
create-rn-app --help
```

---

## 🚀 Usage

```bash
create-rn-app "Your Project Name"
```

Answer the interactive prompts. The flow begins by asking whether you need a **React Native** or **React Web** project, then branches into platform-specific questions:

- React Native → iOS/Android setup, device focus (phone/tablet/universal), orientation, optional simulator run.
- React Web → Standard vs PWA, presentation mode (plain web vs native mockup), mockup device (phone/tablet/both), tablet orientation when relevant.

GitHub repositories are always created as **private** to keep new projects safe by default.

---

## ✨ Features

- **Dual-platform scaffolding** with a single CLI entry point.
- **Native mockup generator** for web projects (Android tablet frame, status bar, reset/country buttons, flows + audit drawers).
- **Automatic PWA wiring** with manifest + service worker configuration.
- **Device/orientation enforcement** for native builds (Info.plist, AndroidManifest).
- **Zero-touch Git/GitHub**: init, commit, and private repo creation with push to `main`.
- **Rollback safety net**: on failure the partially created project and GitHub repo are removed.

---

## 🔍 Configuration Details

### React Native Path

- **Device Type** → Writes `UIDeviceFamily` (iOS) and `<supports-screens>` (Android).
- **Orientation** → Updates `UISupportedInterfaceOrientations` (iOS) and `android:screenOrientation` (Android).
- **Initial test run** → Optional launch into iOS simulator or Android emulator.

### React Web Path

- **Standard vs PWA** → Generates plain Vite React app or installs `vite-plugin-pwa` and overwrites `vite.config.js` with sensible defaults (remember to add your own icons under `public/`).
- **Mockup Mode** →
  - Phone: fixed 390×844 viewport.
  - Tablet (portrait/landscape): Android tablet frame, guided flows drawer, audit drawer, reset + country selector, status bar, and purple gradient stage copied from Nate’s Foodchoo demo.
  - Both: responsive shell that switches between phone and tablet breakpoints.
- **Plain Web** → Leaves vanilla Vite structure; you can layer your own UI on top.

---

## 🛠️ Troubleshooting

- **Command not found** → Ensure `/usr/local/bin` is in `$PATH`, rerun install.
- **GitHub CLI auth errors** → Run `gh auth login` (script stops until authenticated).
- **Missing platform tooling** → Install pods/JDK/Android Studio per prerequisites; prompts include warning summaries.
- **PWA icons missing** → Provide `public/pwa-192x192.png`, `public/pwa-512x512.png`, and (optionally) a maskable variant before shipping.

---

## 🧹 Uninstallation

```bash
sudo rm /usr/local/bin/create-rn-app
```

If you copied supporting template helpers elsewhere, remove those as well.

---

Happy building! 🎉
