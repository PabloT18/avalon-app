import 'exceptions.dart';

class LogInWithmicrosoftException extends ServerException {
  const LogInWithmicrosoftException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithmicrosoftException.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithmicrosoftException(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithmicrosoftException(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithmicrosoftException(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithmicrosoftException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithmicrosoftException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithmicrosoftException(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithmicrosoftException(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithmicrosoftException(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithmicrosoftException();
    }
  }

  /// The associated error message.
  @override
  // ignore: overridden_fields
  final String message;
}
