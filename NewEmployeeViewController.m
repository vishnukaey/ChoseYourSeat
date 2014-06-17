//
//  NewEmployeeViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 05/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "NewEmployeeViewController.h"
#import <Parse/Parse.h>

@interface NewEmployeeViewController (){
    int error;
    NSArray *errorList;
}

@end

@implementation NewEmployeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    errorList = @[@"Firstname Missing", @"Secondname Missing",@"Email Id Missing",@"Phone Number Missing",@"Password Missing",@"Password Missing",@"Invalid MailID",@"Invalid Phone Number", @"Password Mismatch",@"Login Successful"];
}


//Adding all the Employee deatils to the parse database
- (IBAction)Submit:(id)sender {

        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        NSString *phoneRegex = @"^\([0-9]{10})";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        
        
        
        if([self.Name.text isEqualToString: @""]){
            error=0;
            [self showAlert];
            
        }
        else if([self.empId.text isEqualToString: @""]){
            error=1;
            [self showAlert];
            
        }
        else if([self.Age.text isEqualToString: @""]){
            error=2;
            [self showAlert];
            
        }
        
        else if([self.PhoneNumber.text isEqualToString: @""]){
            error=3;
            [self showAlert];
            
        }
        else if([self.sex.text isEqualToString: @""]){
            error=4;
            [self showAlert];
            
        }
        else if([self.empEmail.text isEqualToString: @""]){
            error=5;
            [self showAlert];
            
        }
        else if (![emailTest evaluateWithObject:self.empEmail.text ] == YES)
        {
            error = 6;
            [self showAlert];
        }
        
        else if (![phoneTest evaluateWithObject:self.PhoneNumber.text ] == YES)
        {
            error = 7;
            [self showAlert];
        }
        else if(error == 8){
            
            [self showAlert];
        }
    
    if(error==-1){
        PFObject *empAdd =[PFObject objectWithClassName:@"EmployeeDetails"];
        empAdd[@"Name"]=self.Name.text;
        empAdd[@"Age"]=self.Age.text;
        empAdd[@"Skill"]=self.Skill.text;
        empAdd[@"Address"]=self.Address.text;
        empAdd[@"phoneNumber"]=self.PhoneNumber.text;
        empAdd[@"project"]=self.project.text;
        empAdd[@"sex"]=self.sex.text;
        empAdd[@"emailId"]=self.empEmail.text;
        empAdd[@"empId"]=self.empId.text;
        [empAdd saveInBackground];
        PFObject *emp =[PFObject objectWithClassName:@"AllocateSeat"];
        emp[@"empId"]=self.empId.text;
        emp[@"seatTag"]=@"";
        [emp saveEventually];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    }



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.Name)
        [self.empId becomeFirstResponder];
    else if(textField == self.empId)
        [self.Age becomeFirstResponder];
    else if(textField == self.Age)
        [self.Address becomeFirstResponder];
    else if(textField == self.Address)
        [self.Skill becomeFirstResponder];
    else if(textField == self.Skill)
        [self.sex becomeFirstResponder];
    else if(textField == self.sex)
        [self.project becomeFirstResponder];
    else if(textField == self.project)
        [self.PhoneNumber becomeFirstResponder];
    else if(textField == self.PhoneNumber)
        [self.empEmail becomeFirstResponder];
    else if(textField == self.empEmail)
    [self Submit:nil];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void) showAlert {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Error!"
                          message:[errorList objectAtIndex:error]
                          delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil];
    
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

