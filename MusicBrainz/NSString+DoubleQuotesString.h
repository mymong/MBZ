//
//  NSString+DoubleQuotesString.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DoubleQuotesString)

- (NSString *)stringByAddingDoubleQuotesIfContainSpaces;

@end
