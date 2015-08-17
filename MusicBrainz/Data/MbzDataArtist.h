//
//  MbzDataArtist.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzData.h"

@class MbzDataArea;
@class MbzDataLifeSpan;

@interface MbzDataArtist : MbzData
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *disambiguation;
@property (nonatomic,readonly) NSString *sort_name;
@property (nonatomic,readonly) NSString *score;
@property (nonatomic,readonly) NSString *country;
@property (nonatomic,readonly) NSString *type;
@property (nonatomic,readonly) NSString *gender;
@property (nonatomic,readonly) MbzDataArea *area;
@property (nonatomic,readonly) MbzDataArea *begin_area;
@property (nonatomic,readonly) MbzDataLifeSpan *life_span;
@property (nonatomic,readonly) NSArray/*[MbzDataAliase]*/ *aliases;
@property (nonatomic,readonly) NSArray/*[MbzDataTag]*/ *tags;
@end
