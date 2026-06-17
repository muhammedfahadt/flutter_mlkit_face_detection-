# openapi.api.AccountResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**activateAccount**](AccountResourceApi.md#activateaccount) | **GET** /api/activate | 
[**changePassword**](AccountResourceApi.md#changepassword) | **POST** /api/account/change-password | 
[**finishPasswordReset**](AccountResourceApi.md#finishpasswordreset) | **POST** /api/account/reset-password/finish | 
[**getAccount**](AccountResourceApi.md#getaccount) | **GET** /api/account | 
[**registerAccount**](AccountResourceApi.md#registeraccount) | **POST** /api/register | 
[**requestPasswordReset**](AccountResourceApi.md#requestpasswordreset) | **POST** /api/account/reset-password/init | 
[**saveAccount**](AccountResourceApi.md#saveaccount) | **POST** /api/account | 


# **activateAccount**
> activateAccount(key)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();
final String key = key_example; // String | 

try {
    api.activateAccount(key);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->activateAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changePassword**
> changePassword(passwordChangeDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();
final PasswordChangeDTO passwordChangeDTO = ; // PasswordChangeDTO | 

try {
    api.changePassword(passwordChangeDTO);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **passwordChangeDTO** | [**PasswordChangeDTO**](PasswordChangeDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **finishPasswordReset**
> finishPasswordReset(keyAndPasswordVM)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();
final KeyAndPasswordVM keyAndPasswordVM = ; // KeyAndPasswordVM | 

try {
    api.finishPasswordReset(keyAndPasswordVM);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->finishPasswordReset: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyAndPasswordVM** | [**KeyAndPasswordVM**](KeyAndPasswordVM.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAccount**
> AdminUserDTO getAccount()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();

try {
    final response = api.getAccount();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->getAccount: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AdminUserDTO**](AdminUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerAccount**
> registerAccount(managedUserVM)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();
final ManagedUserVM managedUserVM = ; // ManagedUserVM | 

try {
    api.registerAccount(managedUserVM);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->registerAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **managedUserVM** | [**ManagedUserVM**](ManagedUserVM.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestPasswordReset**
> requestPasswordReset(body)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();
final String body = body_example; // String | 

try {
    api.requestPasswordReset(body);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->requestPasswordReset: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **saveAccount**
> saveAccount(adminUserDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAccountResourceApi();
final AdminUserDTO adminUserDTO = ; // AdminUserDTO | 

try {
    api.saveAccount(adminUserDTO);
} catch on DioException (e) {
    print('Exception when calling AccountResourceApi->saveAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminUserDTO** | [**AdminUserDTO**](AdminUserDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

