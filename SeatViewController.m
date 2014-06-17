//
//  SeatViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 04/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "SeatViewController.h"
#import "DeailsViewController.h"
#import "NoSeatViewController.h"
#import <Parse/Parse.h>

@interface SeatViewController () {
    float i;
    NSArray *plistArray;
    NSString *pressedEmp;
    UITextField *text1;
    UIPickerView *pickView1;
    NSArray *pickArray;
    UIView *section1View;
    UIView *section2View;
    int flag;
    NSString *path;
    int deleteEmpStatus;
    PFQuery *querySeat,*queryEmp,*queryAlloc;
}
@end

@implementation SeatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if(![def boolForKey:@"loginStatus"]) {
        [self performSegueWithIdentifier:@"Push1" sender:self];
    }
    [self createViews];
    [Parse setApplicationId:@"BMpSHaf4ahwba7cJ4wYdy0wsfnpA3QfiItEUHGfO"
                  clientKey:@"oRaYJeG2JTl9eWvZBd23n70npkflh185qJSgeXg6"];
    querySeat=[PFQuery queryWithClassName:@"Seat"];
    queryEmp=[PFQuery queryWithClassName:@"EmployeeDetails"];
}



-(void) viewWillAppear:(BOOL)animated{
    [self appear];  
}


-(void) appear{
//Give seats to all the Employees whose seatTags are not NULL
    queryAlloc=[PFQuery queryWithClassName:@"AllocateSeat"];
    [queryAlloc whereKey:@"seatTag" notEqualTo:@""];
    [queryAlloc findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%d", [[object valueForKey:@"seatTag"] integerValue]);
                int tag=[[object valueForKey:@"seatTag"] integerValue];
                for(UIView *view in section1View.subviews) {
                    UIButton *butn1 = (UIButton *)[section1View viewWithTag:tag];
                    if(butn1) {
                        butn1.backgroundColor=[UIColor greenColor];
                        butn1.tintColor=[UIColor greenColor];
                    }
                }
                for(UIView *view in section2View.subviews) {
                    UIButton *butn2 = (UIButton *)[section2View viewWithTag:tag];
                    if(butn2) {
                        butn2.backgroundColor=[UIColor greenColor];
                        butn2.tintColor=[UIColor greenColor];
                    }
                    
                    
                }

            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


-(void) createViews{
    deleteEmpStatus=0;
    path = [[NSBundle mainBundle] pathForResource:@"EmployeeDetail" ofType:@"plist"];
    //Creating 2 sections of Seating
    plistArray =[[NSArray alloc]initWithContentsOfFile:path];
    section1View = [[UIView alloc] initWithFrame:CGRectMake(0,60 , 320,1000) ];
    section2View = [[UIView alloc] initWithFrame:CGRectMake(0,60 ,  1000,500) ];
    [self.scrollView addSubview:section1View];
    // create views and buttons for Section A
    int tag = 1,row=0, coloumn=1;
    UIButton *button;
    for(;coloumn < 4;coloumn++){
        for(;row <9;row++){
            UIView *myAddedView = [[UIView alloc] initWithFrame:CGRectMake(70.0f*coloumn, 70.0f*row, 65.0f, 65.0f)];
            myAddedView.backgroundColor = [UIColor redColor];
            [section1View addSubview:myAddedView];
            //Creating 4 seats of a cublicle
            for(int k=1;k<4;k=k+2){
                for(int l=1;l<4;l=l+2){
                    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    button.backgroundColor=[UIColor blackColor];
                    button.tintColor=[UIColor blackColor];
                    [button addTarget:self
                               action:@selector(ButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:@"Show View" forState:UIControlStateNormal];
                    button.frame = CGRectMake(14*l, 14*k, 12, 12);
                    button.tag = tag;
                    [myAddedView addSubview:button];
                    tag++;
                }
            }
        }
        row=0;
    }
    row=1, coloumn=1;
    // create views and buttons for Section 2
    for(;coloumn < 4;coloumn++){
        for(;row <3;row++){
            UIView *myAddedView = [[UIView alloc] initWithFrame:CGRectMake(70.0f*coloumn, 70.0f*row, 65.0f, 65.0f)];
            myAddedView.backgroundColor = [UIColor redColor];
            [section2View addSubview:myAddedView];
            //Create 4 seats of the cubicle of Section 2
            for(int k=1;k<4;k=k+2){
                for(int l=1;l<4;l=l+2){
                    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    button.backgroundColor=[UIColor blackColor];
                    button.tintColor=[UIColor blackColor];
                    [button addTarget:self
                               action:@selector(ButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:@"Show View" forState:UIControlStateNormal];
                    button.frame = CGRectMake(14*l, 14*k, 12, 12);
                    button.tag = tag;
                    [myAddedView addSubview:button];
                    tag++;
                }
            }
        }row=1;
    }
}

//Picker view to toggle between the two section of seats
- (IBAction)seatPicker:(id)sender {
    [self addPickerView];
}

- (IBAction)search:(id)sender {
    NSString *searchName=self.searchBar.text;
    [queryEmp whereKey:@"Name" equalTo:searchName];
    [queryEmp findObjectsInBackgroundWithBlock:^(NSArray *object2, NSError *error) {
        if(object2.count !=0){
            pressedEmp=[[object2 objectAtIndex:0] valueForKey:@"empId"];
            [self finishSearch];
                    }
        else
        NSLog(@"No results");
    }];
}

-(void) finishSearch{
[self performSegueWithIdentifier:@"showDetails2" sender:self];
}

//Set Action for on tapping a seat
-(void)ButtonAction:(id)sender {
    NSLog(@"button pressed: %d", [sender tag]);
    UIButton *but = (UIButton*)[self.view viewWithTag:[sender tag]];
    UIColor *color= [but backgroundColor];
    
//    Delete key is not pressed means show details
    if(deleteEmpStatus == 0){
        if([color isEqual:[UIColor blackColor]]){
        _tag2=[sender tag];
        [self performSegueWithIdentifier:@"noSeat" sender:self];
        }
        
        // For Filled Seat tap
        else
        {
            NSString *tgstring = [NSString stringWithFormat:@"%d", [sender tag]];
            [queryAlloc whereKey:@"seatTag" equalTo:tgstring];
            [queryAlloc findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        for (PFObject *object in objects) {
                            pressedEmp=[object valueForKey:@"empId"];
                            NSLog(@"%@",[object valueForKey:@"empId"]);
                
                [self performSegueWithIdentifier:@"showDetails2" sender:self];
                        }
                    }
                }];
            }
        }
    else{
        deleteEmpStatus=0;
            NSString *tgstring = [NSString stringWithFormat:@"%d", [sender tag]];
        [queryAlloc whereKey:@"seatTag" equalTo:tgstring];
        PFObject *object=[queryAlloc getFirstObject];
        [object setValue:@"" forKey:@"seatTag"];
        [object save];
        [section1View removeFromSuperview];
        [section2View removeFromSuperview];
        section1View=Nil;
        section2View=Nil;
        [self createViews];
        [self appear];
        [self showDeletedMessage:@"Successfully removed from seat !" atPoint:(CGPointMake(160.0, 10.0))];
    }
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    show deatils for filled seat
    if ([segue.identifier isEqualToString:@"showDetails2"]) {
        DeailsViewController *det=segue.destinationViewController;
        det.pressedEmp=pressedEmp;
            
        }
//    show people not allocated seats for vacant
    else if ([segue.identifier isEqualToString:@"noSeat"]) {
         NoSeatViewController *nes=segue.destinationViewController;
            nes.tag3=self.tag2;
        }
    }
- (IBAction)deleteEmp:(id)sender {
    deleteEmpStatus=1;
    [self showDeletedMessage:@"Tap a seat to delete !" atPoint:(CGPointMake(160.0, 10.0))];
    }

- (IBAction)logOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loginStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"Push1" sender:self];
}


//Picker view to select the section of seats
-(void)addPickerView{
    if(pickView1) {
        return;
    }
    pickArray = [[NSArray alloc]initWithObjects:@"Section A",
                   @"Section B", nil];
    text1 = [[UITextField alloc]initWithFrame:
                   CGRectMake(10, 40, 300, 30)];
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.textAlignment = NSTextAlignmentCenter;
    text1.delegate = self;
    [self.scrollView addSubview:text1];
    [text1 setPlaceholder:@"Tap to select a Section"];
    pickView1 = [[UIPickerView alloc]init];
    pickView1.dataSource = self;
    pickView1.delegate = self;
    [pickView1 selectRow:flag inComponent:0 animated:YES];
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
    text1.inputView = pickView1;
    text1.inputAccessoryView = toolBar;
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [pickArray count];
}


#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    [text1 setText:[pickArray objectAtIndex:row]];
    if(row==0){
        flag=0;
        [section2View removeFromSuperview];
        [self.scrollView addSubview:section1View];
    }else{
        flag=1;
        [section1View removeFromSuperview];
        [self.scrollView addSubview:section2View];
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickArray objectAtIndex:row];
}


- (void)showDeletedMessage:(NSString*)message atPoint:(CGPoint)point {
    const CGFloat fontSize = 12;
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica-bold" size:fontSize];
    label.alpha=0.7;
    label.text = message;
    label.textColor = [UIColor redColor];
    [label sizeToFit];
    label.center = point;
    [self.scrollView addSubview:label];
    [UIView animateWithDuration:0.3 delay:1 options:0 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        label.hidden = YES;
        [label removeFromSuperview];
    }];
}


 -(void)doneButton:(id)sender {
     [text1 removeFromSuperview];
     pickView1 = nil;
 }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.scrollViewIn endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
