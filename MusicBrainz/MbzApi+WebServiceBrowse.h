//
//  MbzApi+WebServiceBrowse.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/7/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi+WebService.h"

@interface MbzApi (WebServiceBrowse)

- (void)             browse:(NSString *)entity
                     offset:(NSNumber *)offset
                      limit:(NSNumber *)limit
                 conditions:(NSDictionary *)conditions
                   includes:(NSArray *)includes
                      types:(NSArray *)types
                   statuses:(NSArray *)statuses
                 completion:(MbzCompletion)completion;

- (void)       browseAreaes:(NSNumber *)offset
                      limit:(NSNumber *)limit // max-num per page, default is 25, up to 100.
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)      browseArtists:(NSNumber *)offset
                      limit:(NSNumber *)limit
                       area:(NSString *)area
                  recording:(NSString *)recording
                    release:(NSString *)release
              release_group:(NSString *)release_group
                       work:(NSString *)work
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)       browseEvents:(NSNumber *)offset
                      limit:(NSNumber *)limit
                       area:(NSString *)area
                     artist:(NSString *)artist
                      place:(NSString *)place
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)  browseInstruments:(NSNumber *)offset
                      limit:(NSNumber *)limit
                    release:(NSString *)release
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)       browseLabels:(NSNumber *)offset
                      limit:(NSNumber *)limit
                       area:(NSString *)area
                    release:(NSString *)release
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)   browseRecordings:(NSNumber *)offset
                      limit:(NSNumber *)limit
                     artist:(NSString *)artist
                    release:(NSString *)release
     include_artist_credits:(BOOL)include_artist_credits
              include_isrcs:(BOOL)include_isrcs
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)     browseReleases:(NSNumber *)offset
                      limit:(NSNumber *)limit
                      types:(NSArray *)types
                   statuses:(NSArray *)statuses
                       area:(NSString *)area
                     artist:(NSString *)artist
                      label:(NSString *)label
                      track:(NSString *)track
               track_artist:(NSString *)track_artist
                  recording:(NSString *)recording
              release_group:(NSString *)release_group
     include_artist_credits:(BOOL)include_artist_credits
             include_labels:(BOOL)include_labels
         include_recordings:(BOOL)include_recordings
     include_release_groups:(BOOL)include_release_groups
              include_media:(BOOL)include_media
            include_discids:(BOOL)include_discids
              include_isrcs:(BOOL)include_isrcs
         include_annotation:(BOOL)include_annotation
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)browseReleaseGroups:(NSNumber *)offset
                      limit:(NSNumber *)limit
                      types:(NSArray *)types
                     artist:(NSString *)artist
                    release:(NSString *)release
     include_artist_credits:(BOOL)include_artist_credits
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)        browseWorks:(NSNumber *)offset
                      limit:(NSNumber *)limit
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

- (void)         browseUrls:(NSNumber *)offset
                      limit:(NSNumber *)limit
                   resource:(NSString *)resource
            include_aliases:(BOOL)include_aliases
         include_annotation:(BOOL)include_annotation
               include_tags:(BOOL)include_tags
            include_ratings:(BOOL)include_ratings
          include_user_tags:(BOOL)include_user_tags
       include_user_ratings:(BOOL)include_user_ratings
      include_relationships:(NSArray *)include_relationships
                 completion:(MbzCompletion)completion;

@end
