# openapi.api.PointsResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPoints**](PointsResourceApi.md#createpoints) | **POST** /api/points | 
[**deletePoints**](PointsResourceApi.md#deletepoints) | **DELETE** /api/points/{id} | 
[**getAllPoints**](PointsResourceApi.md#getallpoints) | **GET** /api/points | 
[**getPoints**](PointsResourceApi.md#getpoints) | **GET** /api/points/{id} | 
[**partialUpdatePoints**](PointsResourceApi.md#partialupdatepoints) | **PATCH** /api/points/{id} | 
[**updatePoints**](PointsResourceApi.md#updatepoints) | **PUT** /api/points/{id} | 


# **createPoints**
> PointsDTO createPoints(pointsDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPointsResourceApi();
final PointsDTO pointsDTO = ; // PointsDTO | 

try {
    final response = api.createPoints(pointsDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PointsResourceApi->createPoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pointsDTO** | [**PointsDTO**](PointsDTO.md)|  | 

### Return type

[**PointsDTO**](PointsDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePoints**
> deletePoints(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPointsResourceApi();
final int id = 789; // int | 

try {
    api.deletePoints(id);
} catch on DioException (e) {
    print('Exception when calling PointsResourceApi->deletePoints: $e\n');
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

# **getAllPoints**
> BuiltList<PointsDTO> getAllPoints(filter)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPointsResourceApi();
final String filter = filter_example; // String | 

try {
    final response = api.getAllPoints(filter);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PointsResourceApi->getAllPoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filter** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;PointsDTO&gt;**](PointsDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPoints**
> PointsDTO getPoints(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPointsResourceApi();
final int id = 789; // int | 

try {
    final response = api.getPoints(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PointsResourceApi->getPoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**PointsDTO**](PointsDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdatePoints**
> PointsDTO partialUpdatePoints(id, pointsDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPointsResourceApi();
final int id = 789; // int | 
final PointsDTO pointsDTO = ; // PointsDTO | 

try {
    final response = api.partialUpdatePoints(id, pointsDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PointsResourceApi->partialUpdatePoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **pointsDTO** | [**PointsDTO**](PointsDTO.md)|  | 

### Return type

[**PointsDTO**](PointsDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePoints**
> PointsDTO updatePoints(id, pointsDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPointsResourceApi();
final int id = 789; // int | 
final PointsDTO pointsDTO = ; // PointsDTO | 

try {
    final response = api.updatePoints(id, pointsDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PointsResourceApi->updatePoints: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **pointsDTO** | [**PointsDTO**](PointsDTO.md)|  | 

### Return type

[**PointsDTO**](PointsDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

