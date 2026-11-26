import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService.internal();

  static final AuthService _instance = AuthService.internal();

  factory AuthService() {
    return _instance;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Mencetak error persisnya ke tab Logcat/Run Android Studio
      print('=== ERROR SIGN UP ===');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      return null;
    } catch (e) {
      print('=== ERROR SIGN UP LAINNYA ===');
      print(e.toString());
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Mencetak error persisnya ke tab Logcat/Run Android Studio
      print('=== ERROR SIGN IN ===');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      return null;
    } catch (e) {
      print('=== ERROR SIGN IN LAINNYA ===');
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}