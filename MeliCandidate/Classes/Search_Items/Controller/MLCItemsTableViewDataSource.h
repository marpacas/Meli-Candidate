//
//  MLCItemsTableViewDataSoruce.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCItem.h"

/**
 A MLCItemsTableViewDataSource implements the data source protocol for the items table view
 
 */

@interface MLCItemsTableViewDataSource : NSObject

@property(nonatomic, strong, nonnull) NSArray <MLCItem*> * itemsList;



@end
