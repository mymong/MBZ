//
//  MbzDataArtist.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/20/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzDataArtist.h"

@implementation MbzDataArtist

- (NSString *)name {
    return [self stringObjectForKey:@"name"];
}

- (NSString *)disambiguation {
    return [self stringObjectForKey:@"disambiguation"];
}

- (NSString *)sort_name {
    return [self stringObjectForKey:@"sort-name"];
}

- (NSString *)score {
    return [self stringObjectForKey:@"score"];
}

- (NSString *)country {
    return [self stringObjectForKey:@"country"];
}

- (NSString *)type {
    return [self stringObjectForKey:@"type"];
}

- (NSString *)gender {
    return [self stringObjectForKey:@"gender"];
}

- (MbzDataArea *)area {
    return [self mbzdataObjectWithClassName:@"MbzDataArea" forKey:@"area"];
}

- (MbzDataArea *)begin_area {
    return [self mbzdataObjectWithClassName:@"MbzDataArea" forKey:@"begin-area"];
}

- (MbzDataLifeSpan *)life_span {
    return [self mbzdataObjectWithClassName:@"MbzDataLifeSpan" forKey:@"life-span"];
}

- (NSArray *)aliases {
    return [self mbzdataArrayWithClassName:@"MbzDataAliase" forKey:@"aliases"];
}

- (NSArray *)tags {
    return [self mbzdataArrayWithClassName:@"MbzDataTag" forKey:@"tags"];
}

@end
