class TFormatter {
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return phoneNumber.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d{4})'),
          (Match m) => '${m[1]}-${m[2]}-${m[3]}');
      // Nếu là 10 số thì tách thành 3 3 4
    } else if (phoneNumber.length == 11) {
      return phoneNumber.replaceAllMapped(RegExp(r'(\d{3})(\d{4})(\d{4})'),
          (Match m) => '${m[1]}-${m[2]}-${m[3]}');
      // Nếu 11 số tách thành 4 4 3
    }
    return phoneNumber;
  }

  static String formatUserName(String userName) {
    return userName.replaceAll(' ', '').toLowerCase();
  }

  static String formatFullName(String firstName, String lastName) {
    return '$firstName $lastName';
  }
  // static String formatDate(DateTime date) {
  //   return DateFormat('yyyy-MM-dd').format(date).toString();
  // }
}
