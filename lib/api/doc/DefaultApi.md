# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**memosGet**](DefaultApi.md#memosget) | **GET** /memos | メモ一覧の取得
[**memosMemoIdDelete**](DefaultApi.md#memosmemoiddelete) | **DELETE** /memos/{memoId} | メモの削除
[**memosMemoIdGet**](DefaultApi.md#memosmemoidget) | **GET** /memos/{memoId} | 特定のメモの取得
[**memosMemoIdPut**](DefaultApi.md#memosmemoidput) | **PUT** /memos/{memoId} | メモの更新
[**memosPost**](DefaultApi.md#memospost) | **POST** /memos | 新規メモの作成


# **memosGet**
> List<Memo> memosGet()

メモ一覧の取得

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.memosGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->memosGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Memo>**](Memo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **memosMemoIdDelete**
> memosMemoIdDelete(memoId)

メモの削除

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final memoId = memoId_example; // String | 

try {
    api_instance.memosMemoIdDelete(memoId);
} catch (e) {
    print('Exception when calling DefaultApi->memosMemoIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memoId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **memosMemoIdGet**
> Memo memosMemoIdGet(memoId)

特定のメモの取得

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final memoId = memoId_example; // String | 

try {
    final result = api_instance.memosMemoIdGet(memoId);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->memosMemoIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memoId** | **String**|  | 

### Return type

[**Memo**](Memo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **memosMemoIdPut**
> Memo memosMemoIdPut(memoId, newMemo)

メモの更新

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final memoId = memoId_example; // String | 
final newMemo = NewMemo(); // NewMemo | 

try {
    final result = api_instance.memosMemoIdPut(memoId, newMemo);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->memosMemoIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memoId** | **String**|  | 
 **newMemo** | [**NewMemo**](NewMemo.md)|  | 

### Return type

[**Memo**](Memo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **memosPost**
> Memo memosPost(newMemo)

新規メモの作成

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final newMemo = NewMemo(); // NewMemo | 

try {
    final result = api_instance.memosPost(newMemo);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->memosPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newMemo** | [**NewMemo**](NewMemo.md)|  | 

### Return type

[**Memo**](Memo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

