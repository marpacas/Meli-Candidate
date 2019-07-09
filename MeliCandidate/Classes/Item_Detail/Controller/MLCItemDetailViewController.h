//
//  MLCItemDetailViewController.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCItem.h"

/**
 A MLCItemDetailViewController shows detailed info of an item
 */

@interface MLCItemDetailViewController : UIViewController

@property(nonatomic, strong, nonnull) MLCItem* item;

@end
