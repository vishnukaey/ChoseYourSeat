//
//  NewEmployeeViewController.h
//  SeatingAtQburst
//
//  Created by qbadmin on 05/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewEmployeeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Age;
@property (weak, nonatomic) IBOutlet UITextField *Skill;
@property (weak, nonatomic) IBOutlet UIScrollView *empScrollView;
@property (weak, nonatomic) IBOutlet UIView *empview;
@property (weak, nonatomic) IBOutlet UITextField *Address;
@property (weak,nonatomic) IBOutlet UIButton *Submit;
@property (weak, nonatomic) IBOutlet UITextField *empId;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *project;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *empEmail;
@end
