 //
//  SearchResultsCollectionViewController.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/5/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//

#import "SearchResultsCollectionViewController.h"
#import "SearchResultCollectionViewCell.h"
#import "DetailViewController.h"
#import "TPSProduct.h"

@interface SearchResultsCollectionViewController ()

@end

@implementation SearchResultsCollectionViewController

static NSString * const reuseIdentifier = @"SearchResultCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.contentInset = UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0);
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SearchResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    TPSProduct *product = [self.searchResults objectAtIndex:indexPath.row];
    cell.titleLabel.text = product.name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TPSProduct *product = [self.searchResults objectAtIndex:indexPath.row];
    DetailViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    self.presentingViewController.navigationItem.title = @"Search";
    vc.product = product;
    [self.presentingViewController.navigationController pushViewController:vc animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
