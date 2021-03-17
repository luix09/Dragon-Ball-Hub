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

class UserManagerDialogFeedback {
  static DialogFeedback generateDialogMessage(exceptionCode) {
    DialogFeedback feedback;

    switch (exceptionCode) {
      case UserManagerStatus.UserAdded:
        feedback = DialogFeedback(
            title: "Account created",
            message:
                "Go and check out your email.\nClick the link and verify your account!");
        break;
      default:
        feedback = DialogFeedback(
            title: "Unknown error",
            message:
            "An unknown error occurred. Try to restart the app.");
    }

    return feedback;
  }
}
