//
//  MbzError.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MbzErrorDomain;
extern NSString *const MbzIsUnexpectedErrorKey;
extern NSString *const MbzHTTPStatusCodeErrorKey;

typedef NS_ENUM(NSInteger, MbzErrorCode) {
    /**
     *  Operation failed.
     *  <p/>UI should report this failure with localized description.
     *  If localized description is not present, UI should decide a default message based on its current operation.
     */
    MbzErrorFailed = 1,
    /**
     *  User Cancelled.
     */
    MbzErrorCancelled,
    /**
     *  Can not access the internet.
     *  <p/>UI should notify user a message such as "Network not available, please check your network settings!".
     */
    MbzErrorNetworkNotAvailable,
    /**
     *  Connection unauthorized.
     */
    MbzErrorUnauthorized,
    /**
     *  Operation timeout.
     *  <p/>We should retry this operation soon, or UI prompts user trying it later.
     *  <p/>The status code maybe 408(ClientTimeout), 504(ServerTimeout).
     */
    MbzErrorTimeout,
    /**
     *  Requested resource not found.
     */
    MbzErrorNotFound,
};

@interface MbzError : NSError
+ (instancetype)errorWithError:(NSError *)error;
+ (instancetype)errorWithStatusCode:(NSInteger)statusCode;
+ (instancetype)errorWithUnexpectedInfo:(id)info file:(const char *)file line:(int)line;

@end
