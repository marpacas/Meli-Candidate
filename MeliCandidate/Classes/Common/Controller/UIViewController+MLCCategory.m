//
//  UIViewController+MLCCategory.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "UIViewController+MLCCategory.h"

@implementation UIViewController (MLCCategory)


#pragma mark - Errors UI

-(void)showErrorWithTitle:(nonnull NSString*)title message:(nonnull NSString*)errorMessage {
    [self showErrorWithTitle:title message:errorMessage completion:^{
    }];
    
}

-(void)showErrorWithTitle:(nonnull NSString*)title message:(nonnull NSString*)errorMessage completion:(nonnull void(^)())completion {
    UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle:title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert animated:YES completion:completion];
    
    
}

@end
