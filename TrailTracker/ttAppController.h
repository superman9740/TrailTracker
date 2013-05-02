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

@interface ttAppController : NSObject
{
    
    
    
}

@property (nonatomic) CLLocationDegrees                 currentLat;
@property (nonatomic) CLLocationDegrees                 currentLon;
@property (nonatomic) NSMutableDictionary               *wayPoints;

@property (strong, nonatomic) NSMutableArray* myTrails;


+(ttAppController*)sharedInstance;

@end
