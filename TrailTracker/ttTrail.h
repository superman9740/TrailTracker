//
//  ttTrail.h
//  TrailTracker
//
//  Created by Shane Dickson on 4/10/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kName @"name"
#define kDesc @"desc"
#define kImages @"images"
#define kVideos @"videos"
#define kWaypoints @"waypoints"

@interface ttTrail : NSObject
{
    
    
}
@property (nonatomic) int rowID;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* desc;
@property (strong, nonatomic) NSMutableArray* images;
@property (strong, nonatomic) NSMutableArray* videos;
@property (strong, nonatomic) NSMutableArray* waypoints;


@end
