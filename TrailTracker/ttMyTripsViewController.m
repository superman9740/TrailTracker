//
//  ttMyTripsViewController.m
//  TrailTracker
//
//  Created by Shane Dickson on 3/21/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "ttMyTripsViewController.h"

@interface ttMyTripsViewController ()

@end

@implementation ttMyTripsViewController

-(void)awakeFromNib
{

    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(refreshData:)  name:kObjectsWereLoadedNotification
                                               object:nil];
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];



}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[ttAppController sharedInstance] trails] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ttTrail* trail = [[[ttAppController sharedInstance] trails] objectAtIndex:indexPath.row];
    if(trail.images.count > 0)
    {
        [cell.imageView setImage:[trail.images objectAtIndex:0]];
        
    }
    
    cell.textLabel.text = trail.name;
    cell.detailTextLabel.text = trail.desc;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ttTrail* trail = [[[ttAppController sharedInstance] trails] objectAtIndex:indexPath.row];
    
    [[ttAppController sharedInstance] setCurrentTrail:trail];
    [self performSegueWithIdentifier:@"showNewTrip" sender:self];
    

}


-(IBAction)createNewTrip:(id)sender
{
    [self performSegueWithIdentifier:@"showNewTrip" sender:self];
    
    
}

-(IBAction)refreshData:(id)sender
{
    [self.tableView reloadData];
    
    
}

@end
