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
    CrumbPath* waypoints = [[ttAppController sharedInstance] waypoints];
    int numPoints = [waypoints pointCount];
    if (numPoints > 1)
    {
        CLLocationCoordinate2D* coords = malloc(numPoints * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < numPoints; i++)
        {
            MKMapPoint* point = &waypoints.points[i];
            CLLocationCoordinate2D waypoint = MKCoordinateForMapPoint(*point);
            
            coords[i] = waypoint;
        }
        
        _routeLine = [MKPolyline polylineWithCoordinates:coords count:numPoints];
        free(coords);
        
        [_mapView addOverlay:_routeLine];
        [_mapView setNeedsDisplay];
    }
    
    
    MKCoordinateRegion region;
    
    CLLocationDegrees maxLat = -90;
    CLLocationDegrees maxLon = -180;
    CLLocationDegrees minLat = 90;
    CLLocationDegrees minLon = 180;
    
    for(int idx = 0; idx < [waypoints pointCount]; idx++)
    {
        
        MKMapPoint* point = &waypoints.points[idx];
        
        CLLocationCoordinate2D waypoint = MKCoordinateForMapPoint(*point);
        
        
        if(waypoint.latitude > maxLat)
            maxLat = waypoint.latitude;
        if(waypoint.latitude < minLat)
            minLat = waypoint.latitude;
        if(waypoint.longitude > maxLon)
            maxLon = waypoint.longitude;
        if(waypoint.longitude < minLon)
            minLon = waypoint.longitude;
    }
    
    region.center.latitude     = (maxLat + minLat) / 2;
    region.center.longitude    = (maxLon + minLon) / 2;
    region.span.latitudeDelta  = maxLat - minLat;
    region.span.longitudeDelta = maxLon - minLon;
    
    [_mapView setRegion:region animated:YES];

}
#pragma mark mapkit methods

- (MKOverlayView*)mapView:(MKMapView*)theMapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:_routeLine];
    view.fillColor = [UIColor blackColor];
    view.strokeColor = [UIColor blackColor];
    view.lineWidth = 4;
    return view;
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
