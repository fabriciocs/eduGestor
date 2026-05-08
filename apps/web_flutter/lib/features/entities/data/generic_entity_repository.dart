import '../../../../core/http/api_client.dart';
class GenericEntityRepository { GenericEntityRepository(this._apiClient); final ApiClient _apiClient;
Future<List<Map<String, dynamic>>> listRows(String table, {String? search}) async { final result = await _apiClient.getJson('/v1/entities/$table', query: {if (search != null && search.isNotEmpty) 'search': search}); return (result['data'] as List<dynamic>? ?? const []).cast<Map<String, dynamic>>(); }
Future<Map<String, dynamic>> createRow(String table, Map<String, dynamic> payload) => _apiClient.postJson('/v1/entities/$table', payload);
Future<Map<String, dynamic>> updateRow(String table, String id, Map<String, dynamic> payload) => _apiClient.patchJson('/v1/entities/$table/$id', payload);
Future<void> deleteRow(String table, String id) async { await _apiClient.deleteJson('/v1/entities/$table/$id'); } }
