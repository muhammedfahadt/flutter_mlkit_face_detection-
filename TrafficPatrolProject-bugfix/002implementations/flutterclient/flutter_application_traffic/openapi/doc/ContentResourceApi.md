# openapi.api.ContentResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createContent**](ContentResourceApi.md#createcontent) | **POST** /api/contents | 
[**deleteContent**](ContentResourceApi.md#deletecontent) | **DELETE** /api/contents/{id} | 
[**getAllContents**](ContentResourceApi.md#getallcontents) | **GET** /api/contents | 
[**getContent**](ContentResourceApi.md#getcontent) | **GET** /api/contents/{id} | 
[**partialUpdateContent**](ContentResourceApi.md#partialupdatecontent) | **PATCH** /api/contents/{id} | 
[**updateContent**](ContentResourceApi.md#updatecontent) | **PUT** /api/contents/{id} | 


# **createContent**
> ContentDTO createContent(contentDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentResourceApi();
final ContentDTO contentDTO = ; // ContentDTO | 

try {
    final response = api.createContent(contentDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentResourceApi->createContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contentDTO** | [**ContentDTO**](ContentDTO.md)|  | 

### Return type

[**ContentDTO**](ContentDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteContent**
> deleteContent(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentResourceApi();
final int id = 789; // int | 

try {
    api.deleteContent(id);
} catch on DioException (e) {
    print('Exception when calling ContentResourceApi->deleteContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllContents**
> BuiltList<ContentDTO> getAllContents()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentResourceApi();

try {
    final response = api.getAllContents();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentResourceApi->getAllContents: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ContentDTO&gt;**](ContentDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContent**
> ContentDTO getContent(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentResourceApi();
final int id = 789; // int | 

try {
    final response = api.getContent(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentResourceApi->getContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**ContentDTO**](ContentDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateContent**
> ContentDTO partialUpdateContent(id, contentDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentResourceApi();
final int id = 789; // int | 
final ContentDTO contentDTO = ; // ContentDTO | 

try {
    final response = api.partialUpdateContent(id, contentDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentResourceApi->partialUpdateContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **contentDTO** | [**ContentDTO**](ContentDTO.md)|  | 

### Return type

[**ContentDTO**](ContentDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateContent**
> ContentDTO updateContent(id, contentDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentResourceApi();
final int id = 789; // int | 
final ContentDTO contentDTO = ; // ContentDTO | 

try {
    final response = api.updateContent(id, contentDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentResourceApi->updateContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **contentDTO** | [**ContentDTO**](ContentDTO.md)|  | 

### Return type

[**ContentDTO**](ContentDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

