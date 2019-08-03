# Jpost

[![CI Status](https://img.shields.io/travis/lywsbcn/Jpost.svg?style=flat)](https://travis-ci.org/lywsbcn/Jpost)
[![Version](https://img.shields.io/cocoapods/v/Jpost.svg?style=flat)](https://cocoapods.org/pods/Jpost)
[![License](https://img.shields.io/cocoapods/l/Jpost.svg?style=flat)](https://cocoapods.org/pods/Jpost)
[![Platform](https://img.shields.io/cocoapods/p/Jpost.svg?style=flat)](https://cocoapods.org/pods/Jpost)

## Use


基于 AFNetworking 的封装


普通的post请求
```ruby
+(void)postWithUrl:(NSString *)url
          AndParam:(id)param
           success:(void (^)(id response))success
              fail:(void (^)(NSError * error))fail;
```

可选择GET/POST发送请求
```ruby

+(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
         AndParam:(id)param
          success:(void(^)(id response))success
             fail:(void(^)(NSError * error))fail;
```

NSDictionary 转字符串post请求
```ruby
+(void)postWithUrl:(NSString *)url
     AndJsonObject:(id)jsonObject
           success:(void (^)(id response))success
              fail:(void (^)(NSError * error))fail;
```

json 字符串post请求
```ruby
+(void)postWithUrl:(NSString *)url
           AndJson:(NSString*)json
           success:(void(^)(id response))success
              fail:(void(^)(NSError*error))fail;
```


文件上传
```ruby
+(void)uploadFileWithUrl:(NSString*)url
                   param:(id)param
                   files:(NSArray*)files
           successHander:(void (^)(id response))success
              failHander:(void (^)(NSError * error))fail
                 progess:(void(^)(NSProgress * uploadProgress))progess;
                 
```


## Requirements

## Installation

Jpost is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Jpost'
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

lywsbcn, 89324055@qq.com

## License

Jpost is available under the MIT license. See the LICENSE file for more info.
