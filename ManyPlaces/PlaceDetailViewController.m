//
//  PlaceDetailViewController.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/16/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "ServerController.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import <MapKit/MapKit.h>

@interface PlaceDetailViewController ()

@property (nonatomic,weak) IBOutlet MKMapView *mapView;

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet HCSStarRatingView *starView;
@property (nonatomic,weak) IBOutlet UITableView *commentsView;

@property (nonatomic,strong) PlaceDetails *details;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTitle:@"Details"];
    
    [self configureMapView];
    
    [[ServerController sharedInstance] getDetailsForPlace:self.currentPlace.placeId withCompleteion:^(PlaceDetails *details) {
        self.details = details;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureDetails];
        });
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureMapView
{
    MKPointAnnotation *point = [MKPointAnnotation new];
    point.coordinate = self.currentPlace.location;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.currentPlace.location, 1000, 1000);
    
    [self.mapView setRegion:viewRegion];
    [self.mapView addAnnotation:point];
    //self.mapView.userInteractionEnabled = NO;
}

- (void)configureDetails
{
    self.nameLabel.text = self.details.name;
    self.starView.value = self.currentPlace.rating;
    self.starView.userInteractionEnabled = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
