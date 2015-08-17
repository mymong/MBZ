//
//  MbzResponse.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "RawResponse.h"
#import "MbzError.h"

@interface MbzResponse : NSObject
/**
 *  HTTP(s) Raw response.
 */
@property (nonatomic,readonly) RawResponse *raw;
/**
 *  Create with RawResponse object.
 *
 *  @param raw HTTP(s) raw response.
 *
 *  @return MBZ (MusicBrainz) API response object.
 */
+ (instancetype)responseWithRaw:(RawResponse *)raw;
/**
 *  Get error for this resonse.
 *
 *  @return Error object.
 */
- (MbzError *)error;

@end
