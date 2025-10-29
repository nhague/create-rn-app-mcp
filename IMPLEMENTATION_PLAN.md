# Implementation Plan: Universal React App Creator

This plan documents the major workstreams that turned `create-rn-app` into a dual React Native/React Web scaffold and highlights follow-up ideas.

---

## ✅ Completed Workstreams

- **Interactive branching** – Added an app-type question up front and split follow-up prompts into native-specific (platform setup, orientation) and web-specific (standard vs PWA, mockup mode, tablet orientation) flows.
- **Web scaffolding** – Integrated Vite project creation, npm install, optional PWA plugin configuration, and mockup template generation driven by answers.
- **Template extraction** – Recreated the Foodchoo tablet experience inside generator functions that write React components/CSS for the tablet frame, status bar, reset/country buttons, and flows/audit drawers.
- **Git automation updates** – Normalised the flow so both branches initialise a repo, create a private GitHub remote, and push an appropriate “Initial commit” message.

---

## 📌 Open Opportunities

- **Template modularity** – Move JSX/CSS into template files on disk and copy them instead of embedding long heredocs in Bash.
- **Testing hooks** – Add optional smoke tests (e.g. `npm run build` for web, `npx react-native doctor` for native) gated by user choice.
- **Custom Git settings** – Offer toggles for repo visibility in the future, or allow choosing organisation/owner.
- **Telemetry / analytics** – Capture anonymised scaffold choices locally to understand usage patterns (opt-in).

---

Use this plan as a high-level reference when extending the MCP further.
