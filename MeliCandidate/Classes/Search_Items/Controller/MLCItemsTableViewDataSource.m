//
//  MLCItemsTableViewDataSource.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemsTableViewDataSource.h"
#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MLCItemTableViewCell.h"
#import "MLCPriceFormatter.h"
#import "MLCQuantityFormatter.h"
#import "MLCConstants.h"

@interface MLCItemsTableViewDataSource () <UITableViewDataSource>


@end

@implementation MLCItemsTableViewDataSource 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsList.count;
    
}

-(void)resetItemCellForReuse:(MLCItemTableViewCell*)itemCell {
    itemCell.titleLabel.text = @"";
    itemCell.cityLabel.text =  @"";
    itemCell.priceLabel.text = @"";
    itemCell.soldQuantityLabel.text = @"";
    itemCell.imageView.image = nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLCItemTableViewCell* itemCell = (MLCItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:kItemCellIdentifier forIndexPath:indexPath];
    [self resetItemCellForReuse:itemCell];
    
    MLCItem* item = self.itemsList[indexPath.row];
    itemCell.titleLabel.text = item.title;
    itemCell.cityLabel.text = item.location.city;
    MLCPriceFormatter* priceFormatter  = [MLCPriceFormatter sharedPriceFormatter];
    itemCell.priceLabel.text = [priceFormatter stringFromNumber:[NSNumber numberWithLongLong:item.price]];
    itemCell.soldQuantityLabel.text = [self getSoldQuantityTextForItem:item];
    if (item.thumbnailURL) {
        [itemCell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailURL]
                            placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
    }
    else {
        itemCell.thumbnailImageView.image = [UIImage imageNamed:kPlaceholderImageName];
    }
    
    return itemCell;
    
}

-(NSString*)getSoldQuantityTextForItem:(MLCItem*)item {
    MLCQuantityFormatter* quantityFormatter  = [MLCQuantityFormatter sharedQuantityFormatter];
    NSString* soldQuantityText;
    if (item.soldQuantity > 0) {
        NSNumber* soldQuantity = [NSNumber numberWithLongLong:item.soldQuantity];
        soldQuantityText = [NSString stringWithFormat:@"%@  %@",[quantityFormatter stringFromNumber:soldQuantity],NSLocalizedString(@"vendidos",nil)];
    }
    else {
        soldQuantityText = @"";
    }
    return soldQuantityText;

}

@end
