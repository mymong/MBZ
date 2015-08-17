//
//  NSString+DoubleQuotesString.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "NSString+DoubleQuotesString.h"

@implementation NSString (DoubleQuotesString)

- (NSString *)stringByAddingDoubleQuotesIfContainSpaces {
    if (self.length > 0) {
        NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@" \t"]];
        if (range.location != NSNotFound) {
            return [NSString stringWithFormat:@"\"%@\"", self];
        }
    }
    return self;
}

@end
