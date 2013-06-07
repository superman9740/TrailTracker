//
//  ttAppController.m
//  TrailTracker
//
//  Created by Shane Dickson on 3/21/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "ttAppController.h"

static ttAppController* sharedInstance = nil;


@implementation ttAppController


+ (ttAppController *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    
    if (self)
    {
        _trails = [[NSMutableArray alloc] init];
        
        
    }
    
    return self;
}


-(void)loadTrails
{
    
    
    [_trails removeAllObjects];
    NSError* error = nil;
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Trail" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *info in fetchedObjects)
    {
        NSLog(@"Name: %@", [info valueForKey:@"name"]);
        NSLog(@"Desc: %@", [info valueForKey:@"desc"]);
        
        
        ttTrail* trailObj = [[ttTrail alloc] init];
        //trailObj.rowID =    [info valueForKey:@"rowID"];
        trailObj.name = [info valueForKey:@"name"];
        trailObj.desc = [info valueForKey:@"desc"];
        trailObj.images = [info valueForKey:@"images"];
        
        if(trailObj.images == nil)
        {
            trailObj.images = [[NSMutableArray alloc] initWithCapacity:10];
            
        }
        
        trailObj.videos = [info valueForKey:@"videos"];
        
        if(trailObj.videos == nil)
        {
            trailObj.videos = [[NSMutableArray alloc] initWithCapacity:10];
            
        }
        
        trailObj.waypoints = [info valueForKey:@"waypoints"];
        
        if(trailObj.waypoints == nil)
        {
            trailObj.waypoints = [[NSMutableArray alloc] initWithCapacity:10];
            
        }
        
        [_trails addObject:trailObj];
        
        
        
    }
    NSLog(@"All objects have been loaded.");
    [[NSNotificationCenter defaultCenter] postNotificationName:kObjectsWereLoadedNotification  object:nil userInfo:nil];
    
    
   
}

-(void)saveTrail:(ttTrail*)trail
{
    
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSPersistentStoreCoordinator *coordinator = appDelegate.persistentStoreCoordinator;
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
        
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //Check to see if this object already exists
        
     NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"Trail" inManagedObjectContext:context];

        
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     [request setEntity:entityDescription];
     NSString* predicateStr = trail.name;
      
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"(name == %@)", predicateStr];
        
        [request setPredicate:predicate];
        NSError *error;
        NSArray *array = [context executeFetchRequest:request error:&error];
        
        NSManagedObject* trailObject = nil;
        
        if(array.count == 0)
        {
            
            trailObject = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"Trail"
                                            inManagedObjectContext:context];
            
        }
        else
        {
            trailObject = [array objectAtIndex:0];
            
        }
        
        
        
    
    [trailObject  setValue:trail.name forKey:@"name"];
    [trailObject  setValue:trail.desc forKey:@"desc"];
    [trailObject  setValue:trail.images forKey:@"images"];
    [trailObject  setValue:trail.videos forKey:@"videos"];
    [trailObject  setValue:trail.name forKey:@"waypoints"];
    
    error = nil;
    if (![context save:&error]) {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    [_trails addObject:trail];
    [self loadTrails];
        
    
}
}


@end
