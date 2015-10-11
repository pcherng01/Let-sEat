//
//  OptionViewController.m
//  LetsEat
//
//  Created by Pongsakorn Cherngchaosil on 10/11/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)sendToUber:(id)sender {
   if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uber://"]]) {
      NSLog(@"Can open uber app.");
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"uber://?action=setPickup&pickup=my_location&dropoff[latitude]=37.870546&dropoff[longitude]=-122.268421&dropoff[nickname]=Seasons%20Of%20Japan&dropoff[formatted_address]=2122%20Shattuck%20Ave%20Berkeley%20CA%2094704"]];
   }
}
- (IBAction)sendToHereMap:(id)sender {
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
