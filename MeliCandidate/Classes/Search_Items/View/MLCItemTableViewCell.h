//
//  MLCItemTableViewCell.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A cell that shows  the basic info for an item
 */


@interface MLCItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end
