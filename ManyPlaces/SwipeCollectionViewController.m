//
//  SwipeCollectionViewController.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/20/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "PlaceDetailViewController.h"
#import "SwipeCollectionViewController.h"

@interface SwipeCollectionViewController ()


@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SwipeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createCollectionViewFlowLayout];
    [self configureCollectionView];
    
    if (self.index > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:NO];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCollectionViewFlowLayout
{
    self.flowLayout = [UICollectionViewFlowLayout new];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.flowLayout setHeaderReferenceSize:CGSizeMake(0, 0)];
    [self.flowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
    [self.flowLayout setSectionInset:UIEdgeInsetsZero];
    [self.flowLayout setMinimumInteritemSpacing:0.0];
    [self.flowLayout setMinimumLineSpacing:0.0];
    
    CGSize size = self.view.frame.size;
    size.height -= 44;
    
    [self.flowLayout setItemSize:size];
}

- (void)configureCollectionView
{
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.bounces    = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.clipsToBounds = YES;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.multipleTouchEnabled = YES;
    self.collectionView.minimumZoomScale = 0.0;
    self.collectionView.maximumZoomScale = 0.0;
    
    [self.collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.results ? self.results.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    PlaceDetailViewController *placeVC = [sb instantiateViewControllerWithIdentifier:@"placedetailview"];
    placeVC.currentPlace = self.results[indexPath.row];
    
    cell.detailViewController = placeVC;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
