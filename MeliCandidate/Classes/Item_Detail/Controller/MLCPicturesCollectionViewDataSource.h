//
//  MLCPicturesCollectionViewDataSource.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A MLCPicturesCollectionViewDataSource implements the data source protocol to show the item's pictures in a collection view
 
 */


@interface MLCPicturesCollectionViewDataSource : NSObject

@property(nonatomic, strong, nonnull) NSArray <NSString*> * picturesURL;

@end
