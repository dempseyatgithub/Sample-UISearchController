//
//  SearchResultCollectionViewCell.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/5/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//

#import "SearchResultCollectionViewCell.h"

@implementation SearchResultCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];

    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 10.0;

}
@end
