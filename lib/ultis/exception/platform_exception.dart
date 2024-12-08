class TPlatformException implements Exception {
  TPlatformException(this.code);
  final String code;

  String get message {
    switch (code) {
      case 'sign_in_canceled':
        return 'Sign-in was canceled by the user.';
      case 'sign_in_required':
        return 'Sign-in is required to complete this operation.';
      case 'invalid-argument':
        return 'An invalid argument was provided. Please check your input.';
      case 'permission-denied':
        return 'Permission denied. You do not have access to this resource.';
      case 'timeout':
        return 'The request timed out. Please try again later.';
      case 'failed-precondition':
        return 'Operation failed due to an unmet precondition.';
      case 'not-found':
        return 'The requested resource was not found.';
      case 'unauthenticated':
        return 'Authentication required. Please sign in and try again.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'already-exists':
        return 'The resource already exists.';
      case 'data-loss':
        return 'Data loss detected. Please contact support.';
      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}
