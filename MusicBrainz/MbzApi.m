//
//  MbzApi.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi.h"
#import "AFNetworking.h"

@interface AFHTTPRequestOperationManager (MbzRequestOperationManager)

+ (instancetype)mbz_sharedManager;

@end

@implementation AFHTTPRequestOperationManager (MbzRequestOperationManager)

+ (instancetype)mbz_sharedManager
{
    static AFHTTPRequestOperationManager *inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [AFHTTPRequestOperationManager manager];
        
        // default serializer(s)
        inst.requestSerializer = [AFJSONRequestSerializer serializer];
        inst.responseSerializer = [AFHTTPResponseSerializer serializer];
        inst.responseSerializer.acceptableStatusCodes = nil;
        
        // SSL settings for HTTPS
        inst.shouldUseCredentialStorage = NO;
        inst.credential = nil;
        inst.securityPolicy.allowInvalidCertificates = YES;
    });
    return inst;
}

@end

@implementation MbzApi

- (instancetype)init
{
    if (self = [super init]) {
        _baseURL = [NSURL URLWithString:@"http://musicbrainz.org"];
    }
    return self;
}

+ (instancetype)sharedApi
{
    static id inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [MbzApi new];
    });
    return inst;
}

- (void)send:(NSString *)method path:(NSString *)path parameters:(id)parameters headers:(NSDictionary *)headers completion:(MbzCompletion)completion
{
    void(^done)(NSHTTPURLResponse *, NSData *, NSError *) = ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        if (completion) {
            RawResponse *raw = [RawResponse new];
            raw.response = response;
            raw.data = data;
            raw.error = error;
            completion([MbzResponse responseWithRaw:raw]);
        }
    };
    
    NSURL *baseURL = self.baseURL;
    NSParameterAssert(baseURL);
    
    NSOperationQueue *operationQueue = self.operationQueue;
    dispatch_queue_t completionQueue = self.completionQueue;
    NSNumber *timeout = self.timeout;
    
    NSURL *url = [NSURL URLWithString:path relativeToURL:baseURL];
    NSParameterAssert(url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager mbz_sharedManager];
    AFHTTPRequestSerializer *serializer = manager.requestSerializer;
    NSError *error;
    
    NSMutableURLRequest *request = [serializer requestWithMethod:method URLString:url.absoluteString parameters:parameters error:&error];
    if (!request) {
        if (!error) {
            NSString *reason = NSLocalizedString(@"Failed to create NSURLRequest.", @"Unexpected Error");
            error = [MbzError errorWithUnexpectedInfo:reason file:__FILE__ line:__LINE__];
        }
        done(nil, nil, error);
        return;
    }
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    if (timeout.doubleValue > 0) {
        request.timeoutInterval = timeout.doubleValue;
    }
    
#ifdef DEBUG
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
#endif
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        done(operation.response, operation.responseData?:responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        done(operation.response, operation.responseData, error);
    }];
    
    operation.completionQueue = completionQueue ?: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSParameterAssert(operation.completionQueue);
    NSOperationQueue *queue = operationQueue ?: manager.operationQueue;
    NSParameterAssert(queue);
    [queue addOperation:operation];
}

@end
