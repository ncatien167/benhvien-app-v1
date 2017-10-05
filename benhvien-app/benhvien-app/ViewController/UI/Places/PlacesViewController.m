//
//  PlacesViewController.m
//  benhvien-app
//
//  Created by AnhTien on 9/11/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "PlacesViewController.h"
#import "PlacesTableViewCell.h"
#import "LoginViewController.h"

@interface PlacesViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITextField *_searchTextField;
    HNKGooglePlacesAutocompleteQuery *query;
    NSArray *_searchResults;
}
@end

@implementation PlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    query = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    _searchResults = [NSArray new];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.contentTableView.estimatedRowHeight = 44.0;
    [self showCancelButton];
    NSDictionary *buttonAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ bỏ" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed:)];
    [cancelButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    
    _searchTextField = [self searchBox];
    UIView *wrapperView = [[UIView alloc] initWithFrame:_searchTextField.frame];
    [wrapperView addSubview:_searchTextField];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:wrapperView];
    self.navigationItem.leftBarButtonItems = @[cancelButton, searchButton];
}

- (UITextField *)searchBox {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat textFieldWidth = (260.0/375.0) * screenWidth;
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, textFieldWidth, 30.0)];
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.layer.borderWidth = 0.5;
    searchTextField.layer.cornerRadius = 4.0;
    searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.font = [UIFont systemFontOfSize:15.0];
    searchTextField.placeholder = @"Tỉnh/Thành phố";
    searchTextField.delegate = self;
    return searchTextField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *searchTextField = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [query fetchPlacesForSearchQuery:searchTextField
                          completion:^(NSArray *places, NSError *error)  {
                               if (error) {
                                   NSLog(@"ERROR: %@", error);
                               } else {
                                   _searchResults = places;
                                   [self.contentTableView reloadData];
                               }
                          }];
    return true;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlacesTableViewCell *cell = (PlacesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PlacesTableViewCell"];
    HNKGooglePlacesAutocompletePlace *data = _searchResults[indexPath.row];
    cell.placesLable.text = data.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onGetPlacesCity) {
        HNKGooglePlacesAutocompletePlace *data = _searchResults[indexPath.row];
        self.onGetPlacesCity(data.name, self);
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Xác nhận"
                                         message:@"Bạn có chắc chắn muốn huỷ bỏ?"
                               cancelButtonTitle:@"Cancel"
                          destructiveButtonTitle:@"YES"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                
                                            } else if (buttonIndex == controller.destructiveButtonIndex) {
                                                [self.navigationController dismissViewControllerAnimated:true completion:nil];
                                            } else if (buttonIndex >= controller.firstOtherButtonIndex) {
                                                
                                            }
                                        }];
}

@end
