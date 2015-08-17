//
//  MbzDataAliase.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzData.h"

@interface MbzDataAliase : MbzData
@property (nonatomic,readonly) NSString *begin_date;
@property (nonatomic,readonly) NSString *end_date;
@property (nonatomic,readonly) NSString *local;
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *primary;
@property (nonatomic,readonly) NSString *sort_name;
@property (nonatomic,readonly) NSString *type;
@end
