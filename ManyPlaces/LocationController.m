//
//  LocationController.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/18/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "LocationController.h"

@interface LocationController () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,copy) void (^locationCompletion)(CLLocation *location);

@end

@implementation LocationController

+ (instancetype)sharedInstance
{
    static LocationController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.delegate = self;
    }
    
    return self;
}

- (void)getLocationWithCompletion:(void (^)(CLLocation *))completion
{
    self.locationCompletion = completion;
    
    if ([self isLocationAllowed]) {
        [self.locationManager startUpdatingLocation];
    }
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (BOOL)isLocationAllowed
{
    return !(CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied ||
             CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted ||
             CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined);
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            
            [self.locationManager startUpdatingLocation];
            
            break;
        case kCLAuthorizationStatusDenied:
        default:
            break;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = locations.lastObject;
    
    if (location.horizontalAccuracy < 200) {
        return;
    }
    
    self.currentLocation = location;
    
    [self.locationManager stopUpdatingLocation];
    
    if (self.locationCompletion != nil) {
        self.locationCompletion(self.currentLocation);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

@end
