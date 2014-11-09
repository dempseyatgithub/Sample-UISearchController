//
//  TPSMasterViewController.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "TPSMasterViewController_TableResults.h"
#import "TPSDetailViewController.h"
#import "SearchResultsTableViewController.h"
#import "TPSProduct.h"

#define ENABLE_SCOPE_BUTTONS 1


@interface TPSMasterViewController_TableResults () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results

@end

#pragma mark -

@implementation TPSMasterViewController_TableResults

- (void)viewDidLoad {

    [super viewDidLoad];

    self.products = [TPSProduct allProducts];

    // Create a mutable array to contain products for the search results table.
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.products count]];

    UITableViewController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"TableSearchResultsNavController"];

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];

    self.searchController.searchResultsUpdater = self;

    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);

    self.tableView.tableHeaderView = self.searchController.searchBar;

#if ENABLE_SCOPE_BUTTONS
    
    NSMutableArray *scopeButtonTitles = [[NSMutableArray alloc] init];
    [scopeButtonTitles addObject:NSLocalizedString(@"All", @"Search display controller All button.")];

    for (NSString *deviceType in [TPSProduct deviceTypeNames]) {
        NSString *displayName = [TPSProduct displayNameForType:deviceType];
        [scopeButtonTitles addObject:displayName];
    }

    self.searchController.searchBar.scopeButtonTitles = scopeButtonTitles;
    self.searchController.searchBar.delegate = self;

#endif

    self.definesPresentationContext = YES;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"pushDetailView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        TPSProduct *product = self.products[indexPath.row];

        TPSDetailViewController *destinationController = segue.destinationViewController;
        destinationController.product = product;
    }

}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.products count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProductCell";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    TPSProduct *product = [self.products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    return cell;
}


#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *searchString = [self.searchController.searchBar text];

    NSString *scope = nil;

    NSInteger selectedScopeButtonIndex = [self.searchController.searchBar selectedScopeButtonIndex];
    if (selectedScopeButtonIndex > 0) {
        scope = [[TPSProduct deviceTypeNames] objectAtIndex:(selectedScopeButtonIndex - 1)];
    }

    [self updateFilteredContentForProductName:searchString type:scope];
    
    if (self.searchController.searchResultsController) {
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;

        SearchResultsTableViewController *vc = (SearchResultsTableViewController *)navController.topViewController;
        vc.searchResults = self.searchResults;
        [vc.tableView reloadData];
    }

}

#pragma mark - UISearchBarDelegate

// Workaround for bug: -updateSearchResultsForSearchController: is not called when scope buttons change
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
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
            for (TPSProduct *product in self.products) {
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
    for (TPSProduct *product in self.products) {
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
