//
//  QbViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "QbViewController.h"
#import "DeailsViewController.h"


@interface QbViewController ()

@end

NSDictionary *dict1;
NSArray *arr;

@implementation QbViewController

- (void)viewDidLoad
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if(![def boolForKey:@"loginStatus"]) {
        [self performSegueWithIdentifier:@"Push1" sender:self];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self createButtons];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) createButtons{
    
    
    int tag = 1,row=3, coloumn=2;
    for(;row < 5;row++){
        for(;coloumn <7;coloumn++){
            
        UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        CGRect frame = CGRectMake((coloumn*30), row*30, 30, 10);
        [button setFrame:frame];
        button.tag = tag;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:[NSString stringWithFormat:@"%d",tag] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        
        tag++;
        }
        coloumn=2;
        
    }
    for(;row < 7;row++){
        coloumn=3;
        for(;coloumn <6;coloumn++){
            
            UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
            CGRect frame = CGRectMake((coloumn*30), row*30, 30, 10);
            [button setFrame:frame];
            button.tag = tag;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitle:[NSString stringWithFormat:@"%d",tag] forState:UIControlStateNormal];
            [self.scrollView addSubview:button];
            
            tag++;
        }
        
    }
}



-(void)buttonAction:(id)sender {
    NSLog(@"button pressed: %d", [sender tag]);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmployeeDetail" ofType:@"plist"];
//    dict1 = [[NSDictionary alloc] initWithContentsOfFile:path];
    arr=[[NSArray alloc]initWithContentsOfFile:path];
    int i= [sender tag]-1;
    dict1=[arr objectAtIndex:(i%3)];
    NSLog(@"Name %@",[dict1 objectForKey:@"1"]);
    [self performSegueWithIdentifier:@"showDetails" sender:self];

    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        
        DeailsViewController *det=segue.destinationViewController;
        det.dict=dict1;
        NSLog(@"saf %@",[det.dict objectForKey:@"1"]);
        NSLog(@"saf %@",[dict1 objectForKey:@"1"]);
    }
}

- (IBAction)logOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loginStatus"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     [self performSegueWithIdentifier:@"Push1" sender:self];

}


@end
