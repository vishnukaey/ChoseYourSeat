//
//  DeailsViewController.h
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DeailsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Age;
@property (weak, nonatomic) IBOutlet UILabel *Skill;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UILabel *Phone;
@property (weak, nonatomic) IBOutlet UILabel *Sex;
@property (weak, nonatomic) IBOutlet UILabel *Seat;
@property (weak, nonatomic) IBOutlet UILabel *Empid;
@property (weak, nonatomic) IBOutlet UILabel *project;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property(strong,nonatomic) NSString *pressedEmp;
@end
