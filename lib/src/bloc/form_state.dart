abstract class FormStatus {
  const FormStatus();
}

class FormInitial extends FormStatus {
  const FormInitial();
}

class FormSubmitting extends FormStatus {
  const FormSubmitting();
}

class FormSuccess extends FormStatus {
  const FormSuccess();
}

class FormFailure extends FormStatus {
  final String error;

  const FormFailure({required this.error});

  @override
  String toString() => 'FormFailure { error: $error }';
}