//
//  QRScanViewController.m
//  LetsEat
//
//  Created by Pongsakorn Cherngchaosil on 10/10/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "QRScanViewController.h"
#import "SCShapeView.h"
#import "ReserveViewController.h"
@import AVFoundation;

@interface QRScanViewController () <AVCaptureMetadataOutputObjectsDelegate> {
   AVCaptureVideoPreviewLayer *_previewLayer;
   SCShapeView *_boundingBox;
   NSTimer *_boxHideTimer;
   UILabel *_decodedMessage;
   BOOL stopScanningQR;
}

@end

@implementation QRScanViewController

-(NSUInteger)supportedInterfaceOrientations {
   return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   stopScanningQR = true;
    // Do any additional setup after loading the view.
   
   // Create a new AVCaptureSession
   AVCaptureSession *session = [[AVCaptureSession alloc]init]  ;
   AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
   NSError *error = nil;
   
   // Want the normal device
   AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
   
   if (input) {
      [session addInput:input];
   }else {
      NSLog(@"Error: %@", error);
      return;
   }
   
   AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
   // Have to add the output before setting metadata types
   [session addOutput:output];
   // What difference things can we register to recognise?
   NSLog(@"%@", [output availableMetadataObjectTypes]);
   [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
   // This VC is the delegate. Please call us on the main queue
   [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
   
   // Display on the screen
   _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
   _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
   _previewLayer.bounds = self.view.bounds;
   _previewLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
   [self.view.layer addSublayer:_previewLayer];
   
   // Add the view to draw the bounding box for the UIView
   _boundingBox = [[SCShapeView alloc]initWithFrame:self.view.bounds];
   _boundingBox.backgroundColor = [UIColor clearColor];
   _boundingBox.hidden = YES;
   [self.view addSubview:_boundingBox];
   
   // Add a label to display the resultant message
   _decodedMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 75, CGRectGetWidth(self.view.bounds), 75)];
   _decodedMessage.numberOfLines = 0;
   _decodedMessage.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9];
   _decodedMessage.textColor = [UIColor darkGrayColor];
   _decodedMessage.textAlignment = NSTextAlignmentCenter;
   [self.view addSubview:_decodedMessage];
   
   // Start the AVSession running
   [session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
   
   if (!stopScanningQR) {
      return;
   }
   else{
      stopScanningQR = NO;
      for (AVMetadataObject *metadata in metadataObjects) {
         if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            // Transform the meta-data coordinates to screen coords
            AVMetadataMachineReadableCodeObject *transformed = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:metadata];
            // Update the frame on the _boundingBox view, and show it
            _boundingBox.frame = transformed.bounds;
            _boundingBox.hidden = NO;
            // Now convert the corners array into CGPoints in the coordinate system
            //  of the bounding box itself
            NSArray *translatedCorners = [self translatePoints:transformed.corners
                                                      fromView:self.view
                                                        toView:_boundingBox];
            
            // Set the corners array
            _boundingBox.corners = translatedCorners;
            
            NSLog(@"%@", [transformed stringValue]);
            // Update the view with the decoded text
            _decodedMessage.text = [transformed stringValue];
            
            // Start the timer which will hide the overlay
            [self startOverlayHideTimer];
            
            UIStoryboard *mainStry = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ReserveViewController *reserveVC = [mainStry instantiateViewControllerWithIdentifier:@"SignUp"];
             
             UIAlertController * view=   [UIAlertController
                                          alertControllerWithTitle:@"Done!"
                                          message:@"QR Code scan successful!"
                                          preferredStyle:UIAlertControllerStyleActionSheet];
             
             UIAlertAction* ok = [UIAlertAction
                                  actionWithTitle:@"Great!"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [view dismissViewControllerAnimated:YES completion:nil];
                                      [self presentViewController:reserveVC animated:YES completion:nil];
                                      
                                  }];
             
             [view addAction:ok];
             [self presentViewController:view animated:YES completion:nil];
             
            NSLog(@"Done");
         }
         
      }
   }
}

#pragma mark - Utility Methods
- (void)startOverlayHideTimer
{
   // Cancel it if we're already running
   if(_boxHideTimer) {
      [_boxHideTimer invalidate];
   }
   
   // Restart it to hide the overlay when it fires
   _boxHideTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                    target:self
                                                  selector:@selector(removeBoundingBox:)
                                                  userInfo:nil
                                                   repeats:NO];
}

- (void)removeBoundingBox:(id)sender
{
   // Hide the box and remove the decoded text
   _boundingBox.hidden = YES;
   _decodedMessage.text = @"";
}

- (NSArray *)translatePoints:(NSArray *)points fromView:(UIView *)fromView toView:(UIView *)toView
{
   NSMutableArray *translatedPoints = [NSMutableArray new];
   
   // The points are provided in a dictionary with keys X and Y
   for (NSDictionary *point in points) {
      // Let's turn them into CGPoints
      CGPoint pointValue = CGPointMake([point[@"X"] floatValue], [point[@"Y"] floatValue]);
      // Now translate from one view to the other
      CGPoint translatedPoint = [fromView convertPoint:pointValue toView:toView];
      // Box them up and add to the array
      [translatedPoints addObject:[NSValue valueWithCGPoint:translatedPoint]];
   }
   
   return [translatedPoints copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
