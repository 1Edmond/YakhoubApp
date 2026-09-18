class ContactUsBody{
  String name; String email; String phone; String subject; String message;
  ContactUsBody({required this.name, required this.email, required this.phone, required this.subject, required this.message});
  Map<String, dynamic> toJson() => {"name": name, "email": email, "mobile_number": phone, "subject": subject, "message": message};
}
