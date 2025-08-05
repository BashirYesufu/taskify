import '../helper.dart';

extension StringExt on String {

  String capFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase().replaceAll('_', ' ');
  }

  String getFirstLetters() {
    if (isEmpty){
      return '';
    }
    List<String> words = split(' ');

    // Initialize an empty string to store the result
    String result = '';

    // Iterate through each word
    for (int i = 0; i < 1; i++) {
      // If the word is not empty, add its first letter to the result
      if (words[i].isNotEmpty) {
        result += words[i][0];

        // If there is a next word, add its first letter to the result
        if (i + 1 < words.length && words[i + 1].isNotEmpty) {
          result += words[i + 1][0];
        }
      }
    }
    return result;
  }

  String encrypt(){
    return Helper.encryptText(this);
  }


  String decrypt(){
    return Helper.decryptText(this);
  }

}