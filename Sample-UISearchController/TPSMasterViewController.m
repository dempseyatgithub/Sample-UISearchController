//
//  TPSMasterViewController.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "TPSMasterViewController.h"
#import "TPSDetailViewController.h"
#import "TPSProduct.h"


@interface TPSMasterViewController () <UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results

@end

#pragma mark -

@implementation TPSMasterViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    // Create a mutable array to contain products for the search results table.
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.products count]];

    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;

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
        NSIndexPath *indexPath = [((UITableViewController *)self.searchController.searchResultsController).tableView indexPathForCell:(UITableViewCell *)sender];
        if (indexPath != nil) {
            sourceArray = self.searchResults;
        } else {
            indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
            sourceArray = self.products;
        }

        UIViewController *destinationController = segue.destinationViewController;
        TPSProduct *product = sourceArray[indexPath.row];
        ((TPSDetailViewController *)destinationController).product = product;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    /*  If the requesting table view is the search controller's table view, return the count of
        the filtered list, otherwise return the count of the main list.
     */
    if (tableView == ((UITableViewController *)self.searchController.searchResultsController).tableView) {
        return [self.searchResults count];
    } else {
        return [self.products count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProductCell";

    // Dequeue a cell from self's table view.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    /*  If the requesting table view is the search controller's table view, configure the cell using the search results array, otherwise use the product array.
     */
    TPSProduct *product;

    if (tableView == ((UITableViewController *)self.searchController.searchResultsController).tableView) {
        product = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        product = [self.products objectAtIndex:indexPath.row];
    }

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
    
    [((UITableViewController *)self.searchController.searchResultsController).tableView reloadData];
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
