class TFirebaseAuthException implements Exception {
  TFirebaseAuthException(this.code);
  final String code;

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Email này đã được sử dụng. Vui lòng sử dụng email khác.';
      case 'invalid-email':
        return 'Email không hợp lệ. Vui lòng kiểm tra lại.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng sử dụng mật khẩu mạnh hơn.';
      case 'operation-not-allowed':
        return 'Hoạt động không được phép. Vui lòng liên hệ hỗ trợ.';
      case 'user-disabled':
        return 'Tài khoản đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ.';
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này.';
      case 'wrong-password':
        return 'Sai mật khẩu. Vui lòng thử lại.';
      case 'invalid-verification-code':
        return 'Mã xác thực không hợp lệ. Vui lòng thử lại.';
      case 'invalid-verification-id':
        return 'ID xác thực không hợp lệ. Vui lòng thử lại.';
      case 'quota-exceeded':
        return 'Đã vượt quá giới hạn. Vui lòng thử lại sau.';
      case 'email-already-exists':
        return 'Email này đã tồn tại trong hệ thống.';
      case 'provider-already-linked':
        return 'Tài khoản đã được liên kết với phương thức đăng nhập này.';
      case 'requires-recent-login':
        return 'Vui lòng đăng nhập lại để thực hiện thao tác này.';
      case 'credential-already-in-use':
        return 'Thông tin đăng nhập này đã được sử dụng bởi một tài khoản khác.';
      case 'user-mismatch':
        return 'Thông tin người dùng không khớp.';
      case 'invalid-credential':
        return 'Thông tin đăng nhập không hợp lệ.';
      case 'invalid-continue-uri':
        return 'URL tiếp tục không hợp lệ.';
      case 'invalid-dynamic-link-domain':
        return 'Domain của dynamic link không hợp lệ.';
      case 'invalid-phone-number':
        return 'Số điện thoại không hợp lệ.';
      case 'invalid-tenant-id':
        return 'ID tenant không hợp lệ.';
      case 'missing-android-pkg-name':
        return 'Thiếu tên package Android.';
      case 'missing-continue-uri':
        return 'Thiếu URL tiếp tục.';
      case 'missing-ios-bundle-id':
        return 'Thiếu ID bundle iOS.';
      case 'missing-verification-code':
        return 'Thiếu mã xác thực.';
      case 'missing-verification-id':
        return 'Thiếu ID xác thực.';
      case 'session-expired':
        return 'Phiên làm việc đã hết hạn. Vui lòng thử lại.';
      case 'too-many-requests':
        return 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
      case 'unauthorized-continue-uri':
        return 'URL tiếp tục không được ủy quyền.';
      case 'user-cancelled':
        return 'Người dùng đã hủy thao tác.';
      case 'user-token-expired':
        return 'Token người dùng đã hết hạn. Vui lòng đăng nhập lại.';
      case 'web-storage-unsupported':
        return 'Trình duyệt không hỗ trợ web storage.';
      default:
        return 'Đã xảy ra lỗi không xác định. Vui lòng thử lại.';
    }
  }
}
