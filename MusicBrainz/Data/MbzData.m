//
//  MbzData.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzData.h"

@implementation MbzData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _dictionary = dictionary;
    }
    return self;
}

- (NSString *)mbid {
    return self.dictionary[@"id"];
}

@end

@implementation MbzData (ObjectForKeyCaster)

- (NSString *)stringObjectForKey:(NSString *)key {
    id value = _dictionary[key];
    if ([value isKindOfClass:NSString.class]) {
        return value;
    }
    if ([value isKindOfClass:NSNumber.class]) {
        return [NSString stringWithFormat:@"%@", value];
    }
    return nil;
}

- (NSNumber *)numberObjectForKey:(NSString *)key {
    id value = _dictionary[key];
    if ([value isKindOfClass:NSNumber.class]) {
        return value;
    }
    return nil;
}

- (id)mbzdataObjectWithClassName:(NSString *)name forKey:(NSString *)key {
    id value = _dictionary[key];
    if ([value isKindOfClass:NSDictionary.class]) {
        Class cls = NSClassFromString(name);
        if (cls) {
            return [[cls alloc] initWithDictionary:value];
        }
    }
    return nil;
}

- (NSArray *)mbzdataArrayWithClassName:(NSString *)name forKey:(NSString *)key {
    NSArray *value = _dictionary[key];
    Class cls = NSClassFromString(name);
    if ([value isKindOfClass:NSArray.class] && [cls isSubclassOfClass:MbzData.class]) {
        return [cls mbzdataArrayWithDictionaryArray:value];
    }
    return nil;
}

+ (NSArray *)mbzdataArrayWithDictionaryArray:(NSArray *)array {
    if (array) {
        NSMutableArray *marray = [NSMutableArray new];
        for (NSDictionary *dic in array) {
            if ([dic isKindOfClass:NSDictionary.class]) {
                id item = [[self alloc] initWithDictionary:dic];
                if (item) {
                    [marray addObject:item];
                }
            }
        }
        return marray;
    }
    return nil;
}

@end
