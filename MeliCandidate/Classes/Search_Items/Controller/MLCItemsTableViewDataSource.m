//
//  MLCItemsTableViewDataSoruce.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemsTableViewDataSource.h"
#import <UIKit/UIKit.h>
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLCItemTableViewCell* itemCell = (MLCItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:kItemCellIdentifier forIndexPath:indexPath];
    
    MLCItem* item = self.itemsList[indexPath.row];
    itemCell.titleLabel.text = item.title;
    itemCell.cityLabel.text = item.location.city;
    MLCPriceFormatter* priceFormatter  = [MLCPriceFormatter sharedPriceFormatter];
    itemCell.priceLabel.text = [priceFormatter stringFromNumber:[NSNumber numberWithLongLong:item.price]];
    MLCQuantityFormatter* quantityFormatter  = [MLCQuantityFormatter sharedQuantityFormatter];
    NSNumber* soldQuantity = [NSNumber numberWithLongLong:item.soldQuantity];
    itemCell.soldQuantityLabel.text = [NSString stringWithFormat:@"%@  %@",[quantityFormatter stringFromNumber:soldQuantity],NSLocalizedString(@"vendidos",nil)];
    itemCell.thumbnailImageView.image = [UIImage imageNamed:@"placeholder"];
    
    return itemCell;
    
}

@end
