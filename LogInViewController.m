//
//  LogInViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.Password.secureTextEntry = YES;
    [self.Name resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.Name)
        [self.Password becomeFirstResponder];
    else
        [ self Login:nil];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Lifting the login view on keyboard appear
    self.logInContainer.frame = CGRectMake(self.logInContainer.frame.origin.x,
                                  self.logInContainer.frame.origin.y-50,
                                  self.logInContainer.frame.size.width,
                                  self.logInContainer.frame.size.height);   //resize

}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //Drop the login view on keyboard disappear

    self.logInContainer.frame = CGRectMake(self.logInContainer.frame.origin.x,
                                           self.logInContainer.frame.origin.y+50,
                                           self.logInContainer.frame.size.width,
                                           self.logInContainer.frame.size.height);
}

- (IBAction)Login:(id)sender {
    [self.Name resignFirstResponder];
    [self.Password resignFirstResponder];
//    if([self.Name.text isEqualToString:@"qburst"] && [self.Password.text isEqualToString:@"qburst"] ){
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:YES forKey:@"loginStatus"];
//        [defaults synchronize];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    else if([self.Name.text isEqualToString:@""] || [self.Password.text isEqualToString:@""] )
//        [self showAlert2];
//    else
//        [self showAlert1];
//}

    [PFUser logInWithUsernameInBackground:self.Name.text password:self.Password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                            [defaults setBool:YES forKey:@"loginStatus"];
                                            [defaults synchronize];
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        }
                                        
                                        else {
                                        [self showAlert1];
                                        }
                                    }];
    
    
}
- (void) showAlert1 {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Error!"
                          message:@"Your Entry is Incorrect"
                          delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil];
        [alert show];
}

- (void) showAlert2 {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Error!"
                          message:@"Enter username and password to login"
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
