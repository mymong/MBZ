//
//  MbzApi+WebService.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi.h"

/**
 *  Entities
 */
#define MbzEntity_Area         @"area"
#define MbzEntity_Artist       @"artist"
#define MbzEntity_Event        @"event"
#define MbzEntity_Instrument   @"instrument"
#define MbzEntity_Label        @"label"
#define MbzEntity_Recording    @"recording"
#define MbzEntity_Release      @"release"
#define MbzEntity_ReleaseGroup @"release-group"
#define MbzEntity_Series       @"series"
#define MbzEntity_Work         @"work"
#define MbzEntity_Url          @"url"

/**
 *  Subqueries
 */
#define MbzSubquery_Artists       @"artists"
#define MbzSubquery_Collections   @"collections"
#define MbzSubquery_Labels        @"labels"
#define MbzSubquery_Recordings    @"recordings"
#define MbzSubquery_Releases      @"releases"
#define MbzSubquery_ReleaseGroups @"release-groups"
#define MbzSubquery_Works         @"works"

/**
 *  Arguments
 */
#define MbzArgument_Discids        @"discids"
#define MbzArgument_Media          @"media"
#define MbzArgument_Isrcs          @"isrcs"
#define MbzArgument_ArtistCredits  @"artist-credits"
#define MbzArgument_VariousArtists @"various-artists"
#define MbzArgument_Aliases        @"aliases"
#define MbzArgument_Annotation     @"annotation"
#define MbzArgument_Tags           @"tags"
#define MbzArgument_Ratings        @"ratings"
#define MbzArgument_UserTags       @"user-tags"
#define MbzArgument_UserRatings    @"user-ratings"

/**
 *  Relationships
 */
#define MbzRelationship_Area           @"area-rels"
#define MbzRelationship_Artist         @"artist-rels"
#define MbzRelationship_Event          @"event-rels"
#define MbzRelationship_Instrument     @"instrument-rels"
#define MbzRelationship_Label          @"label-rels"
#define MbzRelationship_Place          @"place-rels"
#define MbzRelationship_Recording      @"recording-rels"
#define MbzRelationship_Release        @"release-rels"
#define MbzRelationship_ReleaseGroup   @"release-group-rels"
#define MbzRelationship_Series         @"series-rels"
#define MbzRelationship_Url            @"url-rels"
#define MbzRelationship_Work           @"work-rels"
#define MbzRelationship_RecordingLevel @"recording-level-rels"
#define MbzRelationship_WorkLevel      @"work-level-rels"

/**
 *  Release Types
 */
#define MbzReleaseType_Nat          @"nat"
#define MbzReleaseType_Album        @"album"
#define MbzReleaseType_Single       @"single"
#define MbzReleaseType_Ep           @"ep"
#define MbzReleaseType_Compilation  @"compilation"
#define MbzReleaseType_Soundtrack   @"soundtrack"
#define MbzReleaseType_Spokenword   @"spokenword"
#define MbzReleaseType_Interview    @"interview"
#define MbzReleaseType_Audiobook    @"audiobook"
#define MbzReleaseType_Live         @"live"
#define MbzReleaseType_Remix        @"remix"
#define MbzReleaseType_Other        @"other"

/**
 *  Release Statuses
 */
#define MbzReleaseStatus_Official      @"official"
#define MbzReleaseStatus_Promotion     @"promotion"
#define MbzReleaseStatus_Bootleg       @"bootleg"
#define MbzReleaseStatus_PseudoRelease @"pseudo-release"

/**
 *  <b> Web Service </b>
 *
 *  The web service discussed in this document is an interface to the MusicBrainz Database. It is aimed at developers of media players, CD rippers, taggers, and other applications requiring music metadata. The service's architecture follows the REST design principles. Interaction with the web service is done using HTTP and all content is served in a simple but flexible XML format. The same web service is also available in JSON format.
 *
 *  The web service root URL is http://musicbrainz.org/ws/2/.
 *
 *  This page documents version 2 of our XML web service. Version 1 has been deprecated, but its documentation can still be referenced. Non-commercial use of this web service is free; please contact us if you would like to use this service commercially.
 *
 *  We have 11 resources on our web service which represent core entities in our database:
 *  <pre>area, artist, event, instrument, label, recording, release, release-group, series, work, url</pre>
 *
 *  We also provide a web service interface for the following non-core resources:
 *  <pre>rating, tag, collection</pre>
 *
 *  And we allow you to perform lookups based on other unique identifiers with these resources:
 *  <pre>discid, isrc, iswc</pre>
 *
 *  On each entity resource, you can perform three different GET requests:
 *  <pre>lookup: /<ENTITY>/<MBID>?inc=<INC>
 *  <br/>browse: /<ENTITY>?<ENTITY>=<MBID>&limit=<LIMIT>&offset=<OFFSET>&inc=<INC>
 *  <br/>search: /<ENTITY>?query=<QUERY>&limit=<LIMIT>&offset=<OFFSET>
 *  </pre>
 *
 *  ... except that search is not implemented for URL entities at this time.
 *
 *  Of these:
 *  <li> Lookups, Non-MBID lookups and Browse requests are documented in following sections. </li>
 */
@interface MbzApi (WebService)

@end
