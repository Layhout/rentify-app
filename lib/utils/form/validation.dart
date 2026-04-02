String? validateEmail(String? value) {
  const pattern =
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value) ? 'Enter a valid email address' : null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'At least 8 characters required';
  if (value.length > 64) return 'Password too long (max 64 characters)';
  if (!value.contains(RegExp(r'[A-Z]'))) return 'Add at least one uppercase letter (A-Z)';
  if (!value.contains(RegExp(r'[a-z]'))) return 'Add at least one lowercase letter (a-z)';
  if (!value.contains(RegExp(r'[0-9]'))) return 'Add at least one number (0-9)';
  if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) return 'Add at least one special character (!@#\$...)';
  if (value.contains(RegExp(r'\s'))) return 'Password must not contain spaces';
  if (RegExp(r'(.)\1{2,}').hasMatch(value)) return 'Avoid repeating characters (e.g. aaa, 111)';
  // if (RegExp(r'(012|123|234|345|456|567|678|789|890|abc|bcd|cde|def)', caseSensitive: false).hasMatch(value)) {
  //   return 'Avoid sequential characters (e.g. 123, abc)';
  // }

  return null;
}
