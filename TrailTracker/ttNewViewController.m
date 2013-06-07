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
	_images = [[NSMutableArray alloc] initWithCapacity:10];
    [self setupCaptureSession];
    
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

    ttTrail* currentTrail = [[ttAppController sharedInstance] currentTrail];
    if(currentTrail != nil)
    {
        
        _name.text = currentTrail.name;
        _desc.text = currentTrail.desc;
        _images = currentTrail.images;
        [self updatePicRollView:self];
        
    }
    
    
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

#pragma mark avfoundation setup
- (void)setupCaptureSession
{
    NSError *error = nil;
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetMedium;
    AVCaptureDevice* camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    error=nil;
    AVCaptureInput* cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&error];
    
    [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
    [_session addInput:cameraInput];
    
    [_session startRunning];
    
    
    
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    CGRect layerRect = _cameraView.layer.bounds;
	_previewLayer.bounds = layerRect;
    
	[_previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];

    
    _previewLayer.videoGravity = AVLayerVideoGravityResize;
    [_cameraView.layer addSublayer:_previewLayer];
    
    [self setStillImageOutput:[[AVCaptureStillImageOutput alloc] init]];
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], (id)kCVPixelBufferPixelFormatTypeKey, nil];
    [[self stillImageOutput] setOutputSettings:outputSettings];
    [_session addOutput:[self stillImageOutput]];
    NSURL *outputURL = [[self applicationDocumentsDirectory]    URLByAppendingPathComponent:@"output.mov"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[outputURL path]])
    {
        NSError *error;
        if ([fileManager removeItemAtPath:outputURL.path error:&error] == NO)
        {
            //Error - handle if requried
        }
    }
    
    _videoRecorder = [[AVCamRecorder alloc] initWithSession:_session outputFileURL:outputURL];
    
    
}

#pragma  mark photo methods

-(IBAction)takePhoto:(id)sender
    {
        
        AVCaptureConnection *videoConnection = nil;
        for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
            for (AVCaptureInputPort *port in [connection inputPorts]) {
                if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                    videoConnection = connection;
                    break;
                }
            }
            if (videoConnection) {
                break;
            }
        }
        
        [videoConnection setVideoOrientation:[UIDevice currentDevice].orientation];
        
        NSLog(@"about to request a capture from: %@", [self stillImageOutput]);
        [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                             completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                                 CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
                                                                 if (exifAttachments)
                                                                 {
                                                                     NSLog(@"attachements: %@", exifAttachments);
                                                                 } else
                                                                 {
                                                                     NSLog(@"no attachments");
                                                                 }
                                                                 UIImage* image = [self imageFromSampleBuffer:imageSampleBuffer];
                                                                 [_images addObject:image];
                                                                 

                                                                 
                                                                 [self performSelectorOnMainThread:@selector(updatePicRollView:) withObject:nil waitUntilDone:NO];
                                                                 
                                                                 
                                                             }];
        
        
        
    }

    
    


-(IBAction)updatePicRollView:(id)sender
{
    
    for (int i = 0; i < [_images count]; i++) {
        CGRect frame;
        frame.origin.x = 110 * i;
        frame.origin.y = 0;
        frame.size.height = 100;
        frame.size.width = 100;
        
        UIImageView *subview = [[UIImageView alloc] initWithFrame:frame];
        subview.image = [_images objectAtIndex:i];
        
        [_picScrollView addSubview:subview];
    }
    _picScrollView.contentSize = CGSizeMake(110 * [_images count], _picScrollView.frame.size.height);
    
  
}
// Create a UIImage from sample buffer data
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}


+ (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections;
{
    for ( AVCaptureConnection *connection in connections ) {
        for ( AVCaptureInputPort *port in [connection inputPorts] ) {
            if ( [[port mediaType] isEqual:mediaType] ) {
                return connection;
            }
        }
    }
    return nil;
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

-(IBAction)startRecordingVideo:(id)sender
{
    
    if(_isRecording)
    {
        _isRecording = false;
        [_videoRecorder stopRecording];
        
        
        
    }
    else
    {
    
        _isRecording = true;
        [_videoRecorder startRecordingWithOrientation:AVCaptureVideoOrientationPortrait];
        
        
    }
    
    
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


-(IBAction)save:(id)sender
{
    
    ttTrail* newTrail = [[ttTrail alloc] init];
    newTrail.name = _name.text;
    newTrail.desc = _desc.text;
    newTrail.images = _images;
    
    
    [[ttAppController sharedInstance] saveTrail:newTrail];
     
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

@end
