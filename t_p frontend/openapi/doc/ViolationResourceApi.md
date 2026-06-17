# openapi.api.ViolationResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createViolation**](ViolationResourceApi.md#createviolation) | **POST** /api/violations | 
[**deleteViolation**](ViolationResourceApi.md#deleteviolation) | **DELETE** /api/violations/{id} | 
[**getAllViolations**](ViolationResourceApi.md#getallviolations) | **GET** /api/violations | 
[**getViolation**](ViolationResourceApi.md#getviolation) | **GET** /api/violations/{id} | 
[**partialUpdateViolation**](ViolationResourceApi.md#partialupdateviolation) | **PATCH** /api/violations/{id} | 
[**updateViolation**](ViolationResourceApi.md#updateviolation) | **PUT** /api/violations/{id} | 


# **createViolation**
> ViolationDTO createViolation(violationDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getViolationResourceApi();
final ViolationDTO violationDTO = ; // ViolationDTO | 

try {
    final response = api.createViolation(violationDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ViolationResourceApi->createViolation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **violationDTO** | [**ViolationDTO**](ViolationDTO.md)|  | 

### Return type

[**ViolationDTO**](ViolationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteViolation**
> deleteViolation(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getViolationResourceApi();
final int id = 789; // int | 

try {
    api.deleteViolation(id);
} catch on DioException (e) {
    print('Exception when calling ViolationResourceApi->deleteViolation: $e\n');
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

# **getAllViolations**
> BuiltList<ViolationDTO> getAllViolations()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getViolationResourceApi();

try {
    final response = api.getAllViolations();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ViolationResourceApi->getAllViolations: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ViolationDTO&gt;**](ViolationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getViolation**
> ViolationDTO getViolation(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getViolationResourceApi();
final int id = 789; // int | 

try {
    final response = api.getViolation(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ViolationResourceApi->getViolation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**ViolationDTO**](ViolationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateViolation**
> ViolationDTO partialUpdateViolation(id, violationDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getViolationResourceApi();
final int id = 789; // int | 
final ViolationDTO violationDTO = ; // ViolationDTO | 

try {
    final response = api.partialUpdateViolation(id, violationDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ViolationResourceApi->partialUpdateViolation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **violationDTO** | [**ViolationDTO**](ViolationDTO.md)|  | 

### Return type

[**ViolationDTO**](ViolationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateViolation**
> ViolationDTO updateViolation(id, violationDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getViolationResourceApi();
final int id = 789; // int | 
final ViolationDTO violationDTO = ; // ViolationDTO | 

try {
    final response = api.updateViolation(id, violationDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ViolationResourceApi->updateViolation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **violationDTO** | [**ViolationDTO**](ViolationDTO.md)|  | 

### Return type

[**ViolationDTO**](ViolationDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

