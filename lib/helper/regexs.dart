class RegExs {
  static final email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}");
  static final card = RegExp(r"^(\d{4}( \d{4})+( \d{4})+( \d{4})+)$");
  static final cardExpirationDate = RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{2})$");
  static final cvv = RegExp(r"^(\d{3})$");
  static final onlyDigits = RegExp(r"\d");
}


