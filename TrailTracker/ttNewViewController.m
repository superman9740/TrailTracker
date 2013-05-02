//
//  ttNewViewController.m
//  TrailTracker
//
//  Created by Shane Dickson on 4/10/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "ttNewViewController.h"

@interface ttNewViewController ()

@end

@implementation ttNewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.mainScrollView setContentSize:CGSizeMake(320,2000)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(IBAction)save:(id)sender
{
    
    ttTrail* newTrail = [[ttTrail alloc] init];
    newTrail.name = _name.text;
    newTrail.desc = _desc.text;
    [[[ttAppController sharedInstance] myTrails] addObject:newTrail];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

@end
