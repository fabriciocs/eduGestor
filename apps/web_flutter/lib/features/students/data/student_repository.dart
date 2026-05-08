import '../../../../core/http/api_client.dart';
import 'student_model.dart';

class StudentRepository {
  StudentRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Student>> listStudents({String? search}) async {
    final result = await _apiClient.getJson(
      '/v1/students',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );

    final data = (result['data'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    return data.map(Student.fromJson).toList();
  }

  Future<void> createStudent({
    required String fullName,
    required String birthDate,
    String? documentNumber,
  }) async {
    await _apiClient.postJson('/v1/students', {
      'fullName': fullName,
      'birthDate': birthDate,
      if (documentNumber != null && documentNumber.isNotEmpty)
        'documentNumber': documentNumber,
    });
  }
}
