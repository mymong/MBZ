//
//  MbzDataArea.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzDataArea.h"

@implementation MbzDataArea

- (NSString *)name {
    return [self stringObjectForKey:@"name"];
}

- (NSString *)sort_name {
    return [self stringObjectForKey:@"sort-name"];
}

@end
