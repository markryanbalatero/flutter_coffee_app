# How to Get SHA-1 Fingerprint for Flutter App

## Your Current SHA-1 Fingerprint

**Debug SHA-1 Fingerprint:**
```
6D:69:8E:E0:AD:41:4E:99:4D:8F:C2:3D:E1:01:3D:D3:AC:21:61:CC
```

## Method 1: Using Gradle (Recommended)

### For Flutter Apps:
```bash
# Navigate to android directory
cd android

# Run signing report
./gradlew signingReport        # macOS/Linux
.\gradlew signingReport        # Windows
```

### Output Explanation:
- **MD5**: Legacy fingerprint (not commonly used)
- **SHA1**: Required for Google Sign-In, Google Maps, etc.
- **SHA-256**: Modern fingerprint for newer services

## Method 2: Using Keytool

### Debug Keystore (Development):

**Windows:**
```powershell
keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
```

**macOS/Linux:**
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### Release Keystore (Production):

**Windows:**
```powershell
keytool -list -v -keystore path\to\your\release-key.keystore -alias your-alias-name
```

**macOS/Linux:**
```bash
keytool -list -v -keystore path/to/your/release-key.keystore -alias your-alias-name
```

## Method 3: Using Android Studio

1. Open Android Studio
2. Open your Flutter project
3. Go to **Build** → **Generate Signed Bundle/APK**
4. Select **APK**
5. Choose **Create new** keystore (or use existing)
6. The SHA-1 will be displayed in the keystore information

## Method 4: Using Play Console (For Published Apps)

1. Go to Google Play Console
2. Select your app
3. Navigate to **Release** → **Setup** → **App Integrity**
4. Find the SHA-1 certificate fingerprint

## Adding SHA-1 to Firebase

### Step 1: Go to Firebase Console
1. Visit: https://console.firebase.google.com/
2. Select your project: `coffee-app-ef262`

### Step 2: Add SHA-1 Fingerprint
1. Click on **Project Settings** (gear icon)
2. Scroll down to **Your apps** section
3. Find your Android app
4. Click **Add fingerprint**
5. Paste your SHA-1: `6D:69:8E:E0:AD:41:4E:99:4D:8F:C2:3D:E1:01:3D:D3:AC:21:61:CC`
6. Click **Save**

### Step 3: Download Updated google-services.json
1. After adding the SHA-1, download the updated `google-services.json`
2. Replace the existing file at: `android/app/google-services.json`

## Important Notes

### Debug vs Release:
- **Debug SHA-1**: Used during development (what we got above)
- **Release SHA-1**: Used for production builds
- You need BOTH for a complete setup

### Multiple SHA-1s:
- You can add multiple SHA-1 fingerprints to the same Firebase project
- Add debug SHA-1 for development
- Add release SHA-1 for production
- Add SHA-1s for different developers' machines

### Security:
- SHA-1 fingerprints are NOT secret
- They're used for verification, not authentication
- Safe to share and commit to version control

## Next Steps for Google Sign-In

1. **Add your SHA-1 to Firebase** (using the fingerprint above)
2. **Download updated google-services.json**
3. **Replace the current google-services.json**
4. **Test Google Sign-In** in your app

## Troubleshooting

### Common Issues:

**"Sign-in failed" or "Developer Error":**
- Verify SHA-1 is correctly added to Firebase
- Check that google-services.json is updated
- Ensure package name matches

**"PlatformException":**
- Clean and rebuild the project
- Verify Google Sign-In is enabled in Firebase Console

**"Network Error":**
- Check internet connection
- Verify Firebase project configuration

### Commands to Fix Issues:
```bash
flutter clean
flutter pub get
cd android
.\gradlew clean
cd ..
flutter run
```

## Production Considerations

For production builds, you'll need to:
1. Create a release keystore
2. Get the release SHA-1 fingerprint
3. Add it to Firebase
4. Update google-services.json
5. Build with the release keystore

Your debug SHA-1 is ready to use for development and testing!
