//
//  ttMapViewController.m
//  TrailTracker
//
//  Created by Shane Dickson on 3/21/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "ttMapViewController.h"

@interface ttMapViewController ()

@end

@implementation ttMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];

}





#pragma mark mapkit methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //[[AppController sharedManager] setCurrentSpot:pinView.spot];
    
}
- (void)deselectAnnotation:(id < MKAnnotation >)annotation animated:(BOOL)animated
{
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
        (oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
    {
        if (!self.crumbs)
        {
            // This is the first time we're getting a location update, so create
            // the CrumbPath and add it to the map.
            //
            _crumbs = [[CrumbPath alloc] initWithCenterCoordinate:newLocation.coordinate];
            [_mapView addOverlay:self.crumbs];
            
            // On the first location update only, zoom map to user location
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000);
            [_mapView setRegion:region animated:YES];
        }
        else
        {
            // This is a subsequent location update.
            // If the crumbs MKOverlay model object determines that the current location has moved
            // far enough from the previous location, use the returned updateRect to redraw just
            // the changed area.
            //
            // note: iPhone 3G will locate you using the triangulation of the cell towers.
            // so you may experience spikes in location data (in small time intervals)
            // due to 3G tower triangulation.
            //
            MKMapRect updateRect = [self.crumbs addCoordinate:newLocation.coordinate];
            
            if (!MKMapRectIsNull(updateRect))
            {
                // There is a non null update rect.
                // Compute the currently visible map zoom scale
                MKZoomScale currentZoomScale = (CGFloat)(_mapView.bounds.size.width / _mapView.visibleMapRect.size.width);
                // Find out the line width at this zoom scale and outset the updateRect by that amount
                CGFloat lineWidth = MKRoadWidthAtZoomScale(currentZoomScale);
                updateRect = MKMapRectInset(updateRect, -lineWidth, -lineWidth);
                // Ask the overlay view to update just the changed area.
                [self.crumbView setNeedsDisplayInMapRect:updateRect];
            }
        }
    }
}



- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if (!self.crumbView)
    {
        _crumbView = [[CrumbPathView alloc] initWithOverlay:overlay];
    }
    return self.crumbView;
}



#pragma mark tracking methods

-(IBAction)startTracking:(id)sender
{
    

    CLLocation* startingPoint = [[CLLocation alloc] initWithLatitude:[[ttAppController sharedInstance] currentLat] longitude:[[ttAppController sharedInstance] currentLon]];
    
    _startPoint = startingPoint;
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
