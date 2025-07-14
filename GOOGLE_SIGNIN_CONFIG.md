# Google Sign-In Configuration Guide

## Important Setup Steps

### 1. Firebase Console Configuration

To make Google Sign-In work, you need to configure it in your Firebase Console:

1. **Go to Firebase Console**: https://console.firebase.google.com/
2. **Select your project**: `coffee-app-ef262`
3. **Navigate to Authentication**: 
   - Click on "Authentication" in the left sidebar
   - Go to "Sign-in method" tab
4. **Enable Google Sign-In**:
   - Find "Google" in the list of providers
   - Click on it and toggle "Enable"
   - Add a support email address (required)
   - Save the configuration

### 2. Android SHA-1 Fingerprint Setup

For Android to work with Google Sign-In, you need to add the SHA-1 fingerprint:

1. **Get Debug SHA-1 Fingerprint**:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
   
   Or on Windows:
   ```bash
   keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

2. **Add to Firebase Project**:
   - In Firebase Console, go to Project Settings (gear icon)
   - Scroll down to "Your apps" section
   - Click on your Android app
   - Add the SHA-1 fingerprint
   - Download the updated `google-services.json`

3. **Replace google-services.json**:
   - Replace the file in `android/app/google-services.json`
   - The file should contain OAuth client configuration

### 3. Test the Implementation

After configuration, test the Google Sign-In:

1. **Run the app**: `flutter run`
2. **Navigate to login screen**
3. **Tap "Continue with Google"**
4. **Select a Google account**
5. **Verify navigation to dashboard**

### 4. Expected google-services.json Structure

Your `google-services.json` should include OAuth client configuration like this:

```json
{
  "project_info": {
    "project_number": "440992636865",
    "project_id": "coffee-app-ef262"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:440992636865:android:d806a295b2135d18de1940",
        "android_client_info": {
          "package_name": "com.example.flutter_coffee_app"
        }
      },
      "oauth_client": [
        {
          "client_id": "YOUR_CLIENT_ID.apps.googleusercontent.com",
          "client_type": 1,
          "android_info": {
            "package_name": "com.example.flutter_coffee_app",
            "certificate_hash": "YOUR_SHA1_HASH"
          }
        }
      ]
    }
  ]
}
```

### 5. Common Issues and Solutions

**Issue**: Google Sign-In button doesn't work
**Solution**: 
- Check if OAuth client is configured in `google-services.json`
- Verify SHA-1 fingerprint is added to Firebase project
- Ensure Google Sign-In is enabled in Firebase Console

**Issue**: "Developer Error" or "Sign-in failed"
**Solution**:
- Verify the package name matches in Firebase and Android configuration
- Check if the SHA-1 fingerprint is correct
- Ensure the google-services.json is in the correct location

**Issue**: Build errors
**Solution**:
- Run `flutter clean` and `flutter pub get`
- Verify all dependencies are properly installed
- Check Android configuration

## Current Implementation Status

✅ **Completed:**
- Google Sign-In dependency added
- AuthService updated with Google Sign-In method
- Custom Google Sign-In button created
- LoginCubit updated with Google Sign-In state management
- UI updated with Google Sign-In buttons
- Error handling implemented
- Navigation flow configured

🔄 **Requires Configuration:**
- Firebase Console Google Sign-In provider setup
- SHA-1 fingerprint configuration
- Updated google-services.json with OAuth client

## Next Steps

1. **Configure Firebase Console** (as described above)
2. **Add SHA-1 fingerprint** to Firebase project
3. **Update google-services.json** with OAuth configuration
4. **Test the Google Sign-In flow**
5. **Deploy to production** with release SHA-1 fingerprint

The implementation is complete and ready for testing once the Firebase configuration is done!
