import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SharedPreferenceHelper {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserId = 'userId';
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyLoginTimestamp = 'loginTimestamp';

  static Future<bool> saveUserSession({
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyUserId, userId);
      await prefs.setString(_keyUserName, userName);
      await prefs.setString(_keyUserEmail, userEmail);
      await prefs.setInt(
          _keyLoginTimestamp, DateTime.now().millisecondsSinceEpoch);

      return true;
    } catch (e) {
      print('Error saving user session: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getUserSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;

      if (!isLoggedIn) {
        return null;
      }

      return {
        'isLoggedIn': isLoggedIn,
        'userId': prefs.getString(_keyUserId) ?? '',
        'userName': prefs.getString(_keyUserName) ?? '',
        'userEmail': prefs.getString(_keyUserEmail) ?? '',
        'loginTimestamp': prefs.getInt(_keyLoginTimestamp) ?? 0,
      };
    } catch (e) {
      print('Error getting user session: $e');
      return null;
    }
  }

  static Future<bool> isUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsLoggedIn) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  static Future<String> getUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyUserName) ?? 'User';
    } catch (e) {
      print('Error getting username: $e');
      return 'User';
    }
  }

  static Future<String> getUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyUserEmail) ?? '';
    } catch (e) {
      print('Error getting user email: $e');
      return '';
    }
  }

  static Future<String> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyUserId) ?? '';
    } catch (e) {
      print('Error getting user ID: $e');
      return '';
    }
  }

  static Future<bool> updateUserName(String newName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUserName, newName);
      return true;
    } catch (e) {
      print('Error updating user name: $e');
      return false;
    }
  }

  static Future<bool> updateUserEmail(String newEmail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUserEmail, newEmail);
      return true;
    } catch (e) {
      print('Error updating user email: $e');
      return false;
    }
  }

  static Future<bool> saveCurrentUserName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUserName, name);
      return true;
    } catch (e) {
      print('Error saving current user name: $e');
      return false;
    }
  }

  static Future<int> getLoginTimestamp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_keyLoginTimestamp) ?? 0;
    } catch (e) {
      print('Error getting login timestamp: $e');
      return 0;
    }
  }

  static Future<String> getLoginTimeFormatted() async {
    try {
      final timestamp = await getLoginTimestamp();
      if (timestamp == 0) {
        return 'Unknown';
      }

      final loginTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return '${loginTime.day}/${loginTime.month}/${loginTime.year} ${loginTime.hour}:${loginTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error getting formatted login time: $e');
      return 'Unknown';
    }
  }

  static Future<bool> clearUserSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove(_keyIsLoggedIn);
      await prefs.remove(_keyUserId);
      await prefs.remove(_keyUserName);
      await prefs.remove(_keyUserEmail);
      await prefs.remove(_keyLoginTimestamp);

      return true;
    } catch (e) {
      print('Error clearing user session: $e');
      return false;
    }
  }

  static Future<bool> saveSessionFromFirebaseUser(User user) async {
    return await saveUserSession(
      userId: user.uid,
      userName: user.displayName ?? user.email?.split('@')[0] ?? 'User',
      userEmail: user.email ?? '',
    );
  }
}
