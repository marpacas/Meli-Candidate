//
//  MLCSearchItemsViewController.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCSearchItemsViewController.h"
#import "MLCItemsTableViewDataSource.h"
#import "MLCSearchItemsService.h"
#import "MLCItemDetailViewController.h"
#import "MLCConstants.h"
#import "UIViewController+MLCCategory.h"

@interface MLCSearchItemsViewController () <UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;
@property (strong, nonatomic) IBOutlet MLCItemsTableViewDataSource *itemsTableViewDataSource;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activityIndicatorView;

@property (nonatomic, strong)MLCSearchItemsService* searchItemsService;

@end

@implementation MLCSearchItemsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerNibForItemCell];

}

-(void)registerNibForItemCell {
    UINib* itemCellNib = [UINib nibWithNibName:kItemCellNib bundle:[NSBundle mainBundle]];
    [self.itemsTableView registerNib:itemCellNib forCellReuseIdentifier:kItemCellIdentifier];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self. itemsList = [NSArray new];
}

#pragma mark - Search methods

-(void)searchItemsThatContainsText:(NSString*)textToSearch {
    if (!self.searchItemsService) {
        self.searchItemsService = [MLCSearchItemsService new];
        
    }
    [self.activityIndicatorView startAnimating];
    [self.searchItemsService searchItemsThatContainText:textToSearch completionBlock:^(NSArray<MLCItem *> * _Nullable itemsList, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self processResultForItems:itemsList error:error];
        });
    }];

}

-(void)processResultForItems:(NSArray<MLCItem*> *)itemsList error:(NSError*)error {
    [self.activityIndicatorView stopAnimating];
    if (error) {
        [self showErrorWithTitle:NSLocalizedString(@"ERROR",nil) message:error.localizedDescription ];
    }
    else {
        if (itemsList.count > 0) {
            self.itemsList = itemsList;
            self.itemsTableViewDataSource.itemsList = self.itemsList;
            [self.itemsTableView reloadData];
            
        }
        else {
            [self showErrorWithTitle:NSLocalizedString(@"",nil) message:NSLocalizedString(@"No se encontraron resultados para la búsqueda",nil)];
        }
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSInteger selectedRow = self.itemsTableView.indexPathForSelectedRow.row;
    MLCItem* selectedItem = self.itemsList[selectedRow];
    MLCItemDetailViewController* itemDetailViewController = (MLCItemDetailViewController*)[segue destinationViewController];
    itemDetailViewController.item = selectedItem;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kShowItemDetailSegue sender:indexPath];//Xcode bug : Storyboard's selection segue not working for custom cells
}

#pragma mark - Search Bar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchItemsThatContainsText:searchBar.text];
    [searchBar resignFirstResponder];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
}
@end
