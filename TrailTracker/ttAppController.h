//
//  ttAppController.h
//  TrailTracker
//
//  Created by Shane Dickson on 3/21/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ttTrail.h"
#import "CrumbPath.h"

@interface ttAppController : NSObject
{
    
    
    
}

@property (nonatomic) CLLocationDegrees                 currentLat;
@property (nonatomic) CLLocationDegrees                 currentLon;

@property (strong, nonatomic) NSMutableArray* myTrails;
@property (strong, nonatomic) CrumbPath* waypoints;

+(ttAppController*)sharedInstance;

@end
