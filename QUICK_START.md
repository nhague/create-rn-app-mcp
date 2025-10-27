# Quick Start Guide 🚀

**TL;DR:** One command to create a React Native project and sync it to GitHub.

---

## Installation (Do Once)

```bash
cd /Users/nate/Documents/development/create-rn-app-mcp
./install.sh
```

Restart your terminal.

---

## Usage (Every Time)

```bash
create-rn-app "Your Project Name"
```

Answer 4 simple questions, and you're done!

---

## What It Does

1. ✅ Creates React Native CLI project
2. ✅ Installs iOS dependencies
3. ✅ Creates GitHub repository
4. ✅ Pushes your code
5. ✅ Opens in simulator (optional)

---

## Example

```bash
$ create-rn-app "Food App"

# Select options:
1. Repository Visibility: Private
2. iOS Dependencies: Yes
3. Initial Test Run: No
4. Description: A food delivery app

# Wait 3 minutes...

✅ Done! Project created and synced to GitHub.
```

---

## Installation on Other Machines

### Option 1: Copy the folder
```bash
# Copy create-rn-app-mcp folder to new machine
cd create-rn-app-mcp
./install.sh
```

### Option 2: From GitHub (after you push it)
```bash
git clone https://github.com/yourusername/create-rn-app-mcp.git
cd create-rn-app-mcp
./install.sh
```

---

## Troubleshooting

### "Command not found"
```bash
sudo cp create-rn-app /usr/local/bin/
sudo chmod +x /usr/local/bin/create-rn-app
```

### "GitHub CLI not authenticated"
```bash
gh auth login
```

### "Missing tools"
```bash
brew install node git gh
sudo gem install cocoapods
```

---

## Next Steps

- Read `README.md` for full documentation
- Read `CONVERSATION_SUMMARY.md` to understand the workflow
- Create your first project!

---

**Happy coding!** 🎉
