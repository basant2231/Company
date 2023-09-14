


extension StringValidation on String? {
  bool isEmailValid() {
    if (this == null) return false;
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this!);
  }

  bool isPasswordValid() {
    if (this == null) return false;
    return this!.length >= 6;
  }

  bool isUsernameValid() {
    if (this == null) return false;
    return this!.length >= 8;
  }

  bool isMobileNumberValid() {
    if (this == null) return false;
    final mobileRegExp = RegExp(
        r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)');
    return mobileRegExp.hasMatch(this!);
  }
}
