//
//  MbzApi+WebServiceSearch.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi+WebServiceSearch.h"
#import "NSString+DoubleQuotesString.h"

@implementation MbzApi (WebServiceSearch)

/**
 *  The Web Service search for MusicBrainz Entities.
 *
 *  @param type       Selects the index to be searched, artist, release, release-group, recording, work, label (track is supported but maps to recording).
 *  @param query      Lucene search query, this is mandatory.
 *  @param offset     An integer value defining how many entries should be returned. Only values between 1 and 100 (both inclusive) are allowed. If not given, this defaults to 25.
 *  @param limit      Return search results starting at a given offset. Used for paging through more than one page of results.
 *  @param completion Completion block to receive the response.
 */
- (void)search:(NSString *)type query:(NSString *)query offset:(NSNumber *)offset limit:(NSNumber *)limit completion:(MbzCompletion)completion
{
    NSParameterAssert(type && query);
    
    NSString *path = [NSString stringWithFormat:@"/ws/2/%@", type];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"fmt"] = @"json";
    
    if (query) {
        parameters[@"query"] = query;
    }
    
    if (offset) {
        parameters[@"offset"] = offset.description;
    }
    
    if (limit) {
        parameters[@"limit"] = limit.description;
    }
    
    [self send:@"GET" path:path parameters:parameters headers:nil completion:completion];
}

- (void)search:(NSString *)type string:(NSString *)string conditions:(NSDictionary *)conditions offset:(NSNumber *)offset limit:(NSNumber *)limit completion:(MbzCompletion)completion
{
    NSParameterAssert(type && (string || conditions.count > 0));
    
    NSMutableArray *array = [NSMutableArray new];
    if (string) {
        [array addObject:string.stringByAddingDoubleQuotesIfContainSpaces];
    }
    [conditions enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSParameterAssert([obj isKindOfClass:NSString.class]);
        [array addObject:[NSString stringWithFormat:@"%@:%@", key, obj.stringByAddingDoubleQuotesIfContainSpaces]];
    }];
    NSString *query = [array componentsJoinedByString:@" AND "];
    
    [self search:type query:query offset:offset limit:limit completion:completion];
}

- (void)searchAnnotation:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit text:(NSString *)text type:(NSString *)type name:(NSString *)name entity:(NSString *)entity completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (text) {
        conditions[@"text"] = text;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    if (name) {
        conditions[@"name"] = name;
    }
    if (entity) {
        conditions[@"entity"] = entity;
    }
    
    [self search:@"annotation" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchArea:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit aid:(NSString *)aid alias:(NSString *)alias area:(NSString *)area begin:(NSString *)begin comment:(NSString *)comment end:(NSString *)end ended:(NSString *)ended sortname:(NSString *)sortname iso:(NSString *)iso iso1:(NSString *)iso1 iso2:(NSString *)iso2 iso3:(NSString *)iso3 type:(NSString *)type completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (aid) {
        conditions[@"aid"] = aid;
    }
    if (alias) {
        conditions[@"alias"] = alias;
    }
    if (area) {
        conditions[@"area"] = area;
    }
    if (begin) {
        conditions[@"begin"] = begin;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (end) {
        conditions[@"end"] = end;
    }
    if (ended) {
        conditions[@"ended"] = ended;
    }
    if (sortname) {
        conditions[@"sortname"] = sortname;
    }
    if (iso) {
        conditions[@"iso"] = iso;
    }
    if (iso1) {
        conditions[@"iso1"] = iso1;
    }
    if (iso2) {
        conditions[@"iso2"] = iso2;
    }
    if (iso3) {
        conditions[@"iso3"] = iso3;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    
    [self search:@"area" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchArtist:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit area:(NSString *)area beginarea:(NSString *)beginarea endarea:(NSString *)endarea arid:(NSString *)arid artist:(NSString *)artist artistaccent:(NSString *)artistaccent alias:(NSString *)alias begin:(NSString *)begin comment:(NSString *)comment country:(NSString *)country end:(NSString *)end ended:(NSString *)ended gender:(NSString *)gender ipi:(NSString *)ipi sortname:(NSString *)sortname tag:(NSString *)tag type:(NSString *)type completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (area) {
        conditions[@"area"] = area;
    }
    if (beginarea) {
        conditions[@"beginarea"] = beginarea;
    }
    if (endarea) {
        conditions[@"endarea"] = endarea;
    }
    if (arid) {
        conditions[@"arid"] = arid;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (artistaccent) {
        conditions[@"artistaccent"] = artistaccent;
    }
    if (alias) {
        conditions[@"alias"] = alias;
    }
    if (begin) {
        conditions[@"begin"] = begin;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (country) {
        conditions[@"country"] = country;
    }
    if (end) {
        conditions[@"end"] = end;
    }
    if (ended) {
        conditions[@"ended"] = ended;
    }
    if (gender) {
        conditions[@"gender"] = gender;
    }
    if (ipi) {
        conditions[@"ipi"] = ipi;
    }
    if (sortname) {
        conditions[@"sortname"] = sortname;
    }
    if (tag) {
        conditions[@"tag"] = tag;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    
    [self search:@"artist" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchCDStub:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit artist:(NSString *)artist title:(NSString *)title barcode:(NSString *)barcode comment:(NSString *)comment tracks:(NSString *)tracks discid:(NSString *)discid completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (title) {
        conditions[@"title"] = title;
    }
    if (barcode) {
        conditions[@"barcode"] = barcode;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (tracks) {
        conditions[@"tracks"] = tracks;
    }
    if (discid) {
        conditions[@"discid"] = discid;
    }
    
    [self search:@"cdstub" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchFreedb:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit artist:(NSString *)artist title:(NSString *)title discid:(NSString *)discid cat:(NSString *)cat year:(NSString *)year tracks:(NSString *)tracks completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (title) {
        conditions[@"title"] = title;
    }
    if (discid) {
        conditions[@"discid"] = discid;
    }
    if (cat) {
        conditions[@"cat"] = cat;
    }
    if (year) {
        conditions[@"year"] = year;
    }
    if (tracks) {
        conditions[@"tracks"] = tracks;
    }
    
    [self search:@"freedb" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchLabel:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit alias:(NSString *)alias area:(NSString *)area begin:(NSString *)begin code:(NSString *)code comment:(NSString *)comment country:(NSString *)country end:(NSString *)end ended:(NSString *)ended ipi:(NSString *)ipi label:(NSString *)label labelaccent:(NSString *)labelaccent laid:(NSString *)laid sortname:(NSString *)sortname type:(NSString *)type tag:(NSString *)tag completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (alias) {
        conditions[@"alias"] = alias;
    }
    if (area) {
        conditions[@"area"] = area;
    }
    if (begin) {
        conditions[@"begin"] = begin;
    }
    if (code) {
        conditions[@"code"] = code;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (country) {
        conditions[@"country"] = country;
    }
    if (end) {
        conditions[@"end"] = end;
    }
    if (ended) {
        conditions[@"ended"] = ended;
    }
    if (ipi) {
        conditions[@"ipi"] = ipi;
    }
    if (label) {
        conditions[@"label"] = label;
    }
    if (labelaccent) {
        conditions[@"labelaccent"] = labelaccent;
    }
    if (laid) {
        conditions[@"laid"] = laid;
    }
    if (sortname) {
        conditions[@"sortname"] = sortname;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    if (tag) {
        conditions[@"tag"] = tag;
    }
    
    [self search:@"label" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchPlace:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit pid:(NSString *)pid address:(NSString *)address alias:(NSString *)alias area:(NSString *)area begin:(NSString *)begin comment:(NSString *)comment end:(NSString *)end ended:(NSString *)ended lat:(NSString *)latitude long:(NSString *)longitude type:(NSString *)type completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (pid) {
        conditions[@"pid"] = pid;
    }
    if (address) {
        conditions[@"address"] = address;
    }
    if (alias) {
        conditions[@"alias"] = alias;
    }
    if (area) {
        conditions[@"area"] = area;
    }
    if (begin) {
        conditions[@"begin"] = begin;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (end) {
        conditions[@"end"] = end;
    }
    if (ended) {
        conditions[@"ended"] = ended;
    }
    if (latitude) {
        conditions[@"lat"] = latitude;
    }
    if (longitude) {
        conditions[@"long"] = longitude;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    
    [self search:@"place" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchRecording:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit arid:(NSString *)arid artist:(NSString *)artist artistname:(NSString *)artistname creditname:(NSString *)creditname comment:(NSString *)comment country:(NSString *)country date:(NSString *)date dur:(NSString *)dur format:(NSString *)format isrc:(NSString *)isrc number:(NSString *)number position:(NSString *)position primarytype:(NSString *)primarytype puid:(NSString *)puid qdur:(NSString *)qdur recording:(NSString *)recording recordingaccent:(NSString *)recordingaccent reid:(NSString *)reid release:(NSString *)release rgid:(NSString *)rgid rid:(NSString *)rid secondarytype:(NSString *)secondarytype status:(NSString *)status tid:(NSString *)tid tnum:(NSString *)tnum tracks:(NSString *)tracks tracksrelease:(NSString *)tracksrelease tag:(NSString *)tag type:(NSString *)type video:(NSString *)video completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (arid) {
        conditions[@"arid"] = arid;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (artistname) {
        conditions[@"artistname"] = artistname;
    }
    if (creditname) {
        conditions[@"creditname"] = creditname;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (country) {
        conditions[@"country"] = country;
    }
    if (date) {
        conditions[@"date"] = date;
    }
    if (dur) {
        conditions[@"dur"] = dur;
    }
    if (format) {
        conditions[@"format"] = format;
    }
    if (isrc) {
        conditions[@"isrc"] = isrc;
    }
    if (number) {
        conditions[@"number"] = number;
    }
    if (position) {
        conditions[@"position"] = position;
    }
    if (primarytype) {
        conditions[@"primarytype"] = primarytype;
    }
    if (puid) {
        conditions[@"puid"] = puid;
    }
    if (qdur) {
        conditions[@"qdur"] = qdur;
    }
    if (recording) {
        conditions[@"recording"] = recording;
    }
    if (recordingaccent) {
        conditions[@"recordingaccent"] = recordingaccent;
    }
    if (reid) {
        conditions[@"reid"] = reid;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    if (rgid) {
        conditions[@"rgid"] = rgid;
    }
    if (rid) {
        conditions[@"rid"] = rid;
    }
    if (secondarytype) {
        conditions[@"secondarytype"] = secondarytype;
    }
    if (status) {
        conditions[@"status"] = status;
    }
    if (tid) {
        conditions[@"tid"] = tid;
    }
    if (tnum) {
        conditions[@"tnum"] = tnum;
    }
    if (tracks) {
        conditions[@"tracks"] = tracks;
    }
    if (tracksrelease) {
        conditions[@"tracksrelease"] = tracksrelease;
    }
    if (tag) {
        conditions[@"tag"] = tag;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    if (video) {
        conditions[@"video"] = video;
    }
    
    [self search:@"recording" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchReleaseGroup:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit arid:(NSString *)arid artist:(NSString *)artist artistname:(NSString *)artistname comment:(NSString *)comment creditname:(NSString *)creditname primarytype:(NSString *)primarytype rgid:(NSString *)rgid releasegroup:(NSString *)releasegroup releasegroupaccent:(NSString *)releasegroupaccent releases:(NSString *)releases release:(NSString *)release reid:(NSString *)reid secondarytype:(NSString *)secondarytype status:(NSString *)status tag:(NSString *)tag type:(NSString *)type completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (arid) {
        conditions[@"arid"] = arid;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (artistname) {
        conditions[@"artistname"] = artistname;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (creditname) {
        conditions[@"creditname"] = creditname;
    }
    if (primarytype) {
        conditions[@"primarytype"] = primarytype;
    }
    if (rgid) {
        conditions[@"rgid"] = rgid;
    }
    if (releasegroup) {
        conditions[@"releasegroup"] = releasegroup;
    }
    if (releasegroupaccent) {
        conditions[@"releasegroupaccent"] = releasegroupaccent;
    }
    if (releases) {
        conditions[@"releases"] = releases;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    if (reid) {
        conditions[@"reid"] = reid;
    }
    if (secondarytype) {
        conditions[@"secondarytype"] = secondarytype;
    }
    if (status) {
        conditions[@"status"] = status;
    }
    if (tag) {
        conditions[@"tag"] = tag;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    
    [self search:@"release-group" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchRelease:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit arid:(NSString *)arid artist:(NSString *)artist artistname:(NSString *)artistname asin:(NSString *)asin barcode:(NSString *)barcode catno:(NSString *)catno comment:(NSString *)comment country:(NSString *)country creditname:(NSString *)creditname date:(NSString *)date discids:(NSString *)discids discidsmedium:(NSString *)discidsmedium format:(NSString *)format laid:(NSString *)laid label:(NSString *)label lang:(NSString *)lang mediums:(NSString *)mediums primarytype:(NSString *)primarytype puid:(NSString *)puid quality:(NSString *)quality reid:(NSString *)reid release:(NSString *)release releaseaccent:(NSString *)releaseaccent rgid:(NSString *)rgid script:(NSString *)script secondarytype:(NSString *)secondarytype status:(NSString *)status tag:(NSString *)tag tracks:(NSString *)tracks tracksmedium:(NSString *)tracksmedium type:(NSString *)type completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (arid) {
        conditions[@"arid"] = arid;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (artistname) {
        conditions[@"artistname"] = artistname;
    }
    if (asin) {
        conditions[@"asin"] = asin;
    }
    if (barcode) {
        conditions[@"barcode"] = barcode;
    }
    if (catno) {
        conditions[@"catno"] = catno;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (country) {
        conditions[@"country"] = country;
    }
    if (creditname) {
        conditions[@"creditname"] = creditname;
    }
    if (date) {
        conditions[@"date"] = date;
    }
    if (discids) {
        conditions[@"discids"] = discids;
    }
    if (discidsmedium) {
        conditions[@"discidsmedium"] = discidsmedium;
    }
    if (format) {
        conditions[@"format"] = format;
    }
    if (laid) {
        conditions[@"laid"] = laid;
    }
    if (label) {
        conditions[@"label"] = label;
    }
    if (lang) {
        conditions[@"lang"] = lang;
    }
    if (mediums) {
        conditions[@"mediums"] = mediums;
    }
    if (primarytype) {
        conditions[@"primarytype"] = primarytype;
    }
    if (puid) {
        conditions[@"puid"] = puid;
    }
    if (quality) {
        conditions[@"quality"] = quality;
    }
    if (reid) {
        conditions[@"reid"] = reid;
    }
    if (release) {
        conditions[@"release"] = release;
    }
    if (releaseaccent) {
        conditions[@"releaseaccent"] = releaseaccent;
    }
    if (rgid) {
        conditions[@"rgid"] = rgid;
    }
    if (script) {
        conditions[@"script"] = script;
    }
    if (secondarytype) {
        conditions[@"secondarytype"] = secondarytype;
    }
    if (status) {
        conditions[@"status"] = status;
    }
    if (tag) {
        conditions[@"tag"] = tag;
    }
    if (tracks) {
        conditions[@"tracks"] = tracks;
    }
    if (tracksmedium) {
        conditions[@"tracksmedium"] = tracksmedium;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    
    [self search:@"release" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchTag:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit tag:(NSString *)tag completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (tag) {
        conditions[@"tag"] = tag;
    }
    
    [self search:@"tag" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

- (void)searchWork:(NSString *)string offset:(NSNumber *)offset limit:(NSNumber *)limit alias:(NSString *)alias arid:(NSString *)arid artist:(NSString *)artist comment:(NSString *)comment iswc:(NSString *)iswc lang:(NSString *)lang tag:(NSString *)tag type:(NSString *)type wid:(NSString *)wid work:(NSString *)work workaccent:(NSString *)workaccent completion:(MbzCompletion)completion
{
    NSMutableDictionary *conditions = [NSMutableDictionary new];
    if (alias) {
        conditions[@"alias"] = alias;
    }
    if (arid) {
        conditions[@"arid"] = arid;
    }
    if (artist) {
        conditions[@"artist"] = artist;
    }
    if (comment) {
        conditions[@"comment"] = comment;
    }
    if (iswc) {
        conditions[@"iswc"] = iswc;
    }
    if (lang) {
        conditions[@"lang"] = lang;
    }
    if (tag) {
        conditions[@"tag"] = tag;
    }
    if (type) {
        conditions[@"type"] = type;
    }
    if (wid) {
        conditions[@"wid"] = wid;
    }
    if (work) {
        conditions[@"work"] = work;
    }
    if (workaccent) {
        conditions[@"workaccent"] = workaccent;
    }
    
    [self search:@"work" string:string conditions:conditions offset:offset limit:limit completion:completion];
}

@end
