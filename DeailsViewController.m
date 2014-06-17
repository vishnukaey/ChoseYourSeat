//
//  DeailsViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "DeailsViewController.h"
#import <Parse/Parse.h>

@interface DeailsViewController (){
    PFQuery *querySeat,*queryEmp,*queryAlloc;
}

@end

@implementation DeailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


//Fetch all the seats of the pressed seat from the Parse database using the tag of the pressed seat
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Parse setApplicationId:@"BMpSHaf4ahwba7cJ4wYdy0wsfnpA3QfiItEUHGfO"
                  clientKey:@"oRaYJeG2JTl9eWvZBd23n70npkflh185qJSgeXg6"];
    queryEmp=[PFQuery queryWithClassName:@"EmployeeDetails"];
    [queryEmp whereKey:@"empId" equalTo:self.pressedEmp];
    [queryEmp findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                self.Name.text=[object objectForKey:@"Name"];
                self.Age.text=[object objectForKey:@"Age"];
                self.Skill.text=[object objectForKey:@"Skill"];
                self.Address.text=[object objectForKey:@"Address"];
                self.Phone.text=[object objectForKey:@"phoneNumber"];
                self.Sex.text=[object objectForKey:@"Sex"];
                self.Seat.text=[object objectForKey:@"Current"];
                self.Empid.text=[object objectForKey:@"empId"];
                self.project.text=[object objectForKey:@"Project"];
                self.Address.adjustsFontSizeToFitWidth = YES;
                self.img.image = [UIImage imageNamed:@"download (6).jpeg"];
            }
        }
    }];
    
    [queryAlloc whereKey:@"empId" equalTo:self.pressedEmp];
    [queryAlloc findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"SeatTag po %d",[[[objects objectAtIndex:0] valueForKey:@"seatTag"] integerValue]);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
