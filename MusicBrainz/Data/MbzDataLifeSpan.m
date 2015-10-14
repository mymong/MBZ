//
//  MbzDataLifeSpan.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzDataLifeSpan.h"

@implementation MbzDataLifeSpan

- (NSString *)begin {
    return [self stringObjectForKey:@"begin"];
}

- (NSString *)end {
    return [self stringObjectForKey:@"end"];
}

- (NSNumber *)ended {
    return [self numberObjectForKey:@"ended"];
}

- (NSString *)description {
    NSString *end = self.end;
    NSString *begin = self.begin;
    
    if (end) {
        return [NSString stringWithFormat:@"(%@, %@)", begin?:@"?", end];
    }
    
    if (begin) {
        return [NSString stringWithFormat:@"(%@)", begin];
    }
    
    return @"";
}

@end
