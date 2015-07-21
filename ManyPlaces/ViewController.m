//
//  ViewController.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/15/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "ActivityButton.h"
#import "LocationController.h"
#import "Place.h"
#import "PlaceDetailViewController.h"
#import "PlaceTableViewCell.h"
#import "ServerController.h"
#import "SwipeCollectionViewController.h"
#import "ViewController.h"

#import <CWStatusBarNotification/CWStatusBarNotification.h>
#import <Motis/Motis.h>

@interface ViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,weak) IBOutlet UITextField *queryTextField;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet ActivityButton *locationButton;

@property (nonatomic,strong) NSTimer *searchTimer;
@property (nonatomic,strong) NSString *lastSearchedText;
@property (nonatomic,strong) CWStatusBarNotification *notificationBar;

@property (nonatomic,strong) NSArray *results;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.results = [NSArray new];
    self.notificationBar = [CWStatusBarNotification new];
    [self configureTableView];
    [self configureLocationButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.queryTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *segueName = segue.identifier;
    
    if ([segueName isEqualToString:@"placeDetail"]) {
        PlaceDetailViewController *placeView = (PlaceDetailViewController *)segue.destinationViewController;
        placeView.currentPlace = self.results[self.tableView.indexPathForSelectedRow.row];
    }
    
    if ([segueName isEqualToString:@"collectionSegue"]) {
        SwipeCollectionViewController *swipeView = (SwipeCollectionViewController *)segue.destinationViewController;
        
        swipeView.results = self.results;
        swipeView.index = self.tableView.indexPathForSelectedRow.row;
        
        
    }
}

- (void)configureTableView
{    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = 44;
    self.tableView.contentInset = insets;
}

- (void)configureLocationButton
{
    ActivityButton *button = [ActivityButton buttonWithType:UIButtonTypeSystem];
    UIImage *icon = [[UIImage imageNamed:@"Location"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    button.frame = CGRectMake(0, 0, 24, 24);
    [button setImage:icon forState:UIControlStateNormal];
    button.tintColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(locationButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.locationButton = button;
    
}

- (void)locationButtonDidPress:(ActivityButton *)sender
{
    if ((CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied ||
          CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted)) {
        
        NSString *message = @"Location access is disabled, would you like to enable it in Settings?";
        NSURL *settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        UIAlertController *alert    = [UIAlertController alertControllerWithTitle:nil
                                                                          message:message
                                                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action) {}];
        
        UIAlertAction *yesAction    = [UIAlertAction actionWithTitle:@"Yes"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 [[UIApplication sharedApplication]openURL:settingsUrl];
                                                             }];
        
        [alert addAction:cancelAction];
        [alert addAction:yesAction];
        
        [self presentViewController:alert animated:YES completion:^{}];
        
        return;
        
    }
    
    [sender startAnimating];
    
    __weak typeof(self) weakSelf = self;
    [[LocationController sharedInstance] getLocationWithCompletion:^(CLLocation *location, NSError *error) {
        if (error == nil) {
            [weakSelf.locationButton setTintColor:[UIColor blueColor]];
        }
        else {
            [weakSelf.locationButton setTintColor:[UIColor lightGrayColor]];
        }
        [weakSelf.locationButton stopAnimating];
    }];
}

- (void)searchForQuery:(NSString *)text
{
    if (text != nil && text.length > 1) {
        
        __weak typeof(self) weakSelf = self;
        [[ServerController sharedInstance] searchPlacesFor:text withCompletion:^(NSArray *result, NSError *error) {
            
            if (error == nil) {
                weakSelf.results = result;
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }
            else {
                [weakSelf displayError:error];
            }
            
        }];
    }
}

- (void)triggerTimerSearch
{
    [self searchForQuery:self.lastSearchedText];
}

- (void)displayError:(NSError *)error {
    
    NSString *message = error.localizedDescription;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.notificationBar.notificationLabelBackgroundColor = [UIColor redColor];
        weakSelf.notificationBar.notificationLabelTextColor = [UIColor whiteColor];
        [weakSelf.notificationBar displayNotificationWithMessage:message forDuration:5.0];
    });
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results ? self.results.count:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceTableViewCell *cell = (PlaceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row < self.results.count) { // why do you even.. maybe refreshing too fast
        [cell setPlace:self.results[indexPath.row]];
    }
    else {
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.queryTextField resignFirstResponder];
    //[self performSegueWithIdentifier:@"placeDetail" sender:tableView];
    [self performSegueWithIdentifier:@"collectionSegue" sender:tableView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newText.length > 2 && textField.text.length < newText.length && ![string isEqualToString:@"\n"]) {
        
        [self.notificationBar dismissNotification];
        [self.searchTimer invalidate];
        self.searchTimer = [NSTimer timerWithTimeInterval:0.15
                                                   target:self
                                                 selector:@selector(triggerTimerSearch)
                                                 userInfo:nil
                                                  repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.searchTimer forMode:NSRunLoopCommonModes];
        
        self.lastSearchedText = newText;
    }
    else if (newText.length < textField.text.length || newText.length == 0) // backspace
    {
        self.lastSearchedText = nil;
        self.results = nil;
        [self.tableView reloadData];
    }
    
    if ([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];
        if (![newText isEqualToString:self.lastSearchedText]) {
            [self.searchTimer invalidate];
            [self searchForQuery:textField.text];
        }
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.lastSearchedText = nil;
    self.results = nil;
    [self.tableView reloadData];
    
    return YES;
}

@end
