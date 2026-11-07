# Build the Windows installer

The ZIP downloaded with GitHub's **Code > Download ZIP** contains the source code, not an installer. To create the Windows `.exe` installer, use a Windows PC and follow these steps:

1. Install [Bun](https://bun.sh) and [Git](https://git-scm.com/download/win).
2. Download or clone this repository and extract it if needed.
3. Double-click `build-windows.bat` in the repository folder. Keep the computer connected to the internet while dependencies and the desktop CLI are downloaded and the app is built.
4. When it finishes, open `dist\desktop\opencode-desktop-win-x64.exe` to install the app.

The script builds the Windows x64 desktop app only. Building requires a terminal internally; the installed Electron app launches as a normal desktop window, without displaying a terminal window.
