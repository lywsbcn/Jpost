//
//  JHA.h
//  Jpost_Tests
//
//  Created by w on 2019/1/14.
//  Copyright © 2019年 lywsbcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jpost : NSObject

+(instancetype)instante;

+(void)postWithUrl:(NSString *)url
          AndParam:(id)param
           success:(void (^)(id response))success
              fail:(void (^)(NSError * error))fail;

+(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
         AndParam:(id)param
          success:(void(^)(id response))success
             fail:(void(^)(NSError * error))fail;

-(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
         AndParam:(id)param
          success:(void(^)(id response))success
             fail:(void(^)(NSError * error))fail;

/*json 字符串请求*/

+(void)postWithUrl:(NSString *)url
     AndJsonObject:(id)jsonObject
           success:(void (^)(id response))success
              fail:(void (^)(NSError * error))fail;

+(void)postWithUrl:(NSString *)url
           AndJson:(NSString*)json
           success:(void(^)(id response))success
              fail:(void(^)(NSError*error))fail;

-(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
         AndJson:(id)Json
          success:(void(^)(id response))success
             fail:(void(^)(NSError * error))fail;

/*文件上传*/
+(void)uploadFileWithUrl:(NSString*)url
                   param:(id)param
                   files:(NSArray*)files
           successHander:(void (^)(id response))success
              failHander:(void (^)(NSError * error))fail
                 progess:(void(^)(NSProgress * uploadProgress))progess;

-(void)uploadFileWithUrl:(NSString *)url
                   param:(id)param
                   files:(NSArray *)files
           successHander:(void (^)(id response))success
              failHander:(void (^)(NSError * error))fail
                 progess:(void (^)(NSProgress *uploadProgress))progess;


@end
