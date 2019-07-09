//
//  UIViewController+MLCCategory.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 A category for common view controllers methods 
 */

@interface UIViewController (MLCCategory)

-(void)showErrorWithTitle:(nonnull NSString*)title message:(nonnull NSString*)errorMessage;

-(void)showErrorWithTitle:(nonnull NSString*)title message:(nonnull NSString*)errorMessage completion:(nonnull void(^)())completion;

@end
