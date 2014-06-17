//
//  SwapViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 09/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "SwapViewController.h"
#import <Parse/Parse.h>

@interface SwapViewController (){
    NSString *path;
    NSMutableArray *names;
    UIPickerView *pickView1;
    int flag;
    PFQuery *queryAlloc,*queryEmp;
    PFObject *objectAlloc;
}
@end

@implementation SwapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    queryAlloc=[PFQuery queryWithClassName:@"AllocateSeat"];
    queryEmp=[PFQuery queryWithClassName:@"EmployeeDetails"];
    [queryEmp selectKeys:@[@"Name",@"empId"]];
    [queryEmp findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@",objects);
        names=[objects mutableCopy];
    }];
}


- (IBAction)swap:(id)sender {
    NSString *empid1,*empid2;
    
    //Finding the ID of both names from employee database and swapping the seatTags in the database
    
    for(int k=0;k<names.count;k++)
    {
        if([[[names objectAtIndex:k] valueForKey:@"Name"] isEqualToString:self.emp1.text]){
            empid1=[[names objectAtIndex:k] valueForKey:@"empId"];
        }
        else if([[[names objectAtIndex:k] valueForKey:@"Name"] isEqualToString:self.emp2.text])
            empid2=[[names objectAtIndex:k] valueForKey:@"empId"];
    }
    NSLog(@"%@",empid1);
    [queryAlloc whereKey:@"empId" equalTo:empid1];
    [queryAlloc getFirstObjectInBackgroundWithBlock:^(PFObject *objects, NSError *error) {
        NSString *swp= objects[@"seatTag"];
        [queryAlloc whereKey:@"empId" equalTo:empid2];
        PFObject *object2=[queryAlloc getFirstObject];
        NSString *swp2=object2[@"seatTag"];
        [objects setObject:swp2 forKey:@"seatTag"];
        [object2 setObject:swp forKey:@"seatTag"];
        [objects saveInBackground];
        [object2 saveInBackground];
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
    }

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Same pickerView is used for both the textfields. Flag differentiates which textfield is active
    
    [self addPickerView];
    if(textField == self.emp1){
        flag=1;
    }
    else {
        flag=0;
    }
    textField.text = [[names objectAtIndex:0] valueForKey:@"Name"];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)addPickerView{
    [pickView1 reloadAllComponents];
    if(pickView1) {
        return;
    }
    [self.emp1 resignFirstResponder];
    pickView1 = [[UIPickerView alloc]init];
    pickView1.dataSource = self;
    pickView1.delegate = self;
    [pickView1 selectRow:0 inComponent:0 animated:YES];
    pickView1.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style: UIBarButtonItemStyleDone
                                   target:self action:@selector(doneButton:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, 50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    self.emp1.inputView = pickView1;
    self.emp1.inputAccessoryView = toolBar;
    self.emp2.inputView = pickView1;
    self.emp2.inputAccessoryView = toolBar;
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
        return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [names count];
}



#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if (flag==1)
    [self.emp1 setText:[[names objectAtIndex:row] valueForKey:@"Name"]];
    else
    [self.emp2 setText:[[names objectAtIndex:row] valueForKey:@"Name"]];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [[names objectAtIndex:row] valueForKey:@"Name"];
}


-(void)doneButton:(id)sender {
    [pickView1 removeFromSuperview];
    pickView1 = nil;
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
