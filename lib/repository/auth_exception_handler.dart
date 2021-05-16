enum AuthResultStatus {
  successful,
  noInternetAccess,
  emailNotVerified,
  weakPassword,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}



class AuthExceptionHandler {
  //static String connectionError = "[ Unable to resolve host \"www.googleapis.com\":No address associated with hostname ]";
  static handleException(e) {
    var status;
    if(e.message.contains(RegExp(r'Unable to resolve host \"www.googleapis.com\":No address associated with hostname', caseSensitive: false))) {
      print("true!");
      return AuthResultStatus.noInternetAccess;
    }
    switch (e.code) {
      case "weak-password":
        status = AuthResultStatus.weakPassword;
        break;
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    print("Handled status: $status");
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.noInternetAccess:
        errorMessage = "Oops! Your internet connection must be down.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
        "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.emailNotVerified:
        errorMessage = "This email is not verified yet! Check your email.";
        break;
      default:
        errorMessage = "An undefined error happened.";
    }

    return errorMessage;
  }
}