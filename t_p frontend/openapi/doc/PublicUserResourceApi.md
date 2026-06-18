# openapi.api.PublicUserResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllPublicUsers**](PublicUserResourceApi.md#getallpublicusers) | **GET** /api/users | 
[**getAuthorities**](PublicUserResourceApi.md#getauthorities) | **GET** /api/authorities | 


# **getAllPublicUsers**
> BuiltList<UserDTO> getAllPublicUsers(page, size, sort)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPublicUserResourceApi();
final int page = 56; // int | Zero-based page index (0..N)
final int size = 56; // int | The size of the page to be returned
final BuiltList<String> sort = ; // BuiltList<String> | Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported.

try {
    final response = api.getAllPublicUsers(page, size, sort);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PublicUserResourceApi->getAllPublicUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**| Zero-based page index (0..N) | [optional] [default to 0]
 **size** | **int**| The size of the page to be returned | [optional] [default to 20]
 **sort** | [**BuiltList&lt;String&gt;**](String.md)| Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported. | [optional] 

### Return type

[**BuiltList&lt;UserDTO&gt;**](UserDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAuthorities**
> BuiltList<String> getAuthorities()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPublicUserResourceApi();

try {
    final response = api.getAuthorities();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PublicUserResourceApi->getAuthorities: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**BuiltList&lt;String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

