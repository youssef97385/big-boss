mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;
  bool isANumber(String number) {
    return RegExp(r'(^[0-9]+$)').hasMatch(number);
  }

  bool isPostalCode(String number) {
    return RegExp(r'(^[0-9]{5}$)').hasMatch(number);
  }

  bool isIban(String ibanValue) {
    return ibanValue.length > 14;
  }

  bool isTinNumber(String value) {
    return value.length > 6;
  }

  bool isPercentage(String value) {
    int integerValue = int.parse(value);
    if (integerValue >= 1 && integerValue <= 100) {
      return true;
    } else {
      return false;
    }
  }

  bool isPhoneValid(String phone) {
    return RegExp(r'(^[0-9]{9,14}$)').hasMatch(phone);
  }

  bool isEmailValid(String email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isPinValid(String pin) {
    return RegExp(r'(^[0-9]{2,6}$)').hasMatch(pin);
  }

  bool isTextValid(String text) {
    return RegExp(r'(^[a-zA-Z\-0-9\s]{2,}$)').hasMatch(text);
  }
}
