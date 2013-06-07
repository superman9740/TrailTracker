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
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

static NSString* const kObjectsWereLoadedNotification  = @"objectsWereLoaded";

@interface ttAppController : NSObject
{
    
    
    
}

@property (nonatomic) CLLocationDegrees                 currentLat;
@property (nonatomic) CLLocationDegrees                 currentLon;

@property (strong, nonatomic) NSMutableArray* trails;
@property (strong, nonatomic) CrumbPath* waypoints;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ttTrail* currentTrail;


+(ttAppController*)sharedInstance;
-(void)loadTrails;

-(void)saveTrail:(ttTrail*)trail;

@end
