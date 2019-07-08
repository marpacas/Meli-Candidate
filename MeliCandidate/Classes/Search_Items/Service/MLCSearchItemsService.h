//
//  MLCSearchItemsService.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MLCItem.h"

/**
 A MLCSearchItemsService 
 Endpoint : http://api.mercadolibre.com/sites/MLA/search?q=
 
 Life Cycle
 
  - Set up endpoint
  - Perform data task
  - In the completion handler get a JSON object from the response data
  - Pass the JSON object to the parser
  - Get the results (success or failure) from the parser
  - Return the results to the caller in the completion block
 
 */

@interface MLCSearchItemsService : NSObject

-(void)searchItemsThatContainText:(nonnull NSString*)textToSearch  completionBlock:(nullable void(^)(NSArray <MLCItem*> * _Nullable itemsList, NSError* _Nullable error))completionBlock;

@end
