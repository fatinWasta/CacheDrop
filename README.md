# CacheDrop

**Clean IDE cache effortlessly on macOS**



CacheDrop is a simple macOS utility that helps you identify and remove cached IDE data and build artifacts and lives in your status bar — saving disk space and improving performance.

It’s designed as a local utility tool with a straightforward UI and zero server dependencies.

Xcode View:

<img width="551" height="697" alt="When Xcode is installed" src="https://github.com/user-attachments/assets/f673e58e-d3aa-43ee-b9cb-95281d4e1424" /> 

Android Studio View:

<img width="561" height="501" alt="When Android Studio is not installed" src="https://github.com/user-attachments/assets/478caf8e-3a28-4686-8130-5fdeeff010a0" />


## ✨ What It Does

- Detects IDE cache directories (Xcode, Android Studio)
- Provides a one-click clean option
- Shows cache size before deletion
- Keeps your disk clean without manual search & delete
- Automations for Xcode

---

## 🎯 Why Use It

Development environments accumulate large caches over time.

CacheDrop helps you:

- Reclaim space quickly
- Prevent project build slowdowns
- Reduce unnecessary storage usage

---

## ⚙️ How It Works

1. Launch CacheDrop
2. Open CacheDrop from status bar.
2. View total cache size
3. Click “Clean” to remove selected caches

No complex configuration. No need to open Finder manually.

---

## 🛠 Architecture

Built with:

- SwiftUI for UI
- Combine for reactive state
- Modern macOS APIs for file operations
- Scalable to more IDEs as per your need

No network. No background daemons.  
Just a simple app to clean caches.

---

## 📦 Requirements

- macOS 13+
- Xcode 15+
- Swift 5.9+

---

## 🛡 Permissions

CacheDrop may request:

- Full disk access (optional, if you target system IDE caches)
- User-selected folder access (via open panel)

It **does not**:
- Send any data externally
- Include analytics

---

## 📞 Support

Report bugs or feature requests on the **Issues** tab.
