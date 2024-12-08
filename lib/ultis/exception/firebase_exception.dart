class TFirebaseException implements Exception {
  TFirebaseException(this.code);
  final String code;

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'user-not-found':
        return 'No user found with the provided credentials.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'email-already-in-use':
        return 'This email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is invalid. Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different credential.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please try again.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
