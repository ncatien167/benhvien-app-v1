//
//  LoginViewController.h
//  benhvien-app
//
//  Created by 507-3 on 9/6/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *signInUpSegment;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UIView *signInContentView;
@property (weak, nonatomic) IBOutlet UIView *signUpContentView;
@property (weak, nonatomic) IBOutlet UITextField *enterUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterPasswordTextField;
@property (strong, nonatomic) NSString *places;

- (IBAction)segmentPressed:(UISegmentedControl *)sender;

@end
