class RegisterRequest {
  String firstName;
  String lastName;
  String email;
  String password;

  String? gender; // male, female, other
  DateTime? birthDate;
  List<String>? languages; // english
  String country;
  String city;

  RegisterRequest({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.gender = '',
    this.birthDate,
    this.languages = const [],
    this.country = '',
    this.city = '',
  });

  int get genderIndex {
    if (gender == null) return 0;
    if (gender == 'female') return 0;
    if (gender == 'male') return 1;
    if (gender == 'other') return 2;
    return 0;
  }
}
