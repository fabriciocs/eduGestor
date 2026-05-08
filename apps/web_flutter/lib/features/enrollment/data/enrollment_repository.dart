import '../../../../core/http/api_client.dart';

class EnrollmentRepository {
  EnrollmentRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Map<String, dynamic>>> listProcesses({String? search}) async {
    final response = await _apiClient.getJson(
      '/v1/enrollments/processes',
      query: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );

    return (response['data'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> createProcess({
    required String studentName,
    required String birthDate,
    String? studentCpf,
    String? guardianName,
    String? guardianCpf,
    String? guardianEmail,
    String? guardianPhone,
    required String schoolYearId,
    String? classId,
    String? enrollmentNumber,
    required String enrollmentDate,
    bool generateContract = true,
    bool generateInitialCharge = false,
    int? amountInCents,
    String? dueDate,
  }) async {
    final response = await _apiClient.postJson('/v1/enrollments/processes', {
      'student': {
        'fullName': studentName,
        'birthDate': birthDate,
        if (studentCpf != null && studentCpf.isNotEmpty) 'cpf': studentCpf,
      },
      if (guardianName != null && guardianName.trim().isNotEmpty)
        'guardian': {
          'fullName': guardianName,
          if (guardianCpf != null && guardianCpf.isNotEmpty) 'cpf': guardianCpf,
          if (guardianEmail != null && guardianEmail.isNotEmpty) 'email': guardianEmail,
          if (guardianPhone != null && guardianPhone.isNotEmpty) 'phone': guardianPhone,
        },
      'enrollment': {
        'schoolYearId': schoolYearId,
        if (classId != null && classId.isNotEmpty) 'classId': classId,
        if (enrollmentNumber != null && enrollmentNumber.isNotEmpty)
          'enrollmentNumber': enrollmentNumber,
        'enrollmentDate': enrollmentDate,
        'situation': 'PRE_MATRICULA',
      },
      'contract': {
        'generate': generateContract,
        'title': 'Contrato educacional',
      },
      'billing': {
        'generateInitialCharge': generateInitialCharge,
        if (amountInCents != null) 'amountInCents': amountInCents,
        if (dueDate != null && dueDate.isNotEmpty) 'dueDate': dueDate,
      },
    });

    return response['data'] as Map<String, dynamic>;
  }

  Future<void> transitionProcess({
    required String id,
    required String nextSituation,
    String? reason,
  }) async {
    await _apiClient.postJson('/v1/enrollments/processes/$id/transitions', {
      'nextSituation': nextSituation,
      if (reason != null && reason.trim().isNotEmpty) 'reason': reason.trim(),
    });
  }
}
