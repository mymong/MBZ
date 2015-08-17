//
//  MbzDataAliase.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzDataAliase.h"

@implementation MbzDataAliase

- (NSString *)begin_date {
    return [self stringObjectForKey:@"begin-date"];
}

- (NSString *)end_date {
    return [self stringObjectForKey:@"end-date"];
}

- (NSString *)local {
    return [self stringObjectForKey:@"local"];
}

- (NSString *)name {
    return [self stringObjectForKey:@"name"];
}

- (NSString *)primary {
    return [self stringObjectForKey:@"primary"];
}

- (NSString *)sort_name {
    return [self stringObjectForKey:@"sort-name"];
}

- (NSString *)type {
    return [self stringObjectForKey:@"type"];
}

@end
