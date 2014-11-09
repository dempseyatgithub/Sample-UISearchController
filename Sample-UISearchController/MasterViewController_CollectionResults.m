//
//  TPSMasterViewController.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "MasterViewController_CollectionResults.h"
#import "SearchResultsCollectionViewController.h"
#import "DetailViewController.h"
#import "Product.h"

#define ENABLE_SCOPE_BUTTONS 1


@interface MasterViewController_CollectionResults () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results

@end

#pragma mark -

@implementation MasterViewController_CollectionResults

- (void)viewDidLoad {

    [super viewDidLoad];

    self.products = [Product allProducts];

    // Create a mutable array to contain products for the search results table.
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.products count]];

    SearchResultsCollectionViewController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"CollectionSearchResultsNavController"];

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];

    self.searchController.searchResultsUpdater = self;

    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);

    self.tableView.tableHeaderView = self.searchController.searchBar;

    self.definesPresentationContext = YES;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"pushDetailView"]) {

        // Sender is the table view cell.
        NSArray *sourceArray;
        NSIndexPath*  indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        sourceArray = self.products;

        UIViewController *destinationController = segue.destinationViewController;
        Product *product = sourceArray[indexPath.row];
        ((DetailViewController *)destinationController).product = product;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.products count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];

    Product *product = [self.products objectAtIndex:indexPath.row];

    cell.textLabel.text = product.name;
    return cell;
}


#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *searchString = [self.searchController.searchBar text];

    NSString *scope = nil;

    NSInteger selectedScopeButtonIndex = [self.searchController.searchBar selectedScopeButtonIndex];
    if (selectedScopeButtonIndex > 0) {
        scope = [[Product deviceTypeNames] objectAtIndex:(selectedScopeButtonIndex - 1)];
    }

    [self updateFilteredContentForProductName:searchString type:scope];

    if (self.searchController.searchResultsController) {
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;

        SearchResultsCollectionViewController *vc = (SearchResultsCollectionViewController *)navController.topViewController;
        vc.searchResults = self.searchResults;
        [vc.collectionView reloadData];
    }

}


#pragma mark - Content Filtering

- (void)updateFilteredContentForProductName:(NSString *)productName type:(NSString *)typeName {

    // Update the filtered array based on the search text and scope.
    if ((productName == nil) || [productName length] == 0) {
        // If there is no search string and the scope is "All".
        if (typeName == nil) {
            self.searchResults = [self.products mutableCopy];
        } else {
            // If there is no search string and the scope is chosen.
            NSMutableArray *searchResults = [[NSMutableArray alloc] init];
            for (Product *product in self.products) {
                if ([product.type isEqualToString:typeName]) {
                    [searchResults addObject:product];
                }
            }
            self.searchResults = searchResults;
        }
        return;
    }

    [self.searchResults removeAllObjects]; // First clear the filtered array.

    /*  Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (Product *product in self.products) {
        if ((typeName == nil) || [product.type isEqualToString:typeName]) {
            NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
            NSRange productNameRange = NSMakeRange(0, product.name.length);
            NSRange foundRange = [product.name rangeOfString:productName options:searchOptions range:productNameRange];
            if (foundRange.length > 0) {
                [self.searchResults addObject:product];
            }
        }
    }
}

@end
