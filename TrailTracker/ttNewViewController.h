//
//  ttNewViewController.h
//  TrailTracker
//
//  Created by Shane Dickson on 4/10/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttAppController.h"
#import <MapKit/MapKit.h>

@interface ttNewViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, MKMapViewDelegate>
{
    
    
    
}

@property (weak, nonatomic) IBOutlet UIScrollView* mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField* name;
@property (weak, nonatomic) IBOutlet UITextView* desc;
@property (weak, nonatomic) IBOutlet UIScrollView* picScrollView;
@property (weak, nonatomic) IBOutlet UIView* previewView;
@property (nonatomic, strong) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) MKPolyline *routeLine;




-(IBAction)save:(id)sender;

@end
