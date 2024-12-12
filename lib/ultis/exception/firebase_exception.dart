class TFirebaseException implements Exception {
  TFirebaseException(this.code);
  final String code;

  String get message {
    switch (code) {
      case 'unknown':
        return 'Lỗi không xác định. Vui lòng thử lại.';
      case 'network-request-failed':
        return 'Lỗi mạng. Vui lòng kiểm tra kết nối internet và thử lại.';
      case 'user-not-found':
        return 'No user found with the provided credentials.';
      case 'wrong-password':
        return 'Mật khẩu không đúng. Vui lòng thử lại.';
      case 'email-already-in-use':
        return 'Email đã được sử dụng bởi tài khoản khác.';
      case 'invalid-email':
        return 'The email address is invalid. Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'Thao tác không được phép. Vui lòng liên hệ hỗ trợ.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng sử dụng mật khẩu mạnh hơn.';
      case 'too-many-requests':
        return 'Quá nhiều lần thử. Vui lòng thử lại sau.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different credential.';
      case 'user-disabled':
        return 'Tài khoản người dùng đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ.';
      case 'invalid-verification-code':
        return 'Mã xác minh không đúng. Vui lòng thử lại.';
      case 'invalid-verification-id':
        return 'Mã xác minh không đúng. Vui lòng thử lại.';
      default:
        return 'Lỗi không xác định. Vui lòng thử lại.';
    }
  }
}
