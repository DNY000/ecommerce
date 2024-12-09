class TValidation {
  static String? validatePassword(String password) {
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?":{}|<>])(?=.{8,})',
    );

    if (password.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (!passwordRegExp.hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất: 8 ký tự, 1 chữ in hoa, 1 số, 1 ký tự đặc biệt';
    }

    return null;
  }

  static String? emailValidator(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      return 'Email không được để trống';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Vui lòng nhập đúng định dạng email';
    }
    return null;
  }

  static String? phoneValidator(String phone) {
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    if (phone.isEmpty) {
      return 'Số điện thoại không được để trống';
    } else if (!phoneRegExp.hasMatch(phone)) {
      return 'Vui lòng nhập đúng định dạng số điện thoại';
    }
    return null;
  }

  static String? nameValidator(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  static String? validatePasswordWithLogin(String? password) {
    if (password == null || password.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    return null;
  }
}
