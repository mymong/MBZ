//
//  MbzApi+WebServiceSearch.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi+WebService.h"

@interface MbzApi (WebServiceSearch)

/**
 *  The Web Service search for MusicBrainz Entities.
 *
 *  @param type       Selects the index to be searched, artist, release, release-group, recording, work, label (track is supported but maps to recording)
 *  @param string     Query string.
 *  @param conditions Query conditions.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param completion Completion block to receive the response.
 */
- (void)search:(NSString *)type
        string:(NSString *)string
    conditions:(NSDictionary *)conditions
        offset:(NSNumber *)offset
         limit:(NSNumber *)limit
    completion:(MbzCompletion)completion;

/**
 *  Search annotations
 *
 *  @param string     The string without field.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param text       The content of the annotation.
 *  @param type       The entity type (artist, releasegroup, release, recording, work, label).
 *  @param name       The name of the entity.
 *  @param entity     The entity's MBID.
 *  @param completion Completion block to receive the response.
 */
- (void)searchAnnotation:(NSString *)string
                  offset:(NSNumber *)offset
                   limit:(NSNumber *)limit
                    text:(NSString *)text
                    type:(NSString *)type
                    name:(NSString *)name
                  entity:(NSString *)entity
              completion:(MbzCompletion)completion;

/**
 *  Search areaes
 *
 *  @param string     The string without field.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param aid        the area ID
 *  @param alias      the aliases/misspellings for this area
 *  @param area       area name
 *  @param begin      area begin date
 *  @param comment    disambugation comment
 *  @param end        area end date
 *  @param ended      area ended
 *  @param sortname   area sort name
 *  @param iso        area iso1, iso2 or iso3 codes
 *  @param iso1       area iso1 codes
 *  @param iso2       area iso3 codes
 *  @param iso3       area iso3 codes
 *  @param type       the aliases/misspellings for this label
 *  @param completion Completion block to receive the response.
 */
- (void)searchArea:(NSString *)string
            offset:(NSNumber *)offset
             limit:(NSNumber *)limit
               aid:(NSString *)aid
             alias:(NSString *)alias
              area:(NSString *)area
             begin:(NSString *)begin
           comment:(NSString *)comment
               end:(NSString *)end
             ended:(NSString *)ended
          sortname:(NSString *)sortname
               iso:(NSString *)iso
              iso1:(NSString *)iso1
              iso2:(NSString *)iso2
              iso3:(NSString *)iso3
              type:(NSString *)type
        completion:(MbzCompletion)completion;

/**
 *  Search artists
 *
 *  @param string       Artist search terms with no fields specified search the artist, sortname and alias fields.
 *  @param offset       Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit        An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param area         artist area
 *  @param beginarea    artist begin area
 *  @param endarea      artist end area
 *  @param arid         MBID of the artist
 *  @param artist       name of the artist
 *  @param artistaccent name of the artist with any accent characters retained
 *  @param alias        the aliases/misspellings for the artist
 *  @param begin        artist birth date/band founding date
 *  @param comment      artist comment to differentiate similar artists
 *  @param country      the two letter country code (http://www.iso.org/iso/home/standards/country_codes/iso-3166-1_decoding_table.htm) for the artist country or 'unknown'
 *  @param end          artist death date/band dissolution date
 *  @param ended        true if know ended even if do not know end date
 *  @param gender       gender of the artist (“male”, “female”, “other”)
 *  @param ipi          IPI code for the artist
 *  @param sortname     artist sortname
 *  @param tag          a tag applied to the artist
 *  @param type         artist type (“person”, “group”, "other" or “unknown”)
 *  @param completion   Completion block to receive the response.
 */
- (void)searchArtist:(NSString *)string
              offset:(NSNumber *)offset
               limit:(NSNumber *)limit
                area:(NSString *)area
           beginarea:(NSString *)beginarea
             endarea:(NSString *)endarea
                arid:(NSString *)arid
              artist:(NSString *)artist
        artistaccent:(NSString *)artistaccent
               alias:(NSString *)alias
               begin:(NSString *)begin
             comment:(NSString *)comment
             country:(NSString *)country
                 end:(NSString *)end
               ended:(NSString *)ended
              gender:(NSString *)gender
                 ipi:(NSString *)ipi
            sortname:(NSString *)sortname
                 tag:(NSString *)tag
                type:(NSString *)type
          completion:(MbzCompletion)completion;

/**
 *  Search CDStubs
 *
 *  @param string     Artist search terms with no fields specified search the artist, sortname and alias fields.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param artist     artist name
 *  @param title      release name
 *  @param barcode    release barcode
 *  @param comment    general comments about the release
 *  @param tracks     number of tracks on the CD stub
 *  @param discid     disc ID of the CD
 *  @param completion Completion block to receive the response.
 */
- (void)searchCDStub:(NSString *)string
              offset:(NSNumber *)offset
               limit:(NSNumber *)limit
              artist:(NSString *)artist
               title:(NSString *)title
             barcode:(NSString *)barcode
             comment:(NSString *)comment
              tracks:(NSString *)tracks
              discid:(NSString *)discid
          completion:(MbzCompletion)completion;

/**
 *  Search FreeDBs
 *
 *  @param string     Artist search terms with no fields specified search the artist, sortname and alias fields.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param artist     artist name
 *  @param title      release name
 *  @param discid     FreeDB disc id
 *  @param cat        FreeDB category
 *  @param year       year
 *  @param tracks     number of tracks in the release
 *  @param completion Completion block to receive the response.
 */
- (void)searchFreedb:(NSString *)string
              offset:(NSNumber *)offset
               limit:(NSNumber *)limit
              artist:(NSString *)artist
               title:(NSString *)title
              discid:(NSString *)discid
                 cat:(NSString *)cat
                year:(NSString *)year
              tracks:(NSString *)tracks
          completion:(MbzCompletion)completion;

/**
 *  Search Labels
 *
 *  @param string      Label search terms with no fields specified search the label, sortname and alias fields.
 *  @param offset      Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit       An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param alias       the aliases/misspellings for this label
 *  @param area        label area
 *  @param begin       label founding date
 *  @param code        label code (only the figures part, i.e. without "LC")
 *  @param comment     label comment to differentiate similar labels
 *  @param country     The two letter country code of the label country
 *  @param end         label dissolution date
 *  @param ended       true if know ended even if do not know end date
 *  @param ipi         ipi
 *  @param label       label name
 *  @param labelaccent name of the label with any accent characters retained
 *  @param laid        MBID of the label
 *  @param sortname    label sortname
 *  @param type        label type
 *  @param tag         folksonomy tag
 *  @param completion  Completion block to receive the response.
 */
- (void)searchLabel:(NSString *)string
             offset:(NSNumber *)offset
              limit:(NSNumber *)limit
              alias:(NSString *)alias
               area:(NSString *)area
              begin:(NSString *)begin
               code:(NSString *)code
            comment:(NSString *)comment
            country:(NSString *)country
                end:(NSString *)end
              ended:(NSString *)ended
                ipi:(NSString *)ipi
              label:(NSString *)label
        labelaccent:(NSString *)labelaccent
               laid:(NSString *)laid
           sortname:(NSString *)sortname
               type:(NSString *)type
                tag:(NSString *)tag
         completion:(MbzCompletion)completion;

/**
 *  Search Places
 *
 *  @param string     Place search terms with no fields specified search the place, alias, address and area fields.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param pid        the place ID
 *  @param address    the address of this place
 *  @param alias      the aliases/misspellings for this area
 *  @param area       area name
 *  @param begin      place begin date
 *  @param comment    disambiguation comment
 *  @param end        place end date
 *  @param ended      place ended
 *  @param latitude   place latitude
 *  @param longitude  place longitude
 *  @param type       the places type
 *  @param completion Completion block to receive the response.
 */
- (void)searchPlace:(NSString *)string
             offset:(NSNumber *)offset
              limit:(NSNumber *)limit
                pid:(NSString *)pid
            address:(NSString *)address
              alias:(NSString *)alias
               area:(NSString *)area
              begin:(NSString *)begin
            comment:(NSString *)comment
                end:(NSString *)end
              ended:(NSString *)ended
                lat:(NSString *)latitude
               long:(NSString *)longitude
               type:(NSString *)type
         completion:(MbzCompletion)completion;

/**
 *  Search Recordings
 *
 *  @param string           Recording search terms with no fields search the recording field only
 *  @param offset           Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit            An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param arid	            artist id
 *  @param artist	        artist name is name(s) as it appears on the recording
 *  @param artistname      	an artist on the recording, each artist added as a separate field
 *  @param creditname	    name credit on the recording, each artist added as a separate field
 *  @param comment	        recording disambiguation comment
 *  @param country	        recording release country
 *  @param date	            recording release date
 *  @param dur	            duration of track in milliseconds
 *  @param format	        recording release format
 *  @param isrc	            ISRC of recording
 *  @param number	        free text track number
 *  @param position	        the medium that the recording should be found on, first medium is position 1
 *  @param primarytype      primary type of the release group (album, single, ep, other)
 *  @param puid	            PUID of recording
 *  @param qdur	            quantized duration (duration / 2000)
 *  @param recording	    name of recording or a track associated with the recording
 *  @param recordingaccent	name of the recording with any accent characters retained
 *  @param reid	            release id
 *  @param release	        release name
 *  @param rgid	            release group id
 *  @param rid	            recording id
 *  @param secondarytype	secondary type of the release group (audiobook, compilation, interview, live, remix soundtrack, spokenword)
 *  @param status	        Release status (official, promotion, Bootleg, Pseudo-Release)
 *  @param tid	            track id
 *  @param tnum	            track number on medium
 *  @param tracks	        number of tracks in the medium on release
 *  @param tracksrelease	number of tracks on release as a whole
 *  @param tag	            folksonomy tag
 *  @param type	            type of the release group, old type mapping for when we did not have separate primary and secondary types or use standalone for standalone recordings
 *  @param video	        true to only show video tracks
 *  @param completion       Completion block to receive the response.
 */
- (void)searchRecording:(NSString *)string
                 offset:(NSNumber *)offset
                  limit:(NSNumber *)limit
                   arid:(NSString *)arid
                 artist:(NSString *)artist
             artistname:(NSString *)artistname
             creditname:(NSString *)creditname
                comment:(NSString *)comment
                country:(NSString *)country
                   date:(NSString *)date
                    dur:(NSString *)dur
                 format:(NSString *)format
                   isrc:(NSString *)isrc
                 number:(NSString *)number
               position:(NSString *)position
            primarytype:(NSString *)primarytype
                   puid:(NSString *)puid
                   qdur:(NSString *)qdur
              recording:(NSString *)recording
        recordingaccent:(NSString *)recordingaccent
                   reid:(NSString *)reid
                release:(NSString *)release
                   rgid:(NSString *)rgid
                    rid:(NSString *)rid
          secondarytype:(NSString *)secondarytype
                 status:(NSString *)status
                    tid:(NSString *)tid
                   tnum:(NSString *)tnum
                 tracks:(NSString *)tracks
          tracksrelease:(NSString *)tracksrelease
                    tag:(NSString *)tag
                   type:(NSString *)type
                  video:(NSString *)video
             completion:(MbzCompletion)completion;

/**
 *  Search Release Groups
 *
 *  @param string             Release group search terms with no fields search the releasegroup field only.
 *  @param offset             Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit              An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param arid               MBID of the release group’s artist
 *  @param artist             release group artist as it appears on the cover (Artist Credit)
 *  @param artistname         “real name” of any artist that is included in the release group’s artist credit
 *  @param comment            release group comment to differentiate similar release groups
 *  @param creditname         name of any artist in multi-artist credits, as it appears on the cover.
 *  @param primarytype        primary type of the release group (album, single, ep, other)
 *  @param rgid               MBID of the release group
 *  @param releasegroup       name of the release group
 *  @param releasegroupaccent name of the releasegroup with any accent characters retained
 *  @param releases	          number of releases in this release group
 *  @param release            name of a release that appears in the release group
 *  @param reid               MBID of a release that appears in the release group
 *  @param secondarytype      secondary type of the release group (audiobook, compilation, interview, live, remix soundtrack, spokenword)
 *  @param status             status of a release that appears within the release group
 *  @param tag                a tag that appears on the release group
 *  @param type               type of the release group, old type mapping for when we did not have separate primary and secondary types
 *  @param completion         Completion block to receive the response.
 */
- (void)searchReleaseGroup:(NSString *)string
                    offset:(NSNumber *)offset
                     limit:(NSNumber *)limit
                      arid:(NSString *)arid
                    artist:(NSString *)artist
                artistname:(NSString *)artistname
                   comment:(NSString *)comment
                creditname:(NSString *)creditname
               primarytype:(NSString *)primarytype
                      rgid:(NSString *)rgid
              releasegroup:(NSString *)releasegroup
        releasegroupaccent:(NSString *)releasegroupaccent
                  releases:(NSString *)releases
                   release:(NSString *)release
                      reid:(NSString *)reid
             secondarytype:(NSString *)secondarytype
                    status:(NSString *)status
                       tag:(NSString *)tag
                      type:(NSString *)type
                completion:(MbzCompletion)completion;

/*
 */
/**
 *  Search Releases
 *
 *  @param string        Release search terms with no fields search the release field only.
 *  @param offset        Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit         An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param arid          artist id
 *  @param artist        complete artist name(s) as it appears on the release
 *  @param artistname    an artist on the release, each artist added as a separate field
 *  @param asin          the Amazon ASIN for this release
 *  @param barcode       The barcode of this release
 *  @param catno         The catalog number for this release, can have multiples when major using an imprint
 *  @param comment       Disambiguation comment
 *  @param country       The two letter country code for the release country
 *  @param creditname    name credit on the release, each artist added as a separate field
 *  @param date          The release date (format: YYYY-MM-DD)
 *  @param discids       total number of cd ids over all mediums for the release
 *  @param discidsmedium number of cd ids for the release on a medium in the release
 *  @param format        release format
 *  @param laid          The label id for this release, a release can have multiples when major using an imprint
 *  @param label         The name of the label for this release, can have multiples when major using an imprint
 *  @param lang          The language for this release. Use the three character ISO 639 codes to search for a specific language. (e.g. lang:eng)
 *  @param mediums       number of mediums in the release
 *  @param primarytype   primary type of the release group (album, single, ep, other)
 *  @param puid          The release contains recordings with these puids
 *  @param quality       The quality of the release (low, normal, high)
 *  @param reid          release id
 *  @param release       release name
 *  @param releaseaccent name of the release with any accent characters retained
 *  @param rgid          release group id
 *  @param script        The 4 character script code (e.g. latn) used for this release
 *  @param secondarytype secondary type of the release group (audiobook, compilation, interview, live, remix, soundtrack, spokenword)
 *  @param status        release status (e.g official)
 *  @param tag           a tag that appears on the release
 *  @param tracks        total number of tracks over all mediums on the release
 *  @param tracksmedium  number of tracks on a medium in the release
 *  @param type          type of the release group, old type mapping for when we did not have separate primary and secondary types
 *  @param completion    Completion block to receive the response.
 */
- (void)searchRelease:(NSString *)string
               offset:(NSNumber *)offset
                limit:(NSNumber *)limit
                 arid:(NSString *)arid
               artist:(NSString *)artist
           artistname:(NSString *)artistname
                 asin:(NSString *)asin
              barcode:(NSString *)barcode
                catno:(NSString *)catno
              comment:(NSString *)comment
              country:(NSString *)country
           creditname:(NSString *)creditname
                 date:(NSString *)date
              discids:(NSString *)discids
        discidsmedium:(NSString *)discidsmedium
               format:(NSString *)format
                 laid:(NSString *)laid
                label:(NSString *)label
                 lang:(NSString *)lang
              mediums:(NSString *)mediums
          primarytype:(NSString *)primarytype
                 puid:(NSString *)puid
              quality:(NSString *)quality
                 reid:(NSString *)reid
              release:(NSString *)release
        releaseaccent:(NSString *)releaseaccent
                 rgid:(NSString *)rgid
               script:(NSString *)script
        secondarytype:(NSString *)secondarytype
               status:(NSString *)status
                  tag:(NSString *)tag
               tracks:(NSString *)tracks
         tracksmedium:(NSString *)tracksmedium
                 type:(NSString *)type
           completion:(MbzCompletion)completion;

/**
 *  Search Tags
 *
 *  @param string     String without field
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param tag        tag
 *  @param completion Completion block to receive the response.
 */
- (void)searchTag:(NSString *)string
           offset:(NSNumber *)offset
            limit:(NSNumber *)limit
              tag:(NSString *)tag
       completion:(MbzCompletion)completion;

/**
 *  Search Works
 *
 *  @param string     Work search terms with no fields specified search the work and alias fields.
 *  @param offset     Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param limit      An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param alias      the aliases/misspellings for this work
 *  @param arid       artist id
 *  @param artist     artist name, an artist in the context of a work is an artist-work relation such as composer or lyricist
 *  @param comment    disambiguation comment
 *  @param iswc       ISWC of work
 *  @param lang       Lyrics language of work
 *  @param tag        folksonomy tag
 *  @param type       work type
 *  @param wid        work id
 *  @param work       name of work
 *  @param workaccent name of the work with any accent characters retained
 *  @param completion Completion block to receive the response.
 */
- (void)searchWork:(NSString *)string
            offset:(NSNumber *)offset
             limit:(NSNumber *)limit
             alias:(NSString *)alias
              arid:(NSString *)arid
            artist:(NSString *)artist
           comment:(NSString *)comment
              iswc:(NSString *)iswc
              lang:(NSString *)lang
               tag:(NSString *)tag
              type:(NSString *)type
               wid:(NSString *)wid
              work:(NSString *)work
        workaccent:(NSString *)workaccent
        completion:(MbzCompletion)completion;

@end
