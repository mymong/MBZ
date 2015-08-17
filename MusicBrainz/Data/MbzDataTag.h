//
//  MbzDataTag.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzData.h"

@interface MbzDataTag : MbzData
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSNumber *count;
@end
