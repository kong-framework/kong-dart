class KongValidator{

  // Validate username
  static String? username(String? username){
    if (username!.isEmpty) {
      return 'Please enter your username.';
    }
    return null; // Return null if the username is valid
  }

  // Validate password
  static String? password(String? password){
    if (password!.isEmpty) {
      return 'Please enter your password.';
    }
    return null;
  }

  // Validate email
  static String? email(String? emailAddress) {
    if (emailAddress!.isEmpty) {
      return 'Please enter your email.';
    }
    return null;
  }

  // Validate company name
  static String? companyName(String? companyName){
    if (companyName!.isEmpty) {
      return 'Please enter company name.';
    }
    return null;
  }

  // Validate phone number
  static String? phone(String? phoneNumber){
    if (phoneNumber!.isEmpty) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  // Validate address
  static String? address(String? address){
    if (address!.isEmpty) {
      return 'Please enter a valid address.';
    }
    return null;
  }

}
