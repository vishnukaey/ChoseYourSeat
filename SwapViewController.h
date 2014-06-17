//
//  SwapViewController.h
//  SeatingAtQburst
//
//  Created by qbadmin on 09/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwapViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emp1;
@property (weak, nonatomic) IBOutlet UITextField *emp2;
@property (weak, nonatomic) IBOutlet UIButton *swap;
@property (strong, nonatomic) IBOutlet UIView *view;
@end
