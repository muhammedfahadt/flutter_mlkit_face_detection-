# openapi.api.UserResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UserResourceApi.md#createuser) | **POST** /api/admin/users | 
[**deleteUser**](UserResourceApi.md#deleteuser) | **DELETE** /api/admin/users/{login} | 
[**getAllUsers**](UserResourceApi.md#getallusers) | **GET** /api/admin/users | 
[**getUser**](UserResourceApi.md#getuser) | **GET** /api/admin/users/{login} | 
[**updateUser**](UserResourceApi.md#updateuser) | **PUT** /api/admin/users | 


# **createUser**
> User createUser(adminUserDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserResourceApi();
final AdminUserDTO adminUserDTO = ; // AdminUserDTO | 

try {
    final response = api.createUser(adminUserDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserResourceApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminUserDTO** | [**AdminUserDTO**](AdminUserDTO.md)|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUser**
> deleteUser(login)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserResourceApi();
final String login = login_example; // String | 

try {
    api.deleteUser(login);
} catch on DioException (e) {
    print('Exception when calling UserResourceApi->deleteUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **login** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllUsers**
> BuiltList<AdminUserDTO> getAllUsers(page, size, sort)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserResourceApi();
final int page = 56; // int | Zero-based page index (0..N)
final int size = 56; // int | The size of the page to be returned
final BuiltList<String> sort = ; // BuiltList<String> | Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported.

try {
    final response = api.getAllUsers(page, size, sort);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserResourceApi->getAllUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| Zero-based page index (0..N) | [optional] [default to 0]
 **size** | **int**| The size of the page to be returned | [optional] [default to 20]
 **sort** | [**BuiltList&lt;String&gt;**](String.md)| Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported. | [optional] 

### Return type

[**BuiltList&lt;AdminUserDTO&gt;**](AdminUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> AdminUserDTO getUser(login)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserResourceApi();
final String login = login_example; // String | 

try {
    final response = api.getUser(login);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserResourceApi->getUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **login** | **String**|  | 

### Return type

[**AdminUserDTO**](AdminUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> AdminUserDTO updateUser(adminUserDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserResourceApi();
final AdminUserDTO adminUserDTO = ; // AdminUserDTO | 

try {
    final response = api.updateUser(adminUserDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserResourceApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminUserDTO** | [**AdminUserDTO**](AdminUserDTO.md)|  | 

### Return type

[**AdminUserDTO**](AdminUserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

