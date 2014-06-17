//
//  TableCell.h
//  SeatingAtQburst
//
//  Created by qbadmin on 06/06/14.
//  Copyright (c) 2014 qbadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property(assign,nonatomic)  NSInteger bindex;
@end
