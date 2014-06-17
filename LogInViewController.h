//
//  LogInViewController.h
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UIButton *Login;
@property (weak, nonatomic) IBOutlet UIView *logInContainer;


@end