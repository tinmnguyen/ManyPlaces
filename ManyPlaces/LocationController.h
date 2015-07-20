//
//  LocationController.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/18/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface LocationController : NSObject

@property (nonatomic,strong) CLLocation *currentLocation;

+ (instancetype)sharedInstance;

- (BOOL)isLocationAllowed;
- (void)getLocationWithCompletion:(void (^)(CLLocation *location, NSError *error))completion;

@end
