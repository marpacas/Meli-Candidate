//
//  MLCSeller.h
//  MeLiCandiadte
//
//  Created by Martha Patricia Castillo Fuentes on 7/4/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCLocation.h"

/**
 A class that stores the basic info of a seller
 */

@interface MLCSeller : NSObject

@property (nonatomic,strong,nonnull) NSString* sellerIdentification;
@property (nonatomic,strong,nonnull) NSString* nickName;
@property (nonatomic,strong,nullable) NSString*powerSellerStatus;
@property (nonatomic,strong,nonnull) MLCLocation* location;

-(nullable instancetype)initWithIdentification:(nonnull NSString*)sellerIdentification nickName:(nonnull NSString*)nickName;

-(BOOL)isEqualToSeller:(nullable MLCSeller*)otherSeller;


@end
