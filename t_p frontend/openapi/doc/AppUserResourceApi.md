# openapi.api.AppUserResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createAppUser**](AppUserResourceApi.md#createappuser) | **POST** /api/app-users | 
[**deleteAppUser**](AppUserResourceApi.md#deleteappuser) | **DELETE** /api/app-users/{id} | 
[**getAllAppUsers**](AppUserResourceApi.md#getallappusers) | **GET** /api/app-users | 
[**getAppUser**](AppUserResourceApi.md#getappuser) | **GET** /api/app-users/{id} | 
[**getAppUserByUserID**](AppUserResourceApi.md#getappuserbyuserid) | **GET** /api/app-users/userid/{id} | 
[**partialUpdateAppUser**](AppUserResourceApi.md#partialupdateappuser) | **PATCH** /api/app-users/{id} | 
[**updateAppUser**](AppUserResourceApi.md#updateappuser) | **PUT** /api/app-users/{id} | 


# **createAppUser**
> AppUserDTO createAppUser(appUserDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();
final AppUserDTO appUserDTO = ; // AppUserDTO | 

try {
    final response = api.createAppUser(appUserDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->createAppUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appUserDTO** | [**AppUserDTO**](AppUserDTO.md)|  | 

### Return type

[**AppUserDTO**](AppUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAppUser**
> deleteAppUser(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();
final int id = 789; // int | 

try {
    api.deleteAppUser(id);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->deleteAppUser: $e\n');
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

# **getAllAppUsers**
> BuiltList<AppUserDTO> getAllAppUsers()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();

try {
    final response = api.getAllAppUsers();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->getAllAppUsers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;AppUserDTO&gt;**](AppUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAppUser**
> AppUserDTO getAppUser(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();
final int id = 789; // int | 

try {
    final response = api.getAppUser(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->getAppUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**AppUserDTO**](AppUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAppUserByUserID**
> AppUserDTO getAppUserByUserID(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();
final int id = 789; // int | 

try {
    final response = api.getAppUserByUserID(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->getAppUserByUserID: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**AppUserDTO**](AppUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateAppUser**
> AppUserDTO partialUpdateAppUser(id, appUserDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();
final int id = 789; // int | 
final AppUserDTO appUserDTO = ; // AppUserDTO | 

try {
    final response = api.partialUpdateAppUser(id, appUserDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->partialUpdateAppUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **appUserDTO** | [**AppUserDTO**](AppUserDTO.md)|  | 

### Return type

[**AppUserDTO**](AppUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAppUser**
> AppUserDTO updateAppUser(id, appUserDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppUserResourceApi();
final int id = 789; // int | 
final AppUserDTO appUserDTO = ; // AppUserDTO | 

try {
    final response = api.updateAppUser(id, appUserDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppUserResourceApi->updateAppUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **appUserDTO** | [**AppUserDTO**](AppUserDTO.md)|  | 

### Return type

[**AppUserDTO**](AppUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

