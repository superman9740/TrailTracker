//
//  ttTrail.m
//  TrailTracker
//
//  Created by Shane Dickson on 4/10/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "ttTrail.h"

@implementation ttTrail


-(void) encodeWithCoder:(NSCoder*)encoder
{
    
    [encoder encodeObject:_name forKey:kName];
    [encoder encodeObject:_desc forKey:kDesc];
    [encoder encodeObject:_images forKey:kImages];
    [encoder encodeObject:_videos forKey:kVideos];
    [encoder encodeObject:_waypoints forKey:kWaypoints];
    
    
    
}

 -(id)init
{
    
    if((self = [super init]))
    {
        
        _name = @"";
        _desc = @"";
        _images = nil;
        _videos = nil;
        _waypoints = nil;
        
        
    }
    
    return self;
    
}


- (id)initWithCoder: (NSCoder *)coder
{
    if((self = [self init]))
    {
        _name = [coder decodeObjectForKey: kName];
        _desc = [coder decodeObjectForKey: kDesc];
        _images = [coder decodeObjectForKey: kImages];
        _videos = [coder decodeObjectForKey: kVideos];
        _waypoints = [coder decodeObjectForKey: kWaypoints];
        
    }
    return self;
}

@end
