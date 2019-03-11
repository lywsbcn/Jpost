//
//  JHA.m
//  Jpost_Tests
//
//  Created by w on 2019/1/14.
//  Copyright © 2019年 lywsbcn. All rights reserved.
//

#import "Jpost.h"
#import "AFHTTPSessionManager.h"

#ifndef NDEBUG
#define NLog(message, ...) printf("%s\n", [[NSString stringWithFormat:message, ##__VA_ARGS__] UTF8String])
#else
#define NLog(message, ...)
#endif

static Jpost * jpostManager = nil;
@interface Jpost()

@property(nonatomic,strong)AFHTTPSessionManager * AFSession;

@end
@implementation Jpost

+(instancetype)instante{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jpostManager =[[self alloc]init];
    });
    return jpostManager;
}

-(AFHTTPSessionManager *)AFSession{
    if(!_AFSession){
        _AFSession =[AFHTTPSessionManager manager];
    }
    return _AFSession;
}


+(void)postWithUrl:(NSString *)url
          AndParam:(id)param
           success:(void (^)(id))success
              fail:(void (^)(NSError *))fail{
    [self requestUrl:url AndMethod:@"POST" AndParam:param success:success fail:fail];
}

+(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
         AndParam:(id)param
          success:(void (^)(id))success
             fail:(void (^)(NSError *))fail{
    [[self instante] requestUrl:url AndMethod:method AndParam:param success:success fail:fail];
}





-(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
         AndParam:(id)param
          success:(void (^)(id))success
             fail:(void (^)(NSError *))fail{
    
    NLog(@"--->请求地址 %@\n",url);
    NSString * paramString = @"";
    if(param){
        paramString =[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil] encoding:NSUTF8StringEncoding];
        NLog(@"--->请求参数 %@\n",paramString);
    }
    
    NSMutableURLRequest * request=[[AFHTTPRequestSerializer serializer] requestWithMethod:[method uppercaseString] URLString:url parameters:param error:nil];
    
    request.timeoutInterval = 30;
    
    self.AFSession.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:
                                                               @"application/json",
                                                               @"text/json",
                                                               @"text/javascript",
                                                               @"text/html",
                                                               @"application/x-www-form-urlencoded",
                                                               @"text/plain",
                                                               nil];
    [[self.AFSession dataTaskWithRequest:request
                       completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
                           NLog(@"<---请求地址 %@\n",url);
                           if(error){
                               NLog(@"<---请求错误 %@\n",paramString);
                               [self error:error fail:fail];
                           }else{
                               if(responseObject){
                                  NLog(@"<---回复数据 %@\n", [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding]);
                               }
                               [self mainQueueBlock:^{
                                   if(success) success(responseObject);
                               }];
                           }
    }] resume];
}
+(void)postWithUrl:(NSString *)url
     AndJsonObject:(id)jsonObject
           success:(void (^)(id))success
              fail:(void (^)(NSError *))fail{
    
    NSString * json = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil] encoding:NSUTF8StringEncoding];
    [self postWithUrl:url AndJson:json success:success fail:fail];
}


+(void)postWithUrl:(NSString *)url
           AndJson:(NSString *)json
           success:(void (^)(id))success
              fail:(void (^)(NSError *))fail{
    [[self instante] requestUrl:url AndMethod:@"POST" AndJson:json success:success fail:fail];
}



-(void)requestUrl:(NSString *)url
        AndMethod:(NSString *)method
          AndJson:(id)Json
          success:(void (^)(id))success
             fail:(void (^)(NSError *))fail{
    NLog(@"--->请求地址 %@\n",url);
    NLog(@"--->请求参数 %@\n",Json);
    
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = [method uppercaseString];
    request.HTTPBody =[Json dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 30;
    
    self.AFSession.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:
                                                               @"application/json",
                                                               @"text/json",
                                                               @"text/javascript",
                                                               @"text/html",
                                                               @"application/x-www-form-urlencoded",
                                                               @"text/plain",
                                                               nil];
    [[self.AFSession dataTaskWithRequest:request
                       completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
                           NLog(@"<---请求地址 %@\n",url);
                           if(error){
                               NLog(@"<---请求错误 %@\n",Json);
                               [self error:error fail:fail];
                           }else{
                               if(responseObject){
                                   NLog(@"<---回复数据 %@\n", [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding]);
                               }
                               [self mainQueueBlock:^{
                                   if(success) success(responseObject);
                               }];
                           }
                       }] resume];
}

+(void)uploadFileWithUrl:(NSString *)url
                   param:(id)param files:(NSArray *)files
           successHander:(void (^)(id))success
              failHander:(void (^)(NSError *))fail
                 progess:(void (^)(NSProgress *))progess{
    
    [[self instante] uploadFileWithUrl:url param:param files:files successHander:success failHander:fail progess:progess];
}

-(void)uploadFileWithUrl:(NSString *)url
                   param:(id)param
                   files:(NSArray *)files
           successHander:(void (^)(id))success
              failHander:(void (^)(NSError *))fail
                 progess:(void (^)(NSProgress *))progess
{
    NLog(@"--->请求地址 %@\n",url);
    NSString * paramString = @"";
    if(param){
        paramString =[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil] encoding:NSUTF8StringEncoding];
        NLog(@"--->请求参数 %@\n",paramString);
    }
  
    
    [self.AFSession POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [self encodeData:files formData:formData];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
            [self mainQueueBlock:^{
                if(progess) progess(uploadProgress);
            }];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NLog(@"<---请求地址 %@\n",url);
        if(responseObject){
            NLog(@"<---回复数据 %@\n", [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding]);
        }
        [self mainQueueBlock:^{
            if(success) success(responseObject);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NLog(@"<---请求地址 %@\n",url);
        if(error){
            NLog(@"<---请求错误 %@\n",paramString);
            [self error:error fail:fail];
        }
    }];
    
}

-(void)encodeData:(NSArray*)files formData:(id<AFMultipartFormData>  _Nonnull)formData{
    for(NSInteger i=0;i<files.count;i++){
        id file = files[i];
        
        NSData * data;
        NSString * mimeType;
        NSString * ext;
        if([file isKindOfClass:[UIImage class]]){
            data = UIImageJPEGRepresentation(file, 1.0);
            mimeType = @"image/jpg";
            ext = @"jpg";
        }else if ([file isKindOfClass:[NSString class]]){
            data = [NSData dataWithContentsOfFile:file];
            mimeType = @"video/mp4";
            ext = @"mp4";
        }
        [formData appendPartWithFileData:data
                                    name:[NSString stringWithFormat:@"file%ld",i]
                                fileName:[NSString stringWithFormat:@"filename%ld.%@",i,ext]
                                mimeType:mimeType];
    }
}


-(void)error:(NSError*)error fail:(void(^)(NSError *))fail{
    NLog(@"<---错误信息 错误码%ld \n%@\n",error.code,error);
    
    [self mainQueueBlock:^{
        if(fail)fail(error);
    }];
    
}

-(void)mainQueueBlock:(void(^)(void))block{
    dispatch_queue_t mainQueue =dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        block();
    });
}

@end
