//
//  RawResponse.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "RawResponse.h"
#import "AFNetworking.h"

@implementation RawResponse
{
    id _json;
}

- (id)JSONObjectFromData:(NSError **)error
{
    if (!_json) {
        _json = [[AFJSONResponseSerializer serializer] responseObjectForResponse:self.response data:self.data error:error];
    }
    return _json;
}

- (id)JSONObjectFromData
{
    return [self JSONObjectFromData:NULL];
}

@end
