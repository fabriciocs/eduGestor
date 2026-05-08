class Student {
  const Student({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.status,
    this.documentNumber,
  });

  final String id;
  final String fullName;
  final String birthDate;
  final String status;
  final String? documentNumber;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'].toString(),
      fullName: json['full_name'].toString(),
      birthDate: json['birth_date'].toString(),
      status: json['status'].toString(),
      documentNumber: json['document_number']?.toString(),
    );
  }
}
