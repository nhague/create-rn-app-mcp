# Quick Start 🚀

**TL;DR:** `create-rn-app "My Project"` now scaffolds Native **or** Web apps, wires GitHub (private), and is ready to run in minutes.

---

## Install Once

```bash
cd /Users/nate/Documents/development/create-rn-app-mcp
./install.sh
```

Restart your shell (`exec zsh`).

---

## Run Every Time

```bash
create-rn-app "Your Project Name"
```

You’ll answer a short decision tree:
- App type → React Native or React Web
- Native path → iOS/Android setup, device focus, orientation, optional simulator run
- Web path → Standard vs PWA, plain web vs mockup, mockup device + orientation

All repositories are created as **private** automatically.

---

## What Happens Under the Hood

- React Native: CLI project, optional pods/Gradle warmup, Info.plist & AndroidManifest tweaks, initial commit, push to GitHub.
- React Web (Vite): Vite scaffolding, npm install, optional PWA plugin, optional mockup UI (tablet frame, reset/country buttons, flows + audit drawers), initial commit, push to GitHub.

---

## Example Session

```bash
$ create-rn-app "Tablet Demo"
? Project Type: React Web app
? Web Archetype: Progressive Web App (Vite + PWA plugin)
? Presentation Mode: Mockup of a native app
? Mockup Device Target: Tablet
? Tablet Orientation: Landscape

➡️ Scaffolds Vite + PWA
➡️ Generates Android tablet frame UI
➡️ Commits & pushes to private GitHub repo

✅ Done in ~3 minutes
```

---

## Troubleshooting Quick Hits

- `gh auth login` if GitHub CLI complains.
- `brew install node git gh` to fill missing core tools.
- For PWA builds, drop icons into `public/pwa-192x192.png` & `public/pwa-512x512.png`.

---

Happy shipping! 🎉
