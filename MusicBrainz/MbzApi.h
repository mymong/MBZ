//
//  MbzApi.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzCompletion.h"

@interface MbzApi : NSObject

+ (instancetype)sharedApi;

@property (nonatomic) NSURL *baseURL;

// optional
@property (nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) dispatch_queue_t completionQueue;
@property (nonatomic) NSNumber *timeout;

/**
 *  Send request with method path parameters and headers,
 *  receive response by completion block.
 *
 *  @param method     HTTP(s) method type.
 *  @param path       Path relative to base URL.
 *  @param parameters Parameters to send. (optional)
 *  @param headers    HTTP request header fields. (optional)
 *  @param completion Completion block to receive the response.
 */
- (void)send:(NSString *)method
        path:(NSString *)path
  parameters:(id)parameters // NSDictionary or NSArray
     headers:(NSDictionary *)headers
  completion:(MbzCompletion)completion;

@end
