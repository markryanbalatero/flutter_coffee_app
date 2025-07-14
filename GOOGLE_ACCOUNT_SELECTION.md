# Google Sign-In Account Selection Implementation

## Overview
This implementation ensures that users always see the Google account selection dialog when signing in or registering with Google, rather than automatically using the last signed-in account.

## Changes Made

### 1. AuthService Updates (`lib/services/auth_service.dart`)

**GoogleSignIn Configuration:**
```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  // Force account selection every time
  forceCodeForRefreshToken: true,
);
```

**Key Changes:**
- Added `forceCodeForRefreshToken: true` to GoogleSignIn configuration
- Modified `signInWithGoogle()` to sign out first before signing in
- Created separate `registerWithGoogle()` method for registration
- Both methods call `_googleSignIn.signOut()` before `_googleSignIn.signIn()`

### 2. Updated Methods

**signInWithGoogle() - Login Flow:**
```dart
Future<bool> signInWithGoogle(BuildContext context) async {
  try {
    // Sign out from Google first to force account selection
    await _googleSignIn.signOut();
    
    // Trigger the authentication flow with account selection
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    
    // ... rest of the authentication logic
  }
}
```

**registerWithGoogle() - Registration Flow:**
```dart
Future<bool> registerWithGoogle(BuildContext context) async {
  try {
    // Sign out from Google first to force account selection
    await _googleSignIn.signOut();
    
    // Trigger the authentication flow with account selection
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    
    // ... rest of the authentication logic
  }
}
```

### 3. Register Screen Updates (`lib/screens/register_screen.dart`)

**Updated Google Sign-In Button:**
- Changed from `signInWithGoogle()` to `registerWithGoogle()`
- Updated error message to reflect registration context
- Maintains the same UI behavior

## How It Works

### Account Selection Process:
1. **User taps Google Sign-In button**
2. **System calls `_googleSignIn.signOut()`** - Clears any cached account
3. **System calls `_googleSignIn.signIn()`** - Shows account selection dialog
4. **User selects account** - From the list of available Google accounts
5. **Authentication proceeds** - With the selected account
6. **User is authenticated** - And navigated to dashboard

### Benefits:
- **User Control**: Users can choose which Google account to use
- **Security**: Prevents accidental sign-in with wrong account
- **Transparency**: Users always know which account they're using
- **Flexibility**: Users can switch between multiple Google accounts

## Configuration Options

### GoogleSignIn Parameters:
```dart
GoogleSignIn(
  forceCodeForRefreshToken: true,  // Forces account selection
  scopes: ['email', 'profile'],    // Optional: specific scopes
  hostedDomain: 'yourdomain.com',  // Optional: restrict to domain
)
```

### Additional Options:
- `scopes`: Define what permissions to request
- `hostedDomain`: Restrict to specific domain accounts
- `clientId`: Custom OAuth client ID (usually auto-detected)

## User Experience

### Login Flow:
1. User taps "Continue with Google" on login screen
2. Google account selection dialog appears
3. User selects desired account
4. User is signed in and redirected to dashboard

### Registration Flow:
1. User taps "Continue with Google" on registration screen
2. Google account selection dialog appears
3. User selects desired account
4. Account is created/linked in Firebase
5. User is redirected to dashboard

## Testing

### Test Scenarios:
1. **Multiple Google Accounts:**
   - Add multiple Google accounts to your device
   - Try signing in - should show account chooser
   - Select different accounts and verify they work

2. **Account Switching:**
   - Sign in with Account A
   - Sign out and sign in again
   - Should show account chooser, not auto-select Account A

3. **Registration vs Login:**
   - Test both registration and login flows
   - Both should show account selection dialog

## Security Considerations

### Benefits:
- **Prevents Account Confusion**: Users always know which account they're using
- **Reduces Accidental Access**: No automatic sign-in with wrong account
- **Audit Trail**: Clear record of which account was selected

### Privacy:
- **No Persistent Selection**: Account choice is not remembered
- **User Control**: Users decide which account to use each time
- **Transparent Process**: Users see what's happening

## Troubleshooting

### Common Issues:

**Account Selection Not Appearing:**
- Verify `forceCodeForRefreshToken: true` is set
- Check that `signOut()` is called before `signIn()`
- Clear app data and test again

**Authentication Errors:**
- Ensure SHA-1 fingerprint is configured in Firebase
- Verify Google Sign-In is enabled in Firebase Console
- Check that google-services.json is updated

**Performance Considerations:**
- The `signOut()` call adds a small delay but ensures account selection
- Network call is required for account selection dialog
- Consider showing loading indicator during the process

## Future Enhancements

### Potential Improvements:
1. **Remember Last Used Account**: Show it as default but allow changing
2. **Account Filtering**: Filter accounts based on domain or criteria
3. **Custom Account Picker**: Create custom UI for account selection
4. **Biometric Confirmation**: Add biometric confirmation for account selection

### Advanced Configuration:
```dart
GoogleSignIn(
  forceCodeForRefreshToken: true,
  scopes: ['email', 'profile'],
  // Add custom configuration as needed
)
```

## Summary

The implementation ensures that users always see the Google account selection dialog when using Google Sign-In, providing better user control and security. The key is calling `signOut()` before `signIn()` to clear any cached account information and force the account selection dialog to appear.

This approach works for both login and registration flows, ensuring a consistent user experience throughout the application.
