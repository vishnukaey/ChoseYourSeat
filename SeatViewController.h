//
//  SeatViewController.h
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeatViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *swap;
@property (weak, nonatomic) IBOutlet UIButton *deleteEmp;
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewIn;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOut;
@property (weak, nonatomic) IBOutlet UIScrollView *seatPicker;
@property (assign,nonatomic) NSInteger tag2;
@end
