//
//  NoSeatViewController.m
//  SeatingAtQburst
//
//  Created by qbadmin on 06/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import "NoSeatViewController.h"
#import "SeatViewController.h"
#import <Parse/Parse.h>
#import "TableCell.h"

@interface NoSeatViewController (){
    NSMutableArray *arr;
    int count;
    PFQuery *querySeat,*queryEmp,*queryAlloc;
}

@end

@implementation NoSeatViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [self alloc];
    querySeat=[PFQuery queryWithClassName:@"Seat"];
    queryEmp=[PFQuery queryWithClassName:@"EmployeeDetails"];
}

// Get the list of employees without seat
-(void) alloc{
    queryAlloc=[PFQuery queryWithClassName:@"AllocateSeat"];
    [queryAlloc whereKey:@"seatTag" equalTo:@""];
    [queryAlloc findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%d",objects.count);
        count=objects.count;
        arr=[objects mutableCopy];
        NSLog(@"%d",count);
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return count;
  
}

// Fill the names of employees with out Seat to each of the cells in the table
- (TableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"tableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *empid1 = [[arr objectAtIndex:indexPath.row] valueForKey:@"empId"];
    [queryEmp whereKey:@"empId" equalTo:empid1];
    PFObject *objects=[queryEmp getFirstObject];
    cell.label1.text=objects[@"Name"];
    return cell;
}


// Set the seatTag of the employee from null to the seat already pressed
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"%d", _tag3];
    NSLog(@"%@",str);
    NSString *empSelected= cell.label1.text;
    NSLog(@"%@",empSelected);
    [queryEmp whereKey:@"Name" equalTo:empSelected];
    [queryEmp findObjectsInBackgroundWithBlock:^(NSArray *object2, NSError *error) {
        NSLog(@"%@",object2);
        NSString *empIdselected= [[object2 objectAtIndex:0] valueForKey:@"empId"];
        NSLog(@"%@",empIdselected);
        [queryAlloc whereKey:@"empId" equalTo:empIdselected];
        PFObject *object3=[queryAlloc getFirstObject];
        NSLog(@"%@",object3);
        [object3 setObject:str forKey:@"seatTag"];
        [object3 saveInBackground];
    }];
}

@end
