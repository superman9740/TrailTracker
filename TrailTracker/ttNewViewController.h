//
//  ttNewViewController.h
//  TrailTracker
//
//  Created by Shane Dickson on 4/10/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttAppController.h"

@interface ttNewViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
{
    
    
    
}

@property (weak, nonatomic) IBOutlet UIScrollView* mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField* name;
@property (weak, nonatomic) IBOutlet UITextView* desc;
@property (weak, nonatomic) IBOutlet UIScrollView* picScrollView;
@property (weak, nonatomic) IBOutlet UIView* previewView;




-(IBAction)save:(id)sender;

@end
