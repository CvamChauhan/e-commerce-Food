class SignUpBody {
  final String name;
  final String email;
  final String mobile;
  final String password;
  SignUpBody(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.password});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data['f_name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.mobile;
    data["password"] = this.password;
    return data;
  }
}
