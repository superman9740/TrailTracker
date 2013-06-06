//
//  ttNewViewController.h
//  TrailTracker
//
//  Created by Shane Dickson on 4/10/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttAppController.h"
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>



@interface ttNewViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, MKMapViewDelegate>
{
    
    
    
}

@property (strong, nonatomic) IBOutlet NSMutableArray* images;

           
@property (weak, nonatomic) IBOutlet UIScrollView* mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField* name;
@property (weak, nonatomic) IBOutlet UITextView* desc;
@property (weak, nonatomic) IBOutlet UIScrollView* picScrollView;
@property (nonatomic, strong) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) MKPolyline *routeLine;

@property (weak, nonatomic) IBOutlet UIView* cameraView;
@property (strong, nonatomic) AVCaptureSession* session;
@property (strong, nonatomic) AVCaptureStillImageOutput* stillImageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* previewLayer;
@property (weak, nonatomic) IBOutlet UIButton* captureButton;



-(IBAction)takePhoto:(id)sender;

-(IBAction)save:(id)sender;
-(IBAction)updatePicRollView:(id)sender;

@end
