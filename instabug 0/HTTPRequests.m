//
//  HTTPRequests.m
//  instabug 0
//
//  Created by Killvak on 17/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

#import "HTTPRequests.h"

@implementation HTTPRequests



-(void)postJsonResponse:(NSString *)urlStr jsonBody:(NSString*)jsonBody header:(NSDictionary*)header success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    
    
    
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
