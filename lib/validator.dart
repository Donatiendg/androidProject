class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Le nom d\'utilisateur ne peut pas être vide';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'L\'email ne peut pas être vide';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Format de mail incorrect';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Le mot de passe ne peut pas être vide';
    } else if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    return null;
  }

  static String? validateConfirmPassword({required String? password, required String? confirmPassword}) {
    if (password == null || confirmPassword == null) {
      return null;
    }
    if (confirmPassword != password){
      return "Les mots de passe de sont pas identiques";
    }
    return null;
  }
}