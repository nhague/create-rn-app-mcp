# Device Type & Orientation Configuration Guide

This guide covers the changes applied to **React Native projects** when you answer the device type and orientation questions. React web scaffolds do not modify native files, so you can skip this document for those runs.

---

## 📱 Device Type Configuration

### iOS Configuration (Info.plist)

**Location:** `ios/YourApp/Info.plist`

```xml
<key>UIDeviceFamily</key>
<array>
    <integer>1</integer> <!-- iPhone/iPod Touch -->
    <integer>2</integer> <!-- iPad -->
</array>
```

**Options:**
- **Mobile/Phone only:** `<integer>1</integer>` (iPhone)
- **Tablet only:** `<integer>2</integer>` (iPad)
- **Both:** Both integers included (Universal app)

---

### Android Configuration (AndroidManifest.xml)

**Location:** `android/app/src/main/AndroidManifest.xml`

```xml
<supports-screens
    android:smallScreens="true"
    android:normalScreens="true"
    android:largeScreens="true"
    android:xlargeScreens="true"
    android:requiresSmallestWidthDp="320" />
```

**Options:**
- **Mobile/Phone only:**
  ```xml
  android:smallScreens="true"
  android:normalScreens="true"
  android:largeScreens="false"
  android:xlargeScreens="false"
  android:requiresSmallestWidthDp="320"
  ```

- **Tablet only:**
  ```xml
  android:smallScreens="false"
  android:normalScreens="false"
  android:largeScreens="true"
  android:xlargeScreens="true"
  android:requiresSmallestWidthDp="600"
  ```

- **Both (Universal):**
  ```xml
  android:smallScreens="true"
  android:normalScreens="true"
  android:largeScreens="true"
  android:xlargeScreens="true"
  ```

---

## 🔄 Orientation Configuration

### iOS Configuration (Info.plist)

**Location:** `ios/YourApp/Info.plist`

**Portrait Only:**
```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
</array>
```

**Landscape Only:**
```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

**Both Orientations:**
```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

---

### Android Configuration (AndroidManifest.xml)

**Location:** `android/app/src/main/AndroidManifest.xml`

Add `android:screenOrientation` to the MainActivity:

**Portrait Only:**
```xml
<activity
    android:name=".MainActivity"
    android:screenOrientation="portrait"
    ...>
```

**Landscape Only:**
```xml
<activity
    android:name=".MainActivity"
    android:screenOrientation="landscape"
    ...>
```

**Both Orientations (Sensor-based):**
```xml
<activity
    android:name=".MainActivity"
    android:screenOrientation="sensor"
    ...>
```

Or remove the attribute entirely to allow all orientations.

---

## 🎯 How the Script Applies These

The `create-rn-app` script modifies these files automatically based on your selections:

1. **After project creation:** Script navigates to the project directory
2. **iOS Configuration:** Uses `/usr/libexec/PlistBuddy` to modify Info.plist
3. **Android Configuration:** Uses `sed` to modify AndroidManifest.xml
4. **Verification:** Script can optionally verify the changes were applied

---

## 📖 References

- [iOS Device Families](https://developer.apple.com/documentation/bundleresources/information_property_list/uidevicefamily)
- [iOS Supported Interface Orientations](https://developer.apple.com/documentation/bundleresources/information_property_list/uisupportedinterfaceorientations)
- [Android Screen Support](https://developer.android.com/guide/topics/manifest/supports-screens-element)
- [Android Screen Orientation](https://developer.android.com/guide/topics/manifest/activity-element#screen)

---

## 💡 Best Practices

**Universal Apps (Mobile + Tablet):**
- Most common choice
- Maximum market reach
- Requires responsive design

**Phone-Only Apps:**
- Simpler UI/UX design
- Smaller app size (iOS)
- Good for apps that don't benefit from larger screens

**Tablet-Only Apps:**
- Content-heavy apps (magazines, drawing, etc.)
- Productivity apps
- Educational apps

**Orientation:**
- **Portrait only:** Social media, messaging, content consumption
- **Landscape only:** Games, video apps, presentation apps
- **Both:** Most flexible, requires careful UI design

---

## 🌐 Note on React Web Projects

When you select a React web scaffold, device constraints are handled inside the generated CSS/HTML instead of native manifests. Tablet mockups receive a fixed viewport (768×1024 portrait or 1024×768 landscape) and include the Android frame, guided drawers, and global controls. Phone mockups constrain the layout to 390×844.
