//
//  MLCItemsListParser.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCItem.h"

/**
 A MLCItemsListParser receive a JSON Array , sends each object of the array to the item parser; on success vends a items list otherwise returns an error
 */

@interface MLCItemsListParser : NSObject

@property(nonatomic,strong,nullable) NSArray <MLCItem*>* itemsList;


-(nullable instancetype)initWithJSONArray:(nonnull NSArray*)JSONArray NS_DESIGNATED_INITIALIZER;

-(nullable NSError*)getItemsListFromJSONArray;

@end
