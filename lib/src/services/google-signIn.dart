import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigin {
  static Future<UserCredential?> handleGoogleSignIn() async {
    // Trigger the authentication flow
    final GoogleSignIn signIn = GoogleSignIn.instance;

    await signIn.initialize();

    // Obtain the auth details from the request
    final GoogleSignInAccount googleAuth = await signIn.authenticate();

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.authentication.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
