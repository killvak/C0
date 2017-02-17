//
//  HTTPRequests.h
//  instabug 0
//
//  Created by Killvak on 17/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequests : NSObject
-(void)postJsonResponse:(NSString *)urlStr jsonBody:(NSString*)jsonBody header:(NSDictionary*)header success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;

-(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure ;
//@property (nonatomic,strong) NSMutableOrderedSet *dataTasks ;
@property (nonatomic) int activeDatataskCount ;
@property (nonatomic) int maxActiveDatataskCount ;
@end
