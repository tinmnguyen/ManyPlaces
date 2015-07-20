//
//  PlaceDetailViewController.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/16/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "ReviewTableViewCell.h"
#import "ServerController.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import <MapKit/MapKit.h>

@interface PlaceDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,weak) IBOutlet MKMapView *mapView;

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet HCSStarRatingView *starView;
@property (nonatomic,weak) IBOutlet UILabel *addressLabel;
@property (nonatomic,weak) IBOutlet UIButton *phoneButton;

@property (nonatomic,weak) IBOutlet UITableView *reviewsTableViews;

@property (nonatomic,strong) PlaceDetails *details;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self resetView];
    [self setTitle:@"Details"];
    
    __weak typeof(self) weakSelf = self;
    [[ServerController sharedInstance] getDetailsForPlace:self.currentPlace.placeId withCompleteion:^(PlaceDetails *details, NSError *error) {
        if (error == nil) {
            weakSelf.details = details;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf configureDetails];
                [weakSelf configureTableView];
            });
        }
        else {
            
        }

    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetView
{
    self.nameLabel.text     = @"";
    self.starView.value     = 0;
    self.addressLabel.text  = @"";
    [self.phoneButton setTitle:@"" forState:UIControlStateNormal];
}

- (void)configureMapView
{
    MKPointAnnotation *point = [MKPointAnnotation new];
    point.coordinate = self.currentPlace.location;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.currentPlace.location, 1000, 1000);
    
    [self.mapView setRegion:viewRegion];
    [self.mapView addAnnotation:point];
    
    // Set map to 3D view
    MKMapCamera *camera = self.mapView.camera;
    camera.pitch = 45.0;
    [self.mapView setCamera:camera];
}

- (void)configureDetails
{
    self.nameLabel.text = self.details.name;
    self.starView.value = self.currentPlace.rating;
    self.starView.userInteractionEnabled = NO;
    self.addressLabel.text = [self.details getStreetAddress];
    
    if (self.details.phoneNumber != nil) {
        [self.phoneButton setTitle:self.details.phoneNumber forState:UIControlStateNormal];
    }
    else
    {
        self.phoneButton.enabled = NO;
    }
}

- (void)configureTableView
{
    [self.reviewsTableViews registerNib:[UINib nibWithNibName:@"ReviewTableViewCell" bundle:[NSBundle mainBundle]]
                 forCellReuseIdentifier:@"reviewCell"];
    [self.reviewsTableViews reloadData];
}

- (IBAction)phoneButtonDidPress:(UIButton *)sender {
    
    NSString *message = [NSString stringWithFormat:@"Call %@?", self.details.phoneNumber];
    UIAlertController *alert    = [UIAlertController alertControllerWithTitle:message
                                                                      message:@"Call me maybe"
                                                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    
    UIAlertAction *yesAction    = [UIAlertAction actionWithTitle:@"Yes"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [[UIApplication sharedApplication]openURL:[self.details getPhoneUrl]];
                                                            }];
    
    [alert addAction:cancelAction];
    [alert addAction:yesAction];
    
    [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *review = self.details.reviews[indexPath.row];
    NSString *text = review[@"text"];
    
    return [ReviewTableViewCell heightOfCellFor:text withWidth:tableView.frame.size.width];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.details.reviews ? self.details.reviews.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewTableViewCell *cell = (ReviewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"reviewCell"];
    
    [cell setData:self.details.reviews[indexPath.row]];
    
    return cell;
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
