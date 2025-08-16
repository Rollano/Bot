#!/bin/bash
# both-G All-in-One Tools for Rooted Android
# Bash script for Termux

echo "=============================="
echo "   both-G Root & Tweaks Tools"
echo "=============================="

echo "Select an option:"
echo "1) Root check & device info"
echo "2) Tweaks (CPU, DPI, Resolution)"
echo "3) App manager (list/uninstall/backup apps)"
echo "4) Exit"

read -p "Enter choice [1-4]: " choice

case $choice in
1)
    echo "🔍 Checking root access..."
    if command -v su >/dev/null 2>&1; then
        echo "✅ Root access available"
    else
        echo "❌ No root access"
    fi
    echo "📱 Device info:"
    uname -a
    getprop ro.product.model
    getprop ro.build.version.release
    ;;
2)
    echo "⚙️ Tweaks menu:"
    echo "1) Show CPU info"
    echo "2) Change screen DPI (requires root)"
    echo "3) Change resolution (requires root)"
    read -p "Select tweak [1-3]: " tweak
    case $tweak in
        1) cat /proc/cpuinfo ;;
        2) read -p "Enter new DPI value: " dpi
           su -c "wm density $dpi"
           echo "✅ DPI changed to $dpi" ;;
        3) read -p "Enter new resolution WIDTHxHEIGHT (e.g., 1080x1920): " res
           su -c "wm size $res"
           echo "✅ Resolution changed to $res" ;;
    esac
    ;;
3)
    echo "📦 App manager menu:"
    echo "1) List installed apps"
    echo "2) Uninstall app"
    echo "3) Backup app (APK)"
    read -p "Select option [1-3]: " app_choice
    case $app_choice in
        1) pm list packages ;;
        2) read -p "Enter package name to uninstall: " pkg
           su -c "pm uninstall $pkg"
           echo "✅ $pkg uninstalled" ;;
        3) read -p "Enter package name to backup: " pkg
           mkdir -p ~/bothG_backup
           cp -v /data/app/$pkg-*/base.apk ~/bothG_backup/
           echo "✅ $pkg backed up to ~/bothG_backup" ;;
    esac
    ;;
4)
    echo "👋 Exiting..."
    exit 0
    ;;
*)
    echo "❌ Invalid choice"
    ;;
esac

echo "=============================="
