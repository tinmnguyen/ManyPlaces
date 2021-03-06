//
//  ServerController.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/15/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#define kAPI_KEY            @"AIzaSyCaHttKTZM9YRpydBI__YhJMppCoCp4984"
//#define kAPI_KEY            @"AIzaCaHttKTZM9YRpydBI__YhJMppCoCp4984dd" //bad api key for testing
#define kBASE_URL           @"https://maps.googleapis.com/maps/api/place"
#define kTEXTSEARCH_PATH    @"/textsearch/json?key=%@&query=%@"
#define kMORERESULTS_PATH   @"/textsearch/json?key=%@&pagetoken=%@"
#define kDETAILSSEARCH_PATH @"/details/json?key=%@&placeid=%@"

#import <Foundation/Foundation.h>
#import "PlaceDetails.h"

@interface ServerController : NSObject

+ (instancetype)sharedInstance;

- (void)searchPlacesFor:(NSString *)query withCompletion:(void (^)(NSArray *result,NSError *error))completion;

- (void)getNextResultsWithCompletion:(void (^)(NSArray *result, NSError *error))completion;

- (void)getDetailsForPlace:(NSString *)placeId withCompleteion:(void (^)(PlaceDetails *details, NSError *error))completion;
@end
