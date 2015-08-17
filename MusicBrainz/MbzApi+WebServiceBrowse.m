//
//  MbzApi+WebServiceBrowse.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/7/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi+WebServiceBrowse.h"

@interface NSMutableArray (MbzIncludeArguments)
- (void)setInclude_aliases:(BOOL)include_aliases;
- (void)setInclude_annotation:(BOOL)include_annotation;
- (void)setInclude_artist_credits:(BOOL)include_artist_credits;
- (void)setInclude_discids:(BOOL)include_discids;
- (void)setInclude_isrcs:(BOOL)include_isrcs;
- (void)setInclude_labels:(BOOL)include_labels;
- (void)setInclude_media:(BOOL)include_media;
- (void)setInclude_recordings:(BOOL)include_recordings;
- (void)setInclude_ratings:(BOOL)include_ratings;
- (void)setInclude_release_groups:(BOOL)include_release_groups;
- (void)setInclude_tags:(BOOL)include_tags;
- (void)setInclude_user_ratings:(BOOL)include_user_ratings;
- (void)setInclude_user_tags:(BOOL)include_user_tags;
- (void)setInclude_relationships:(NSArray *)include_relationships;
@end

@implementation MbzApi (WebServiceBrowse)

- (void)browse:(NSString *)entity offset:(NSNumber *)offset limit:(NSNumber *)limit conditions:(NSDictionary *)conditions includes:(NSArray *)includes types:(NSArray *)types statuses:(NSArray *)statuses completion:(MbzCompletion)completion
{
    NSParameterAssert(entity);
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    if (offset) {
        parameters[@"offset"] = [NSString stringWithFormat:@"%d", offset.intValue];
    }
    if (limit) {
        parameters[@"limit"] = [NSString stringWithFormat:@"%d", limit.intValue];
    }
    if (conditions.count > 0) {
        [parameters addEntriesFromDictionary:conditions];
    }
    if (includes.count > 0) {
        parameters[@"inc"] = [includes componentsJoinedByString:@"+"];
    }
    if (types.count > 0) {
        parameters[@"type"] = [types componentsJoinedByString:@"|"];
    }
    if (statuses.count > 0) {
        parameters[@"status"] = [statuses componentsJoinedByString:@"|"];
    }
    
    NSString *path = [NSString stringWithFormat:@"/ws/2/%@", entity];
    if (0 == parameters.count) {
        parameters = nil;
    }
    
    [self send:@"GET" path:path parameters:parameters headers:nil completion:completion];
}

- (void)browseAreaes:(NSNumber *)offset limit:(NSNumber *)limit include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"area" offset:offset limit:limit conditions:nil includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseArtists:(NSNumber *)offset limit:(NSNumber *)limit area:(NSString *)area recording:(NSString *)recording release:(NSString *)release release_group:(NSString *)release_group work:(NSString *)work include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (area) {
        conditions[@"area"] = area;
    }
    if (recording) {
        conditions[@"recording"] = recording;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    if (release_group) {
        conditions[@"release-group"] = release_group;
    }
    if (work) {
        conditions[@"work"] = work;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"artist" offset:offset limit:limit conditions:conditions includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseEvents:(NSNumber *)offset limit:(NSNumber *)limit area:(NSString *)area artist:(NSString *)artist place:(NSString *)place include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (area) {
        conditions[@"area"] = area;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (place) {
        conditions[@"place"] = place;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"event" offset:offset limit:limit conditions:conditions includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseInstruments:(NSNumber *)offset limit:(NSNumber *)limit release:(NSString *)release include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (release) {
        conditions[@"release"] = release;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"instrument" offset:offset limit:limit conditions:conditions includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseLabels:(NSNumber *)offset limit:(NSNumber *)limit area:(NSString *)area release:(NSString *)release include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (area) {
        conditions[@"area"] = area;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"label" offset:offset limit:limit conditions:conditions includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseRecordings:(NSNumber *)offset limit:(NSNumber *)limit artist:(NSString *)artist release:(NSString *)release include_artist_credits:(BOOL)include_artist_credits include_isrcs:(BOOL)include_isrcs include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_artist_credits = include_artist_credits;
    includes.include_isrcs = include_isrcs;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"recording" offset:offset limit:limit conditions:conditions includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseReleases:(NSNumber *)offset limit:(NSNumber *)limit types:(NSArray *)types statuses:(NSArray *)statuses area:(NSString *)area artist:(NSString *)artist label:(NSString *)label track:(NSString *)track track_artist:(NSString *)track_artist recording:(NSString *)recording release_group:(NSString *)release_group include_artist_credits:(BOOL)include_artist_credits include_labels:(BOOL)include_labels include_recordings:(BOOL)include_recordings include_release_groups:(BOOL)include_release_groups include_media:(BOOL)include_media include_discids:(BOOL)include_discids include_isrcs:(BOOL)include_isrcs include_annotation:(BOOL)include_annotation include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSParameterAssert(types || statuses);
    
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (area) {
        conditions[@"area"] = area;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (label) {
        conditions[@"label"] = label;
    }
    if (track) {
        conditions[@"track"] = track;
    }
    if (track_artist) {
        conditions[@"track-artist"] = track_artist;
    }
    if (recording) {
        conditions[@"recording"] = recording;
    }
    if (release_group) {
        conditions[@"release-group"] = release_group;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_artist_credits = include_artist_credits;
    includes.include_labels = include_labels;
    includes.include_recordings = include_recordings;
    includes.include_annotation = include_annotation;
    includes.include_release_groups = include_release_groups;
    includes.include_media = include_media;
    includes.include_discids = include_discids;
    includes.include_isrcs = include_isrcs;
    includes.include_relationships = include_relationships;
    
    [self browse:@"release" offset:offset limit:limit conditions:conditions includes:includes types:types statuses:statuses completion:completion];
}

- (void)browseReleaseGroups:(NSNumber *)offset limit:(NSNumber *)limit types:(NSArray *)types artist:(NSString *)artist release:(NSString *)release include_artist_credits:(BOOL)include_artist_credits include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSParameterAssert(types);
    
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_artist_credits = include_artist_credits;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"release-group" offset:offset limit:limit conditions:conditions includes:includes types:types statuses:nil completion:completion];
}

- (void)browseWorks:(NSNumber *)offset limit:(NSNumber *)limit include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"work" offset:offset limit:limit conditions:nil includes:includes types:nil statuses:nil completion:completion];
}

- (void)browseUrls:(NSNumber *)offset limit:(NSNumber *)limit resource:(NSString *)resource include_aliases:(BOOL)include_aliases include_annotation:(BOOL)include_annotation include_tags:(BOOL)include_tags include_ratings:(BOOL)include_ratings include_user_tags:(BOOL)include_user_tags include_user_ratings:(BOOL)include_user_ratings include_relationships:(NSArray *)include_relationships completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (resource) {
        conditions[@"resource"] = resource;
    }
    
    NSMutableArray *includes = [NSMutableArray new];
    includes.include_aliases = include_aliases;
    includes.include_annotation = include_annotation;
    includes.include_tags = include_tags;
    includes.include_ratings = include_ratings;
    includes.include_user_tags = include_user_tags;
    includes.include_user_ratings = include_user_ratings;
    includes.include_relationships = include_relationships;
    
    [self browse:@"url" offset:offset limit:limit conditions:conditions includes:includes types:nil statuses:nil completion:completion];
}

@end

@implementation NSMutableArray (MbzIncludeArguments)
- (void)setInclude_aliases:(BOOL)include_aliases {
    if (include_aliases) {
        [self addObject:@"aliases"];
    }
}
- (void)setInclude_annotation:(BOOL)include_annotation {
    if (include_annotation) {
        [self addObject:@"annotation"];
    }
}
- (void)setInclude_artist_credits:(BOOL)include_artist_credits {
    if (include_artist_credits) {
        [self addObject:@"artist-credits"];
    }
}
- (void)setInclude_discids:(BOOL)include_discids {
    if (include_discids) {
        [self addObject:@"discids"];
    }
}
- (void)setInclude_isrcs:(BOOL)include_isrcs {
    if (include_isrcs) {
        [self addObject:@"isrcs"];
    }
}
- (void)setInclude_labels:(BOOL)include_labels {
    if (include_labels) {
        [self addObject:@"labels"];
    }
}
- (void)setInclude_media:(BOOL)include_media {
    if (include_media) {
        [self addObject:@"media"];
    }
}
- (void)setInclude_recordings:(BOOL)include_recordings {
    if (include_recordings) {
        [self addObject:@"recordings"];
    }
}
- (void)setInclude_ratings:(BOOL)include_ratings {
    if (include_ratings) {
        [self addObject:@"ratings"];
    }
}
- (void)setInclude_release_groups:(BOOL)include_release_groups {
    if (include_release_groups) {
        [self addObject:@"release-groups"];
    }
}
- (void)setInclude_tags:(BOOL)include_tags {
    if (include_tags) {
        [self addObject:@"tags"];
    }
}
- (void)setInclude_user_ratings:(BOOL)include_user_ratings {
    if (include_user_ratings) {
        [self addObject:@"user-ratings"];
    }
}
- (void)setInclude_user_tags:(BOOL)include_user_tags {
    if (include_user_tags) {
        [self addObject:@"user-tags"];
    }
}
- (void)setInclude_relationships:(NSArray *)include_relationships {
    if (include_relationships.count > 0) {
        [self addObjectsFromArray:include_relationships];
    }
}
@end
