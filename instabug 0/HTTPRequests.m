//
//  HTTPRequests.m
//  instabug 0
//
//  Created by Killvak on 17/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

#import "HTTPRequests.h"

@implementation HTTPRequests





-(void)postDataWithUrlString:(NSString*)urlString withData:(NSMutableDictionary *)dicData success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure{
    
    NSError *error;
    
    
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:200.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"627562626c6520617069206b6579" forHTTPHeaderField:@"Authorization"];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dicData options:0 error:&error];
    
    
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error==nil) {
            
            NSError*error;
            NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            success(jsonString);
            NSLog(@"error%@ array%@",error.localizedDescription,jsonString);
            
            
            
            
            
        }
        else {
            NSLog(@"%@",error.localizedDescription);
            
            failure(error);
            
        }
        
    }];
    
    [postDataTask resume];
    
    
    
    
    
}

-(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    //    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [ NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    // Asynchronously API is hit here
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        _activeDatataskCount -= 1;
        if (error){
            failure(error);
        }else {
            NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",json);
            success(json);
        }
    }];
    [self enqueueWithDataTask:dataTask];
}

-(void) enqueueWithDataTask:(NSURLSessionDataTask*)dataTask {
    
    if (_activeDatataskCount <= _maxActiveDatataskCount) {
        [ dataTask resume];
        _activeDatataskCount += 1 ;
        
//        [_dataTasks addObject:dataTask];
//        NSLog(@"Killva:  %@ _activeDatataskCount: %i , _maxActiveDatataskCount: %i  " , _dataTasks,_activeDatataskCount , _maxActiveDatataskCount);
        
    }else {
        //         [_dataTasks[_activeDatataskCount] suspend];
    }
}


@end
