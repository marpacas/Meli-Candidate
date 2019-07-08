//
//  MCLItem.h
//  MeliCandidate
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCSeller.h"
#import "MLCLocation.h"

/**
 A class that stores the basic info of an item
 */

@interface MLCItem : NSObject

@property (nonatomic,strong,nonnull) NSString* itemIdentification;
@property (nonatomic,strong,nonnull) NSString* title;
@property (nonatomic,strong,nonnull) NSString* condition;
@property (nonatomic,assign) long long price;
@property (nonatomic,assign) long long soldQuantity;
@property (nonatomic,assign) long long availableQuantity;
@property (nonatomic,strong,nullable) NSString* thumbnailURL;
@property (nonatomic,strong,nullable) NSArray <NSString*>* picturesURL;

@property (nonatomic,strong,nonnull) MLCLocation* location;
@property (nonatomic,strong,nonnull) MLCSeller* seller;


-(nullable instancetype)initWithIdentification:(nonnull NSString*)itemIdentification title:(nonnull NSString*)title condition:(nonnull NSString*)condition seller:(nonnull MLCSeller*)seller;

-(BOOL)isEqualToItem:(nullable MLCItem*)otherItem;


@end
