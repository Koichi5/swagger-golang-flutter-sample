//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DefaultApi {
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// メモ一覧の取得
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> memosGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/memos';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// メモ一覧の取得
  Future<List<Memo>?> memosGet() async {
    final response = await memosGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Memo>') as List)
        .cast<Memo>()
        .toList(growable: false);

    }
    return null;
  }

  /// メモの削除
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] memoId (required):
  Future<Response> memosMemoIdDeleteWithHttpInfo(String memoId,) async {
    // ignore: prefer_const_declarations
    final path = r'/memos/{memoId}'
      .replaceAll('{memoId}', memoId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// メモの削除
  ///
  /// Parameters:
  ///
  /// * [String] memoId (required):
  Future<void> memosMemoIdDelete(String memoId,) async {
    final response = await memosMemoIdDeleteWithHttpInfo(memoId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// 特定のメモの取得
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] memoId (required):
  Future<Response> memosMemoIdGetWithHttpInfo(String memoId,) async {
    // ignore: prefer_const_declarations
    final path = r'/memos/{memoId}'
      .replaceAll('{memoId}', memoId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// 特定のメモの取得
  ///
  /// Parameters:
  ///
  /// * [String] memoId (required):
  Future<Memo?> memosMemoIdGet(String memoId,) async {
    final response = await memosMemoIdGetWithHttpInfo(memoId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Memo',) as Memo;
    
    }
    return null;
  }

  /// メモの更新
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] memoId (required):
  ///
  /// * [NewMemo] newMemo (required):
  Future<Response> memosMemoIdPutWithHttpInfo(int memoId, NewMemo newMemo,) async {
    // ignore: prefer_const_declarations
    final path = r'/memos/{memoId}'
      .replaceAll('{memoId}', memoId.toString());

    // ignore: prefer_final_locals
    Object? postBody = newMemo;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// メモの更新
  ///
  /// Parameters:
  ///
  /// * [int] memoId (required):
  ///
  /// * [NewMemo] newMemo (required):
  Future<Memo?> memosMemoIdPut(int memoId, NewMemo newMemo,) async {
    final response = await memosMemoIdPutWithHttpInfo(memoId, newMemo,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Memo',) as Memo;
    
    }
    return null;
  }

  /// タグの追加
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] memoId (required):
  ///
  /// * [MemosMemoIdTagsPostRequest] memosMemoIdTagsPostRequest (required):
  Future<Response> memosMemoIdTagsPostWithHttpInfo(String memoId, MemosMemoIdTagsPostRequest memosMemoIdTagsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/memos/{memoId}/tags'
      .replaceAll('{memoId}', memoId);

    // ignore: prefer_final_locals
    Object? postBody = memosMemoIdTagsPostRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// タグの追加
  ///
  /// Parameters:
  ///
  /// * [String] memoId (required):
  ///
  /// * [MemosMemoIdTagsPostRequest] memosMemoIdTagsPostRequest (required):
  Future<Memo?> memosMemoIdTagsPost(String memoId, MemosMemoIdTagsPostRequest memosMemoIdTagsPostRequest,) async {
    final response = await memosMemoIdTagsPostWithHttpInfo(memoId, memosMemoIdTagsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Memo',) as Memo;
    
    }
    return null;
  }

  /// 新規メモの作成
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [NewMemo] newMemo (required):
  Future<Response> memosPostWithHttpInfo(NewMemo newMemo,) async {
    // ignore: prefer_const_declarations
    final path = r'/memos';

    // ignore: prefer_final_locals
    Object? postBody = newMemo;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// 新規メモの作成
  ///
  /// Parameters:
  ///
  /// * [NewMemo] newMemo (required):
  Future<Memo?> memosPost(NewMemo newMemo,) async {
    final response = await memosPostWithHttpInfo(newMemo,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Memo',) as Memo;
    
    }
    return null;
  }

  /// メモの検索
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] keyword (required):
  Future<Response> memosSearchGetWithHttpInfo(String keyword,) async {
    // ignore: prefer_const_declarations
    final path = r'/memos/search';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'keyword', keyword));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// メモの検索
  ///
  /// Parameters:
  ///
  /// * [String] keyword (required):
  Future<List<Memo>?> memosSearchGet(String keyword,) async {
    final response = await memosSearchGetWithHttpInfo(keyword,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Memo>') as List)
        .cast<Memo>()
        .toList(growable: false);

    }
    return null;
  }
}
