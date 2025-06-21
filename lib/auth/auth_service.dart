import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // تسجيل مستخدم جديد
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Sign up error: $e");
      return null;
    }
  }

  // تسجيل دخول
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Sign in error: $e");
      return null;
    }
  }

  // تسجيل خروج
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // إعادة تعيين كلمة المرور
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("تم إرسال رابط إعادة تعيين كلمة المرور إلى $email");
      return true;
    } catch (e) {
      print("Password reset error: $e");
      return false;
    }
  }
}
