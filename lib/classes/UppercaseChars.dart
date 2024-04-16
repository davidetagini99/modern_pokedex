// ignore_for_file: file_names

class UppercaseChars {
  String capitalize(String s) {
    if(s.isEmpty) {
      return s;
    }
    else {
      return s[0].toUpperCase() + s.substring(1);
    }
  }
}