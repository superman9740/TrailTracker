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
        _myTrails = [[NSMutableArray alloc] init];
        
        
    }
    
    return self;
}

@end
