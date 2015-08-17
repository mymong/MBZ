//
//  MbzData.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MbzData : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic,readonly) NSDictionary *dictionary;
@property (nonatomic,readonly) NSString *mbid;
@end

@interface MbzData (ObjectForKeyCaster)
- (NSString *)stringObjectForKey:(NSString *)key;
- (NSNumber *)numberObjectForKey:(NSString *)key;
- (id)mbzdataObjectWithClassName:(NSString *)name forKey:(NSString *)key;
- (NSArray *)mbzdataArrayWithClassName:(NSString *)name forKey:(NSString *)key;
+ (NSArray *)mbzdataArrayWithDictionaryArray:(NSArray *)array;
@end
