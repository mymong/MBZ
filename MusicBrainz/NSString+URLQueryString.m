//
//  NSString+URLQueryString.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "NSString+URLQueryString.h"

@implementation NSString (URLQueryString)

- (instancetype)stringByAddingURLQueryStringFromParameters:(NSDictionary *)parameters {
    NSString *queryString = [NSString URLQueryStringFromParameters:parameters];
    if (queryString) {
        return [self stringByAppendingFormat:@"?%@", queryString];
    }
    return [self copy];
}

- (instancetype)stringByAppendingURLQueryStringFromParameters:(NSDictionary *)parameters {
    NSString *queryString = [NSString URLQueryStringFromParameters:parameters];
    if (queryString) {
        return [self stringByAppendingFormat:@"&%@", queryString];
    }
    return [self copy];
}

+ (instancetype)URLQueryStringFromParameters:(NSDictionary *)parameters {
    if (0 == parameters.count) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray new];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [array addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    return [array componentsJoinedByString:@"&"];
}

@end
