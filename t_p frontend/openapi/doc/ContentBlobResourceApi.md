# openapi.api.ContentBlobResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createContentBlob**](ContentBlobResourceApi.md#createcontentblob) | **POST** /api/content-blobs | 
[**deleteContentBlob**](ContentBlobResourceApi.md#deletecontentblob) | **DELETE** /api/content-blobs/{id} | 
[**getAllContentBlobs**](ContentBlobResourceApi.md#getallcontentblobs) | **GET** /api/content-blobs | 
[**getContentBlob**](ContentBlobResourceApi.md#getcontentblob) | **GET** /api/content-blobs/{id} | 
[**partialUpdateContentBlob**](ContentBlobResourceApi.md#partialupdatecontentblob) | **PATCH** /api/content-blobs/{id} | 
[**updateContentBlob**](ContentBlobResourceApi.md#updatecontentblob) | **PUT** /api/content-blobs/{id} | 


# **createContentBlob**
> ContentBlobDTO createContentBlob(contentBlobDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentBlobResourceApi();
final ContentBlobDTO contentBlobDTO = ; // ContentBlobDTO | 

try {
    final response = api.createContentBlob(contentBlobDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentBlobResourceApi->createContentBlob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contentBlobDTO** | [**ContentBlobDTO**](ContentBlobDTO.md)|  | 

### Return type

[**ContentBlobDTO**](ContentBlobDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteContentBlob**
> deleteContentBlob(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentBlobResourceApi();
final int id = 789; // int | 

try {
    api.deleteContentBlob(id);
} catch on DioException (e) {
    print('Exception when calling ContentBlobResourceApi->deleteContentBlob: $e\n');
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

# **getAllContentBlobs**
> BuiltList<ContentBlobDTO> getAllContentBlobs()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentBlobResourceApi();

try {
    final response = api.getAllContentBlobs();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentBlobResourceApi->getAllContentBlobs: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ContentBlobDTO&gt;**](ContentBlobDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContentBlob**
> ContentBlobDTO getContentBlob(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentBlobResourceApi();
final int id = 789; // int | 

try {
    final response = api.getContentBlob(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentBlobResourceApi->getContentBlob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**ContentBlobDTO**](ContentBlobDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateContentBlob**
> ContentBlobDTO partialUpdateContentBlob(id, contentBlobDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentBlobResourceApi();
final int id = 789; // int | 
final ContentBlobDTO contentBlobDTO = ; // ContentBlobDTO | 

try {
    final response = api.partialUpdateContentBlob(id, contentBlobDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentBlobResourceApi->partialUpdateContentBlob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **contentBlobDTO** | [**ContentBlobDTO**](ContentBlobDTO.md)|  | 

### Return type

[**ContentBlobDTO**](ContentBlobDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateContentBlob**
> ContentBlobDTO updateContentBlob(id, contentBlobDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContentBlobResourceApi();
final int id = 789; // int | 
final ContentBlobDTO contentBlobDTO = ; // ContentBlobDTO | 

try {
    final response = api.updateContentBlob(id, contentBlobDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ContentBlobResourceApi->updateContentBlob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **contentBlobDTO** | [**ContentBlobDTO**](ContentBlobDTO.md)|  | 

### Return type

[**ContentBlobDTO**](ContentBlobDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

