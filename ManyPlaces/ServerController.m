//
//  ServerController.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/15/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "ServerController.h"
#import "Place.h"

#import <Motis.h>

@implementation ServerController

+ (instancetype)sharedInstance
{
    static ServerController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)searchPlacesFor:(NSString *)query withCompletion:(void (^)(NSArray *))completion
{
    NSString *nospaces = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlstring = [kBASE_URL stringByAppendingString:[NSString stringWithFormat:kTEXTSEARCH_PATH, kAPI_KEY, nospaces ]];
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil) {
            
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:20];
            
            for(NSDictionary *p in dict[@"results"])
            {
                [results addObject:[[Place alloc] initWithJSON:p]];
            }
            
            completion(results);
            
        }
        else {
            completion(nil);
        }
        
    }];
    
    [task resume];
}

- (void)getDetailsForPlace:(NSString *)placeId withCompleteion:(void (^)(PlaceDetails *))completion
{
    NSString *urlstring = [kBASE_URL stringByAppendingString:[NSString stringWithFormat:kDETAILSSEARCH_PATH, kAPI_KEY, placeId ]];
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error == nil) {
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            PlaceDetails *detail = [[PlaceDetails alloc] initWithJSON:dict[@"result"]];
            
            completion(detail);
            
        }
        else {
            completion(nil);
        }
        
    }];
    
    [task resume];
}

@end
