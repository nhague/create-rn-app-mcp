# Implementation Plan: Device Type & Orientation Support

This document shows exactly what code to add to the `create-rn-app` script.

---

## 🎯 Overview

We'll add these features:
1. Interactive questions for device type (Mobile/Tablet/Both)
2. Interactive questions for orientation (Portrait/Landscape/Both)
3. Functions to configure iOS Info.plist
4. Functions to configure Android AndroidManifest.xml

---

## 📝 Step 1: Add to `ask_user_preferences()` Function

Insert after the "Platform Setup" question (around line 253):

```bash
# Question 3: Device Type
echo -e "${CYAN}3. Device Type${NC}"
PS3="   Select an option (1-3): "
options=("Mobile/Phone only" "Tablet only" "Universal (Mobile + Tablet)")
select opt in "${options[@]}"; do
  case $opt in
    "Mobile/Phone only")
      DEVICE_TYPE="mobile"
      break
      ;;
    "Tablet only")
      DEVICE_TYPE="tablet"
      break
      ;;
    "Universal (Mobile + Tablet)")
      DEVICE_TYPE="universal"
      break
      ;;
    *) echo "Invalid option. Please select 1-3.";;
  esac
done

echo ""

# Question 4: Screen Orientation
echo -e "${CYAN}4. Screen Orientation${NC}"
PS3="   Select an option (1-3): "
options=("Portrait only" "Landscape only" "Both orientations")
select opt in "${options[@]}"; do
  case $opt in
    "Portrait only")
      ORIENTATION="portrait"
      break
      ;;
    "Landscape only")
      ORIENTATION="landscape"
      break
      ;;
    "Both orientations")
      ORIENTATION="both"
      break
      ;;
    *) echo "Invalid option. Please select 1-3.";;
  esac
done

echo ""
```

---

## 📝 Step 2: Update Configuration Summary

Update the summary section to show device type and orientation:

```bash
echo -e "${BOLD}Configuration Summary:${NC}"
echo "  - Project Name:    $PROJECT_NAME"
echo "  - Location:        $PROJECT_PATH"
echo "  - Visibility:      $REPO_VISIBILITY"
echo "  - Setup iOS:       $SETUP_IOS"
echo "  - Setup Android:   $SETUP_ANDROID"
echo "  - Device Type:     $DEVICE_TYPE"          # NEW
echo "  - Orientation:     $ORIENTATION"          # NEW
echo "  - Run Test:        $RUN_TEST"
```

---

## 📝 Step 3: Create iOS Configuration Function

Add this function AFTER `install_ios_dependencies()`:

```bash
# --- Configure iOS Device and Orientation ---

configure_ios_settings() {
  if [ "$SETUP_IOS" = "true" ]; then
    print_step "Configuring iOS device type and orientation..."

    local PLIST_PATH="$PROJECT_PATH/ios/$PROJECT_NAME/Info.plist"

    # Configure Device Type
    case $DEVICE_TYPE in
      mobile)
        # iPhone only
        /usr/libexec/PlistBuddy -c "Delete :UIDeviceFamily" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily:0 integer 1" "$PLIST_PATH"
        print_info "iOS: iPhone only"
        ;;
      tablet)
        # iPad only
        /usr/libexec/PlistBuddy -c "Delete :UIDeviceFamily" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily:0 integer 2" "$PLIST_PATH"
        print_info "iOS: iPad only"
        ;;
      universal)
        # Both
        /usr/libexec/PlistBuddy -c "Delete :UIDeviceFamily" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily:0 integer 1" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UIDeviceFamily:1 integer 2" "$PLIST_PATH"
        print_info "iOS: Universal (iPhone + iPad)"
        ;;
    esac

    # Configure Orientation
    case $ORIENTATION in
      portrait)
        # Portrait only
        /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:0 string UIInterfaceOrientationPortrait" "$PLIST_PATH"

        /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations~ipad" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:0 string UIInterfaceOrientationPortrait" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:1 string UIInterfaceOrientationPortraitUpsideDown" "$PLIST_PATH"

        print_info "iOS: Portrait orientation only"
        ;;
      landscape)
        # Landscape only
        /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:0 string UIInterfaceOrientationLandscapeLeft" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:1 string UIInterfaceOrientationLandscapeRight" "$PLIST_PATH"

        /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations~ipad" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:0 string UIInterfaceOrientationLandscapeLeft" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:1 string UIInterfaceOrientationLandscapeRight" "$PLIST_PATH"

        print_info "iOS: Landscape orientation only"
        ;;
      both)
        # All orientations
        /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:0 string UIInterfaceOrientationPortrait" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:1 string UIInterfaceOrientationLandscapeLeft" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:2 string UIInterfaceOrientationLandscapeRight" "$PLIST_PATH"

        /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations~ipad" "$PLIST_PATH" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad array" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:0 string UIInterfaceOrientationPortrait" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:1 string UIInterfaceOrientationPortraitUpsideDown" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:2 string UIInterfaceOrientationLandscapeLeft" "$PLIST_PATH"
        /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations~ipad:3 string UIInterfaceOrientationLandscapeRight" "$PLIST_PATH"

        print_info "iOS: All orientations supported"
        ;;
    esac

    print_success "iOS settings configured!"
  fi
}
```

---

## 📝 Step 4: Create Android Configuration Function

Add this function AFTER `configure_ios_settings()`:

```bash
# --- Configure Android Device and Orientation ---

configure_android_settings() {
  if [ "$SETUP_ANDROID" = "true" ]; then
    print_step "Configuring Android device type and orientation..."

    local MANIFEST_PATH="$PROJECT_PATH/android/app/src/main/AndroidManifest.xml"

    # Configure Device Type (supports-screens)
    case $DEVICE_TYPE in
      mobile)
        # Phone only
        sed -i.bak '/<supports-screens/,/<\/supports-screens>/d' "$MANIFEST_PATH"
        sed -i.bak '/<manifest/a\
    <supports-screens\
        android:smallScreens="true"\
        android:normalScreens="true"\
        android:largeScreens="false"\
        android:xlargeScreens="false"\
        android:requiresSmallestWidthDp="320" />
' "$MANIFEST_PATH"
        print_info "Android: Phone/Mobile only"
        ;;
      tablet)
        # Tablet only
        sed -i.bak '/<supports-screens/,/<\/supports-screens>/d' "$MANIFEST_PATH"
        sed -i.bak '/<manifest/a\
    <supports-screens\
        android:smallScreens="false"\
        android:normalScreens="false"\
        android:largeScreens="true"\
        android:xlargeScreens="true"\
        android:requiresSmallestWidthDp="600" />
' "$MANIFEST_PATH"
        print_info "Android: Tablet only"
        ;;
      universal)
        # Both
        sed -i.bak '/<supports-screens/,/<\/supports-screens>/d' "$MANIFEST_PATH"
        sed -i.bak '/<manifest/a\
    <supports-screens\
        android:smallScreens="true"\
        android:normalScreens="true"\
        android:largeScreens="true"\
        android:xlargeScreens="true" />
' "$MANIFEST_PATH"
        print_info "Android: Universal (Phone + Tablet)"
        ;;
    esac

    # Configure Orientation (screenOrientation attribute)
    case $ORIENTATION in
      portrait)
        sed -i.bak 's/<activity\([^>]*\)android:name=".MainActivity"/<activity\1android:name=".MainActivity" android:screenOrientation="portrait"/' "$MANIFEST_PATH"
        print_info "Android: Portrait orientation only"
        ;;
      landscape)
        sed -i.bak 's/<activity\([^>]*\)android:name=".MainActivity"/<activity\1android:name=".MainActivity" android:screenOrientation="landscape"/' "$MANIFEST_PATH"
        print_info "Android: Landscape orientation only"
        ;;
      both)
        sed -i.bak 's/<activity\([^>]*\)android:name=".MainActivity"/<activity\1android:name=".MainActivity" android:screenOrientation="sensor"/' "$MANIFEST_PATH"
        print_info "Android: All orientations supported"
        ;;
    esac

    # Clean up backup files
    rm -f "$MANIFEST_PATH.bak"

    print_success "Android settings configured!"
  fi
}
```

---

## 📝 Step 5: Update Main Execution Flow

In the `main()` function, add the configuration calls AFTER `install_android_dependencies`:

```bash
create_react_native_project
install_ios_dependencies
install_android_dependencies
configure_ios_settings        # NEW
configure_android_settings    # NEW
create_github_repo
push_to_github
run_initial_test
print_final_message
```

---

## 📝 Step 6: Update Step Numbers

Since we're adding more steps, update all step numbers:

- `[1/9]` Navigating to development directory
- `[2/9]` Creating React Native project
- `[3/9]` Installing iOS dependencies
- `[4/9]` Pre-downloading Android dependencies
- `[5/9]` Configuring iOS settings (NEW)
- `[6/9]` Configuring Android settings (NEW)
- `[7/9]` Creating GitHub repository
- `[8/9]` Syncing with GitHub
- `[9/9]` Launching app (or skipping test)

---

## 🎯 Expected User Experience

```bash
$ create-rn-app "My Universal App"

🚀 React Native Project Creation MCP 🚀

1. GitHub Repository Visibility
   1) Public
   2) Private
   Select: 2

2. Platform Setup
   1) iOS only
   2) Android only
   3) Both iOS and Android
   Select: 3

3. Device Type
   1) Mobile/Phone only
   2) Tablet only
   3) Universal (Mobile + Tablet)
   Select: 3

4. Screen Orientation
   1) Portrait only
   2) Landscape only
   3) Both orientations
   Select: 1

5. Initial Test Run
   ...

Configuration Summary:
  - Project Name:    MyUniversalApp
  - Visibility:      private
  - Setup iOS:       true
  - Setup Android:   true
  - Device Type:     universal
  - Orientation:     portrait
  ...

[5/9] Configuring iOS settings...
ℹ️  iOS: Universal (iPhone + iPad)
ℹ️  iOS: Portrait orientation only
✅ iOS settings configured!

[6/9] Configuring Android settings...
ℹ️  Android: Universal (Phone + Tablet)
ℹ️  Android: Portrait orientation only
✅ Android settings configured!
```

---

## ✅ Testing

After implementation, test with:

```bash
create-rn-app "Test Device Config"
```

Then verify:

**iOS:**
```bash
/usr/libexec/PlistBuddy -c "Print :UIDeviceFamily" ios/TestDeviceConfig/Info.plist
/usr/libexec/PlistBuddy -c "Print :UISupportedInterfaceOrientations" ios/TestDeviceConfig/Info.plist
```

**Android:**
```bash
grep -A 5 "supports-screens" android/app/src/main/AndroidManifest.xml
grep "screenOrientation" android/app/src/main/AndroidManifest.xml
```

---

## 🚨 Important Notes

1. **macOS PlistBuddy:** `/usr/libexec/PlistBuddy` is built into macOS
2. **sed on macOS:** Uses `-i.bak` syntax (different from Linux)
3. **Backup files:** The script creates `.bak` files and cleans them up
4. **Error handling:** Uses `2>/dev/null || true` to avoid errors if keys don't exist

---

## 🎉 Result

After this implementation, your tool will:
- ✅ Ask for device type and orientation preferences
- ✅ Automatically configure iOS Info.plist
- ✅ Automatically configure Android AndroidManifest.xml
- ✅ Create a project ready for the specific device/orientation combo
- ✅ No manual configuration needed!
