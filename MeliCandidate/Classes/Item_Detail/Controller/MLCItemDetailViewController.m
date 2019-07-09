//
//  MLCItemDetailViewController.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemDetailViewController.h"
#import "MLCPicturesCollectionViewDataSource.h"
#import "MLCItemDetailService.h"
#import "UIViewController+MLCCategory.h"
#import "MLCQuantityFormatter.h"
#import "MLCPriceFormatter.h"
#import "MLCConstants.h"

@interface MLCItemDetailViewController () <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *picturesCollectionView;
@property (strong, nonatomic) IBOutlet MLCPicturesCollectionViewDataSource *picturesCollectionViewDataSource;

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
    [self registerNibForPictureCell];
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

-(void)registerNibForPictureCell {
    UINib* pictureCellNib = [UINib nibWithNibName:kPictureCellNib bundle:[NSBundle mainBundle]];
    [self.picturesCollectionView registerNib:pictureCellNib forCellWithReuseIdentifier:kPictureCellIdentifier];
    
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
    self.titleLabel.text = self.item.title;
    self.conditionLabel.text = [self.item.condition capitalizedString];
    if (self.item.soldQuantity > 0) {
        self.soldQuantityLabel.text = [self getSoldQuantityText];

    }
    else {
        self.soldQuantityLabel.text = @"";
    }
    self.priceLabel.text = [self getPriceText];
     self.sellerCityLabel.text = self.item.seller.location.city;
    [self setUpSellerStatusText];
    self.quantityToBuyLabel.text = @"1";
    self.availableQuantityLabel.text = [self getAvailableQuantityText];
    if (self.item.picturesURL.count > 0) {
        self.picturesCollectionViewDataSource.picturesURL =  self.item.picturesURL;
    }
    else {
        if (self.item.thumbnailURL) {
            self.picturesCollectionViewDataSource.picturesURL = [NSArray arrayWithObject:self.item.thumbnailURL];

        }
    }
    [self.picturesCollectionView reloadData];
    
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

-(void)setUpSellerStatusText {
    NSString* sellerString = NSLocalizedString(@"Vendedor ",nil);
    if ((self.item.seller.powerSellerStatus) && ([self.item.seller.powerSellerStatus respondsToSelector:@selector(length)])) {
        self.sellerStatusLabel.text = [sellerString  stringByAppendingString:self.item.seller.powerSellerStatus];
    }
    else {
        self.sellerStatusLabel.text = [sellerString  stringByAppendingString:NSLocalizedString(@"sin status", nil)];
        
    }

}

#pragma mark - Actions

- (IBAction)buyAction:(id)sender {
    [self showErrorWithTitle:@"" message:NSLocalizedString(@"En construcción", nil)];
}

- (IBAction)changeQuantityAction:(UIStepper *)sender {
    
    self.quantityToBuyLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
}

#pragma mark - Collection View Delegate

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(self.picturesCollectionView.bounds.size.width,self.picturesCollectionView.bounds.size.height);
}


@end
