//
//  MLCItemDetailViewController.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemDetailViewController.h"
#import "MLCItemDetailService.h"
#import "UIViewController+MLCCategory.h"
#import "MLCQuantityFormatter.h"
#import "MLCPriceFormatter.h"

@interface MLCItemDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityToBuyLabel;
@property (weak, nonatomic) IBOutlet UIStepper *quantityToBuyStepper;
@property (weak, nonatomic) IBOutlet UILabel *availableQuantityLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activityIndicatorView;

@property(nonatomic, strong) MLCItemDetailService* itemDetailService;

- (IBAction)buyAction:(id)sender;
- (IBAction)changeQuantityAction:(UIStepper *)sender;

@end

@implementation MLCItemDetailViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initOutlets];
    [self getItemDetail];
    
}

-(void)initOutlets {
    self.titleLabel.text = @"";
    self.conditionLabel.text = @"";
    self.soldQuantityLabel.text = @"";
    self.priceLabel.text = @"";
    self.sellerCityLabel.text = @"";
    self.sellerStatusLabel.text = @"";
    self.quantityToBuyLabel.text = @"";
    self.availableQuantityLabel.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Item Detail

-(void)getItemDetail {
    if (!self.itemDetailService) {
        self.itemDetailService = [MLCItemDetailService new];
        self.itemDetailService.item = self.item;
        
    }
    [self.activityIndicatorView startAnimating];
    [self.itemDetailService getItemDetailWithCompletionBlock:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self processResultWithError:error];

        });
    }];
}

-(void)processResultWithError:(NSError*)error {
    [self.activityIndicatorView stopAnimating];
    if (error) {
        [self showErrorWithTitle:NSLocalizedString(@"ERROR",nil) message:error.localizedDescription ];
    }
    else {
        [self setUpItemDetail];
    }
    
    
}

-(void)setUpItemDetail {
    self.pictureImageView.image = [UIImage imageNamed:@"placeholder_big"];
    self.titleLabel.text = self.item.title;
    self.conditionLabel.text = [self.item.condition capitalizedString];
    self.soldQuantityLabel.text = [self getSoldQuantityText];
    self.priceLabel.text = [self getPriceText];
    self.sellerCityLabel.text = self.item.seller.location.city;
    NSString* sellerString = NSLocalizedString(@"Vendedor ",nil);
    if ((self.item.seller.powerSellerStatus) && ([self.item.seller.powerSellerStatus respondsToSelector:@selector(length)])) {
        self.sellerStatusLabel.text = [sellerString  stringByAppendingString:self.item.seller.powerSellerStatus];
    }
    else {
        self.sellerStatusLabel.text = [sellerString  stringByAppendingString:NSLocalizedString(@"sin status", nil)];
        
    }
    self.quantityToBuyLabel.text = @"1";
    self.availableQuantityLabel.text = [self getAvailableQuantityText];
    
}

-(NSString*)getSoldQuantityText {
    MLCQuantityFormatter* quantityFormatter  = [MLCQuantityFormatter sharedQuantityFormatter];
    NSNumber* soldQuantity = [NSNumber numberWithLongLong:self.item.soldQuantity];
    return([NSString stringWithFormat:@"%@  %@",[quantityFormatter stringFromNumber:soldQuantity],NSLocalizedString(@"vendidos",nil)]);
}

-(NSString*)getPriceText {
    MLCPriceFormatter* priceFormatter  = [MLCPriceFormatter sharedPriceFormatter];
    return ([priceFormatter stringFromNumber:[NSNumber numberWithLongLong:self.item.price]]);
    
}

-(NSString*)getAvailableQuantityText {
    MLCQuantityFormatter* quantityFormatter  = [MLCQuantityFormatter sharedQuantityFormatter];
    NSNumber* availableQuantity = [NSNumber numberWithLongLong:self.item.availableQuantity];
    return([NSString stringWithFormat:@"%@  %@",[quantityFormatter stringFromNumber:availableQuantity],NSLocalizedString(@"disponibles",nil)]);
    
}

#pragma mark - Actions

- (IBAction)buyAction:(id)sender {
    [self showErrorWithTitle:@"" message:NSLocalizedString(@"En construcción", nil)];
}

- (IBAction)changeQuantityAction:(UIStepper *)sender {
    
    self.quantityToBuyLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
}



@end
