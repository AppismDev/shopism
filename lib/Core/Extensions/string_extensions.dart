extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String get capitalize =>
      isNotEmpty
          ? this[0].toUpperCase() + substring(1)
          : this;


  bool isLessThanThreeCharacters() {
    if (this.length < 3) {
      return true;
    } else {
      return false;
    }
  }
  bool isValidIdentityNumber(){
    if (this.length == 11) {
      return true;
    } else {
      return false;
    }
  }
  // Regex eklenebilir
  bool isValidPhoneNumber(){
    if (this.length == 11) {
      return true;
    } else {
      return false;
    }
  }

}
