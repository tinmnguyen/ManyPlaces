//
//  ServerController.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/15/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#define kAPI_KEY @"AIzaSyCaHttKTZM9YRpydBI__YhJMppCoCp4984"
#define kBASE_URL @"https://maps.googleapis.com/maps/api/place/textsearch/json?key=%@&query=%@"

#import <Foundation/Foundation.h>

@interface ServerController : NSObject

+ (instancetype)sharedInstance;

- (void)searchPlacesFor:(NSString *)query withCompletion:(void (^)(NSDictionary *result))completion;

@end
