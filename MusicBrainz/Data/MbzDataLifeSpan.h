//
//  MbzDataLifeSpan.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzData.h"

@interface MbzDataLifeSpan : MbzData
@property (nonatomic,readonly) NSString *begin;
@property (nonatomic,readonly) NSString *end;
@property (nonatomic,readonly) NSNumber *ended;
@end

@interface MbzDataLifeSpan (Show)
- (NSString *)showString;
@end