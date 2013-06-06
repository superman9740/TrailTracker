//
//  ttMapViewController.h
//  TrailTracker
//
//  Created by Shane Dickson on 3/21/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ttAppController.h"
#import "CrumbPath.h"
#import "CrumbPathView.h"

#define METERS_PER_MILE 1609.344

@interface ttMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    
    
    
}

@property (nonatomic, strong) IBOutlet MKMapView* mapView;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic) CLLocationDistance distance;
@property (nonatomic,strong) CLLocation* startPoint;
@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;
@property (nonatomic, strong) CrumbPath *crumbs;
@property (nonatomic, strong) CrumbPathView *crumbView;

-(IBAction)startTracking:(id)sender;

@end
