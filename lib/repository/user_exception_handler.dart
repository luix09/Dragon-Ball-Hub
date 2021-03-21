enum UserManagerStatus {
  UserAdded,
  UserDeleted,
  undefined,
}

class DialogFeedback {
  final String title;
  final String message;

  DialogFeedback({required this.title, required this.message});
}

class UserManagerFeedback {
  static handleException(e) {
    var status;
    switch (e.code) {
      default:
        status = UserManagerStatus.undefined;
    }
    print("Handled status: $status");
    return status;
  }

  static generateStateMessage(exceptionCode) {
    String stateMessage;
    switch (exceptionCode) {
      case UserManagerStatus.UserAdded:
        stateMessage =
            "Go and check out your email.\nClick the link and verify your account!";
        break;
      case UserManagerStatus.undefined:
        stateMessage = "An unknown error occurred. Try to restart the app.";
        break;
      default:
        stateMessage = "I don't know what's going on.";
    }

    return stateMessage;
  }

  static DialogFeedback generateDialogMessage(exceptionCode) {
    DialogFeedback feedback;

    switch (exceptionCode) {
      case UserManagerStatus.UserAdded:
        feedback = DialogFeedback(
            title: "Account created",
            message: UserManagerFeedback.generateStateMessage(exceptionCode));
        break;
      default:
        feedback = DialogFeedback(
            title: "Unknown error",
            message: UserManagerFeedback.generateStateMessage(exceptionCode));
    }
    return feedback;
  }
}
