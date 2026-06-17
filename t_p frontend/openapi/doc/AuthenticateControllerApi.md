# openapi.api.AuthenticateControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authorize**](AuthenticateControllerApi.md#authorize) | **POST** /api/authenticate | 
[**isAuthenticated**](AuthenticateControllerApi.md#isauthenticated) | **GET** /api/authenticate | 


# **authorize**
> JWTToken authorize(loginVM)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticateControllerApi();
final LoginVM loginVM = ; // LoginVM | 

try {
    final response = api.authorize(loginVM);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticateControllerApi->authorize: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginVM** | [**LoginVM**](LoginVM.md)|  | 

### Return type

[**JWTToken**](JWTToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **isAuthenticated**
> String isAuthenticated()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticateControllerApi();

try {
    final response = api.isAuthenticated();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticateControllerApi->isAuthenticated: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

