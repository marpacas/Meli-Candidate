//
//  MLCPicturesCollectionViewDataSource.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCPicturesCollectionViewDataSource.h"
#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MLCPictureCollectionViewCell.h"
#import "MLCConstants.h"

@interface MLCPicturesCollectionViewDataSource () <UICollectionViewDataSource>


@end

@implementation MLCPicturesCollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picturesURL.count;
}

-(void)resetPictureCellForReuse:(MLCPictureCollectionViewCell*)pictureCell {
    pictureCell.pictureImageView.image = nil;
}

-(UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MLCPictureCollectionViewCell *pictureCell = (MLCPictureCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kPictureCellIdentifier forIndexPath:indexPath ];
    [self resetPictureCellForReuse:pictureCell];
    
    NSString* pictureURL = self.picturesURL[indexPath.row];
    [pictureCell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:pictureURL]
                          placeholderImage:[UIImage imageNamed:kBigPlaceholderImageName]];
    
    return pictureCell;

    
}

@end
