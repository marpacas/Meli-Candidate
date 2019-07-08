//
//  MLCItemDetailService.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCItem.h"

/**
 A MLCSearchItemsService
 Endpoint : http://api.mercadolibre.com/items/:id
 Service Structure
 - Set up the endpoint
 - Perform data task
 - In the completion handler get a JSON object from the response data
 - Pass the JSON object to the parser
 - Get the results (success or failure) from the parser
 - In the completion block return the results to the caller

 */

@interface MLCItemDetailService : NSObject

@property(nonatomic,strong,nonnull)MLCItem* item;


-(void)getItemDetailWithCompletionBlock:(nullable void(^)( NSError* _Nullable error))completionBlock;


@end
