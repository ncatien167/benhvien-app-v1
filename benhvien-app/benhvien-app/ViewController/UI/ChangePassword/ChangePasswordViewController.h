//
//  ChangePasswordViewController.h
//  benhvien-app
//
//  Created by AnhTien on 9/11/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nnewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPasswordTextField;

@end
