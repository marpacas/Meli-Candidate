//
//  MLCConstants.h
//  MeLiCandiadte
//
//  Created by Martha Patricia Castillo Fuentes on 7/4/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kBaseURL;
extern NSString* const kMLCDomain;
extern NSString* const kSite;



//Enums

typedef NS_ENUM(NSInteger, HTTPStatusCodes) {
    ok = 200,
    badRequest = 400,
    notFound = 404,
};

//Nib & Cell Identifiers

extern NSString* const kItemCellIdentifier; 
extern NSString* const kItemCellNib;
extern NSString* const kPictureCellIdentifier;
extern NSString* const kPictureCellNib;

//Segue Identifiers

extern NSString* const kShowItemDetailSegue;

//Image names

extern NSString* const kPlaceholderImageName;
extern NSString* const kBigPlaceholderImageName;
