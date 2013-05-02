//
//  ttMyTripsViewController.h
//  TrailTracker
//
//  Created by Shane Dickson on 3/21/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttAppController.h"

@interface ttMyTripsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    
    
}

@property (weak, nonatomic) IBOutlet UITableView*  tableView;

-(IBAction)createNewTrip:(id)sender;

@end
