//
//  NSString+URLQueryString.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLQueryString)

/**
 *  Build a new string that by adding URL query string to the tail of string.
 *  <p/> eg: "/broadcast/radio/browse/HomeView" + {"resource":"dashboardRadio", "perfect_cuts":"0"}
 *  <p/> ==> "/broadcast/radio/browse/HomeView?resource=dashboardRadio&perfect_cuts=0"
 *  <p/> Notice: Self string should not has any query items before adding new items.
 *
 *  @param parameters A dictionary with query item values by names.
 *
 *  @return Return a new string which was added new query string.
 */
- (instancetype)stringByAddingURLQueryStringFromParameters:(NSDictionary *)parameters;

/**
 *  Build a new string that by appending URL query string to the tail of string.
 *  <p/> eg: "/broadcast/radio/browse/HomeView?resource=dashboardRadio" + {"perfect_cuts":"0"}
 *  <p/> ==> "/broadcast/radio/browse/HomeView?resource=dashboardRadio&perfect_cuts=0"
 *  <p/> Notice: Self string should already has some query items before appending new items.
 *
 *  @param parameters A dictionary with query item values by names.
 *
 *  @return Return a new string which was appended new query string.
 */
- (instancetype)stringByAppendingURLQueryStringFromParameters:(NSDictionary *)parameters;

/**
 *  Generate URL query string from a dictonary object.
 *  <p/> eg: {"resource":"dashboardRadio", "perfect_cuts":"0"}
 *  <p/> ==> "resource=dashboardRadio&perfect_cuts=0"
 *
 *  @param parameters A dictionary with query item values by names.
 *
 *  @return Return the query string.
 */
+ (instancetype)URLQueryStringFromParameters:(NSDictionary *)parameters;

@end
