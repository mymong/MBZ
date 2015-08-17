//
//  MbzResponse.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzResponse.h"

@implementation MbzResponse

- (instancetype)initWithRawResponse:(RawResponse *)raw
{
    if (self = [super init]) {
        _raw = raw;
    }
    return self;
}

+ (instancetype)responseWithRaw:(RawResponse *)raw
{
    return [[MbzResponse alloc] initWithRawResponse:raw];
}

- (MbzError *)error
{
    NSInteger statusCode = self.raw.response.statusCode;
    
    // TODO
    // ...
    
    if (self.raw.error) {
        return [MbzError errorWithError:self.raw.error];
    }
    
    if (statusCode >= 400) {
        return [MbzError errorWithStatusCode:statusCode];
    }
    
    return nil;
}

@end
