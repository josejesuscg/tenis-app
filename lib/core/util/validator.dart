class Validator {
  bool isRequired(String value) {
    return (value.isEmpty);
  }
  
  bool isEmail(String? email) {
    if (email == null) return false;

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);
  }
}
