//
//  MLCSearchItemsViewController.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCItem.h"

/**  A MLCSearchItemsViewController
 Displays the search bar to the user and shows the found items
 */

@interface MLCSearchItemsViewController : UIViewController

@property(nonatomic, strong, nullable)NSArray <MLCItem*>* itemsList;

@end
