class TPlatformException implements Exception {
  TPlatformException(this.code);
  final String code;

  String get message {
    switch (code) {
      case 'sign_in_canceled':
        return 'Đăng nhập bị hủy bỏ bởi người dùng.';
      case 'sign_in_required':
        return 'Đăng nhập là bắt buộc để hoàn thành thao tác này.';
      case 'invalid-argument':
        return 'An invalid argument was provided. Please check your input.';
      case 'permission-denied':
        return 'Không có quyền truy cập. Bạn không có quyền truy cập vào tài nguyên này.';
      case 'timeout':
        return 'Yêu cầu không được thực hiện. Vui lòng thử lại sau.';
      case 'failed-precondition':
        return 'Operation failed due to an unmet precondition.';
      case 'not-found':
        return 'Tài nguyên được yêu cầu không được tìm thấy.';
      case 'unauthenticated':
        return 'Cần đăng nhập. Vui lòng đăng nhập và thử lại.';
      case 'unavailable':
        return 'Dịch vụ hiện không khả dụng. Vui lòng thử lại sau.';
      case 'already-exists':
        return 'The resource already exists.';
      case 'data-loss':
        return 'Mất dữ liệu. Vui lòng liên hệ hỗ trợ.';
      default:
        return 'Lỗi không xác định. Vui lòng thử lại.';
    }
  }
}
