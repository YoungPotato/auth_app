import 'package:auth_app/constants/string_constants.dart';
import 'package:auth_app/domain/models/field_status.dart';

class ValidatorText {
  static getValidatorText(FieldStatus textStatus) =>
      textStatus == FieldStatus.invalid ? StringConstants.invalid : null;
}
