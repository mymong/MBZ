//
//  MbzApi+WebServiceLookup.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/7/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi+WebService.h"

@interface MbzApi (WebServiceLookup)

/**
 *  Lookup an entity with given id.
 *
 *  <i>lookup: /<ENTITY>/<MBID>?inc=<INC></i>
 *
 *  Note that the number of linked entities returned is always limited to 25, if you need the remaining results, you will have to perform a browse request.
 *
 *  Linked entities are always ordered alphabetically by gid.
 *
 *  @param entity        The entity type to lookup.
 *  @param mbid          The MusicBrainz ID for the lookuping entity.
 *  @param subqueries    The subqueries pameteter allows you to request more information to be included about the entity.
 *                       <table>
 *                       <tr><td><i>Requested Entity</i></td><td><i>Supported Subqueries</i></td></tr>
 *                       <tr><td>area</td><td>-</td></tr>
 *                       <tr><td>artist</td><td>recordings, releases, release-groups, works</td></tr>
 *                       <tr><td>event</td><td>-</td></tr>
 *                       <tr><td>instrument</td><td>-</td></tr>
 *                       <tr><td>label</td><td>releases</td></tr>
 *                       <tr><td>recording</td><td>artists, releases</td></tr>
 *                       <tr><td>release</td><td>artists, collections, labels, recordings, release-groups</td></tr>
 *                       <tr><td>release-group</td><td>artists, releases</td></tr>
 *                       <tr><td>work</td><td>-</td></tr>
 *                       <tr><td>work</td><td>-</td></tr>
 *                       </table>
 *                       To include more than one subquery in a single request, separate the arguments to <code style="background:#ddd">inc=</code> with a + (plus sign), like <code style="background:#ddd">inc=recordings+labels</code>.
 *  @param arguments     The arguments specify how much of the data about the linked entities should be included.
 *                       <table>
 *                       <tr><td><i>Arguments</i></td><td><i>Includes</i></td></tr>
 *                       <tr><td>discids</td>
 *                           <td>include discids for all media in the releases</td></tr>
 *                       <tr><td>media</td>
 *                           <td>include media for all releases, this includes the # of tracks on each medium and its format.</td>
 *                       <tr><td>isrcs</td>
 *                           <td>include isrcs for all recordings</td></tr>
 *                       <tr><td>artist-credits</td>
 *                           <td>include artists credits for all releases and recordings</td></tr>
 *                       <tr><td>various-artists</td>
 *                           <td>include only those releases where the artist appears on one of the tracks, but not in the artist credit for the release itself (this is only valid on a /ws/2/artist?inc=releases request).</td></tr>
 *                       <tr><td colspan="2">
 *                           </td>include artist, label, area or work aliases; treat these as a set, as they are not deliberately ordered</tr>
 *                       <tr><td>aliases</td>
 *                           <td>include annotation</td></tr>
 *                       <tr><td>annotation</td>
 *                           <td>include tags and/or ratings for the entity</td></tr>
 *                       <tr><td>tags, ratings</td>
 *                           <td></td></tr>
 *                       <tr><td>user-tags, user-ratings</td>
 *                           <td>same as above, but only return the tags and/or ratings submitted by the specified user</td></tr>
 *                       </table>
 *                       Requests with user-tags or user-ratings <b style="background:#ddd">require authentication</b>. You can authenticate using HTTP Digest, use the same username and password used to access the main http://musicbrainz.org website.
 *  @param relationships Relationships to load for the requested entity.
 *                       <table>
 *                       <tr><td><i>Requested Entity</i></td><td><i>Supported Relationships</i></td></tr>
 *                       <tr><td colspan="2"><small><i>Relationships are available for all entity types via inc parameters.</i></small></td></tr>
 *                       <tr><td><all></td>
 *                           <td>area-rels<br/>
 *                               artist-rels<br/>
 *                               event-rels<br/>
 *                               instrument-rels<br/>
 *                               label-rels<br/>
 *                               place-rels<br/>
 *                               recording-rels<br/>
 *                               release-rels<br/>
 *                               release-group-rels<br/>
 *                               series-rels<br/>
 *                               url-rels<br/>
 *                               work-rels</td></tr>
 *                       <tr><td colspan="2"><small><i>By default, it will only load relationship for the requested entity. When you are loading a release, you might want to load relationships for all its recordings and also works linked to the recordings. This is useful to get full release credits. There are additional arguments that can be used only on release requests and allow you to specify for which entities to load relationships:</i></small></td></tr>
 *                       <tr><td>release</td>
 *                           <td>recording-level-rels<br/>
 *                               work-level-rels</td></tr>
 *                       </table>
 *                       By default, it will only load relationship for the requested entity. When you are loading a release, you might want to load relationships for all its recordings and also works linked to the recordings. This is useful to get full release credits. There are additional arguments that can be used only on release requests and allow you to specify for which entities to load relationships:
 *
 *  @param type          = {nat, album, single, ep, compilation, soundtrack, spokenword, interview, audiobook, live, remix, other}<p/>
 *                       The release type to filter included release-groups or releases.<p/>
 *                       All lookups which include release-groups or releases allow a <code style="background:#ddd">type=</code> argument.
 *  @param status        = {official, promotion, bootleg, pseudo-release}<p/>
 *                       The release status to fileter included releases.<p/>
 *                       All lookups which include releases allow a <code style="background:#ddd">status=</code> argument.
 *  @param completion    Completion block to receive the response.
 */
- (void)lookupEntity:(NSString *)entity mbid:(NSString *)mbid subqueries:(NSArray *)subqueries arguments:(NSArray *)arguments relationships:(NSArray *)relationships type:(NSString *)type status:(NSString *)status completion:(MbzCompletion)completion;

/**
 *  Non-MBID Lookups
 *
 *  Instead of MBIDs, you can also perform lookups using several other unique identifiers. However, because clashes sometimes occur, each of these lookups return a list of entities (there is no limit, all linked entities will be returned, paging is not supported).
 *
 *  <b> discid </b>
 *
 *  <pre>lookup: /discid/<discid>?inc=<INC>&toc=<TOC></pre>
 *
 *  A discid lookup returns a list of associated releases, the 'inc=' arguments supported are identical to a lookup request for a release.
 *
 *  If there are no matching releases in MusicBrainz, but a matching CDStub exists, it will be returned. This is the default behaviour. If you do not want to see CD stubs, pass 'cdstubs=no.' CD stubs are contained within a <cdstub> element, and otherwise have the same form as a release. Note that CD stubs do not have artist credits, just artists.
 *
 *  If you provide the "toc" query parameter, and if the provided discid is not known by MusicBrainz, a fuzzy lookup will done to find matching MusicBrainz releases. Note that if CD stubs are found this will not happen. If you do want TOC fuzzy lookup, but not cdstub searching, specify "cdstubs=no". For example:
 *
 *  <pre>/ws/2/discid/I5l9cCSFccLKFEKS.7wqSZAorPU-?toc=1+12+267257+150+22767+41887+58317+72102+91375+104652+115380+132165+143932+159870+174597</pre>
 *
 *  Will look for the disc id first, and if it fails, will try to find tracklists that are within a similar distance to the one provided.
 *
 *  It's also possible to perform a fuzzy toc search without a discid. Passing "-" (or any invalid placeholder) as the discid will cause it to be ignored if a valid toc is present:
 *
 *  <pre>/ws/2/discid/-?toc=1+12+267257+150+22767+41887+58317+72102+91375+104652+115380+132165+143932+159870+174597</pre>
 *
 *  By default, fuzzy toc searches only return mediums whose format is set to "CD." If you want to search all mediums regardless of format, add 'media-format=all' to the query:
 *
 *  <pre>/ws/2/discid/-?toc=1+12+267257+150+22767+41887+58317+72102+91375+104652+115380+132165+143932+159870+174597&media-format=all</pre>
 *
 *  The toc consists of the following:
 *  <li>First track (always 1)</li>
 *  <li>total number of tracks</li>
 *  <li>sector offset of the leadout (end of the disc)</li>
 *  <li>a list of sector offsets for each track, beginning with track 1 (generally 150 sectors)</li>
 *
 *  @param discid     <#discid description#>
 *  @param inc        <#inc description#>
 *  @param toc        <#toc description#>
 *  @param completion <#completion description#>
 */
- (void)lookupDiscid:(NSString *)discid inc:(NSArray *)inc toc:(NSArray *)toc completion:(MbzCompletion)completion;

/**
 *  Non-MBID Lookups
 *
 *  Instead of MBIDs, you can also perform lookups using several other unique identifiers. However, because clashes sometimes occur, each of these lookups return a list of entities (there is no limit, all linked entities will be returned, paging is not supported).
 *
 *  <b> isrc </b>
 *
 *  <pre>lookup: /isrc/<isrc>?inc=<INC></pre>
 *
 *  isrc lookups return a list of recordings, the 'inc=' arguments supported are identical to a lookup request for a recording.
 *
 *  @param isrc       <#isrc description#>
 *  @param inc        <#inc description#>
 *  @param completion <#completion description#>
 */
- (void)lookupIsrc:(NSString *)isrc inc:(NSArray *)inc completion:(MbzCompletion)completion;

/**
 *  Non-MBID Lookups
 *
 *  Instead of MBIDs, you can also perform lookups using several other unique identifiers. However, because clashes sometimes occur, each of these lookups return a list of entities (there is no limit, all linked entities will be returned, paging is not supported).
 *
 *  <b> iswc </b>
 *
 *  <pre>lookup: /iswc/<iswc>?inc=<INC></pre>
 *
 *  An iswc lookup returns a list of works, the 'inc=' arguments supported are identical to a lookup request for a work.
 *
 *  @param iswc       <#iswc description#>
 *  @param inc        <#inc description#>
 *  @param completion <#completion description#>
 */
- (void)lookupIswc:(NSString *)iswc inc:(NSArray *)inc completion:(MbzCompletion)completion;

@end
