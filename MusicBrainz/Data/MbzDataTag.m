//
//  MbzDataTag.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzDataTag.h"

@implementation MbzDataTag

- (NSString *)name {
    return [self stringObjectForKey:@"name"];
}

- (NSNumber *)count {
    return [self numberObjectForKey:@"count"];
}

@end
