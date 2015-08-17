//
//  MbzError.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzError.h"

NSString *const MbzErrorDomain = @"MbzErrorDomain";
NSString *const MbzIsUnexpectedErrorKey = @"MbzUnexpectedErrorKey"; // value: (BOOL)
NSString *const MbzHTTPStatusCodeErrorKey = @"MbzHTTPStatusCodeErrorKey"; // value: "400 Bad request."

@implementation MbzError

+ (instancetype)errorWithError:(NSError *)error
{
    if (!error) {
        return nil;
    }
    
    if ([error isKindOfClass:self.class]) {
        return (id)error;
    }
    
    MbzErrorCode errorCode = MbzErrorFailed;
    
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        switch (error.code) {
            case NSURLErrorCancelled:
            case NSURLErrorUserCancelledAuthentication:
                errorCode = MbzErrorCancelled;
                break;
            case NSURLErrorUserAuthenticationRequired:
                errorCode = MbzErrorUnauthorized;
                break;
            case NSURLErrorTimedOut:
                errorCode = MbzErrorTimeout;
                break;
            case NSURLErrorDNSLookupFailed:
            case NSURLErrorNotConnectedToInternet:
                errorCode = MbzErrorNetworkNotAvailable;
                break;
            case NSURLErrorFileDoesNotExist:
                errorCode = MbzErrorNotFound;
                break;
            default:
                errorCode = MbzErrorFailed;
                break;
        }
    }
    
    NSString *localizedDescription = [MbzError localizedStringForErrorCode:errorCode];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if (localizedDescription) {
        userInfo[NSLocalizedDescriptionKey] = localizedDescription;
    }
    if (error) {
        userInfo[NSUnderlyingErrorKey] = error;
    }
    return [self errorWithDomain:MbzErrorDomain code:errorCode userInfo:userInfo];
}

+ (instancetype)errorWithStatusCode:(NSInteger)statusCode
{
    if (statusCode < 400) {
        return nil;
    }
    
    MbzErrorCode errorCode;
    switch (statusCode) {
        case 401:
            errorCode = MbzErrorUnauthorized;
            break;
        case 404:
            errorCode = MbzErrorNotFound;
            break;
        case 408:
        case 504:
            errorCode = MbzErrorTimeout;
            break;
        default:
            errorCode = MbzErrorFailed;
            break;
    }
    
    NSString *localizedDescription = [self localizedStringForErrorCode:errorCode];
    NSString *statusCodeString = [self localizedStringForStatusCode:statusCode];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if (localizedDescription) {
        userInfo[NSLocalizedDescriptionKey] = localizedDescription;
    }
    if (statusCodeString) {
        userInfo[MbzHTTPStatusCodeErrorKey] = statusCodeString;
    }
    return [self errorWithDomain:MbzErrorDomain code:errorCode userInfo:userInfo];
}

+ (instancetype)errorWithUnexpectedInfo:(id)info file:(const char *)file line:(int)line
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    
    userInfo[MbzIsUnexpectedErrorKey] = @(YES);
    
    if (info) {
        if ([info isKindOfClass:NSString.class]) {
            userInfo[NSLocalizedFailureReasonErrorKey] = info;
        }
        else if ([info isKindOfClass:NSError.class]) {
            userInfo[NSUnderlyingErrorKey] = info;
        }
        else {
            userInfo[@"UnexpectedInfo"] = info;
        }
    }
    
    if (file) {
        userInfo[@"__FILE__"] = [NSString stringWithUTF8String:file];
    }
    
    if (line > 0) {
        userInfo[@"__LINE__"] = @(line);
    }
    
    return [self errorWithDomain:MbzErrorDomain code:MbzErrorFailed userInfo:userInfo];
}

#pragma mark

+ (NSString *)localizedStringForErrorCode:(MbzErrorCode)code
{
    switch (code) {
        case MbzErrorFailed:
            return NSLocalizedString(@"Operation can not complete.", @"MbzErrorFailed");
        case MbzErrorCancelled:
            return NSLocalizedString(@"User Cancelled.", @"MbzErrorCancelled");
        case MbzErrorNetworkNotAvailable:
            return NSLocalizedString(@"Network not available, please check your network settings.", @"MbzErrorNetworkNotAvailable");
        case MbzErrorUnauthorized:
            return NSLocalizedString(@"Connection is unauthorized.", @"MbzErrorUnauthorized");
        case MbzErrorTimeout:
            return NSLocalizedString(@"Operation timeout.", @"MbzErrorTimeout");
        case MbzErrorNotFound:
            return NSLocalizedString(@"Requested resource is not found.", @"MbzErrorNotFound");
        default:
            return nil;
    }
}

+ (NSString *)localizedStringForStatusCode:(NSInteger)statusCode {
    NSString *message = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
    return [NSString stringWithFormat:@"%ld %@", (long)statusCode, message];
}

@end
