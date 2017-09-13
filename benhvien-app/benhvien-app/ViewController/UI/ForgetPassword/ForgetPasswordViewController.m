//
//  ForgetPasswordViewController.m
//  benhvien-app
//
//  Created by AnhTien on 9/11/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.sendCodeButton.layer.cornerRadius = 4.0;
    self.title = @"Quên mật khẩu";
    NSDictionary *buttonAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)];
    [doneButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ bỏ" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed:)];
    [cancelButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (IBAction)doneButtonPressed:(id)sender {
    
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
