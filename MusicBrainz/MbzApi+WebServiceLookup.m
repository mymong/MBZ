//
//  MbzApi+WebServiceLookup.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/7/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzApi+WebServiceLookup.h"

@implementation MbzApi (WebServiceLookup)

- (void)lookup:(NSString *)entity mbid:(NSString *)mbid inc:(NSArray *)inc toc:(NSArray *)toc more:(NSDictionary *)more completion:(MbzCompletion)completion
{
    NSParameterAssert(entity && mbid);
    
    NSString *path = [NSString stringWithFormat:@"/ws/2/%@/%@", entity, mbid];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"fmt"] = @"json";
    
    if (inc.count > 0) {
        NSString *queries = [inc componentsJoinedByString:@"+"];
        parameters[@"inc"] = queries;
    }
    
    if (toc.count > 0) {
        NSString *queries = [toc componentsJoinedByString:@"+"];
        parameters[@"toc"] = queries;
    }
    
    [self send:@"GET" path:path parameters:parameters headers:nil completion:completion];
}

- (void)lookupEntity:(NSString *)entity mbid:(NSString *)mbid subqueries:(NSArray *)subqueries arguments:(NSArray *)arguments relationships:(NSArray *)relationships type:(NSString *)type status:(NSString *)status completion:(MbzCompletion)completion
{
    NSMutableArray *inc = [NSMutableArray new];
    
    if (subqueries.count > 0) {
        [inc addObjectsFromArray:subqueries];
    }
    
    if (arguments.count > 0) {
        [inc addObjectsFromArray:arguments];
    }
    
    if (relationships.count > 0) {
        [inc addObjectsFromArray:relationships];
    }
    
    NSMutableDictionary *more = [NSMutableDictionary new];
    
    if (type) {
        more[@"type"] = type;
    }
    
    if (status) {
        more[@"status"] = status;
    }
    
    [self lookup:entity mbid:mbid inc:inc toc:nil more:more completion:completion];
}

- (void)lookupDiscid:(NSString *)discid inc:(NSArray *)inc toc:(NSArray *)toc completion:(MbzCompletion)completion
{
    [self lookup:@"discid" mbid:discid inc:inc toc:toc more:nil completion:completion];
}

- (void)lookupIsrc:(NSString *)isrc inc:(NSArray *)inc completion:(MbzCompletion)completion
{
    [self lookup:@"isrc" mbid:isrc inc:inc toc:nil more:nil completion:completion];
}

- (void)lookupIswc:(NSString *)iswc inc:(NSArray *)inc completion:(MbzCompletion)completion
{
    [self lookup:@"iswc" mbid:iswc inc:inc toc:nil more:nil completion:completion];
}

@end
