import '../../../../core/http/api_client.dart';

class FinanceRepository {
  FinanceRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> dashboard() async {
    return _apiClient.getJson('/v1/finance/dashboard');
  }

  Future<List<Map<String, dynamic>>> listCharges({
    String? search,
    String? situation,
  }) async {
    final response = await _apiClient.getJson(
      '/v1/finance/charges',
      query: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (situation != null && situation.isNotEmpty) 'situation': situation,
      },
    );

    return (response['data'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
  }

  Future<void> createCharge({
    String? enrollmentId,
    String? studentId,
    String? guardianId,
    required String description,
    required int amountInCents,
    required String dueDate,
    String? competency,
  }) async {
    await _apiClient.postJson('/v1/finance/charges', {
      if (enrollmentId != null && enrollmentId.isNotEmpty) 'enrollmentId': enrollmentId,
      if (studentId != null && studentId.isNotEmpty) 'studentId': studentId,
      if (guardianId != null && guardianId.isNotEmpty) 'guardianId': guardianId,
      'description': description,
      'amountInCents': amountInCents,
      'dueDate': dueDate,
      if (competency != null && competency.isNotEmpty) 'competency': competency,
    });
  }

  Future<void> createBillingPlan({
    required String enrollmentId,
    String? studentId,
    String? guardianId,
    required String description,
    required int installments,
    required String firstDueDate,
    required int amountInCents,
    String? competencyPrefix,
  }) async {
    await _apiClient.postJson('/v1/finance/billing-plans', {
      'enrollmentId': enrollmentId,
      if (studentId != null && studentId.isNotEmpty) 'studentId': studentId,
      if (guardianId != null && guardianId.isNotEmpty) 'guardianId': guardianId,
      'description': description,
      'installments': installments,
      'firstDueDate': firstDueDate,
      'amountInCents': amountInCents,
      if (competencyPrefix != null && competencyPrefix.isNotEmpty) 'competencyPrefix': competencyPrefix,
    });
  }

  Future<void> registerPayment({
    required String chargeId,
    required int amountInCents,
    required String paymentDate,
    required String method,
    String? notes,
  }) async {
    await _apiClient.postJson('/v1/finance/payments', {
      'chargeId': chargeId,
      'amountInCents': amountInCents,
      'paymentDate': paymentDate,
      'method': method,
      if (notes != null && notes.isNotEmpty) 'notes': notes,
    });
  }

  Future<void> cancelCharge({
    required String chargeId,
    required String reason,
  }) async {
    await _apiClient.postJson('/v1/finance/charges/$chargeId/cancel', {
      'reason': reason,
    });
  }

  Future<void> markOverdue() async {
    await _apiClient.postJson('/v1/finance/charges/mark-overdue', {});
  }
}
