//
//  ViewController.m
//  LetsEat
//
//  Created by Monte's Pro 13" on 10/9/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "ViewController.h"
#import "QRScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showQRVC:(id)sender {
   QRScanViewController *scanVC = [[QRScanViewController alloc]init];
   [self presentViewController:scanVC animated:YES completion:nil];
}

- (IBAction)button:(UIButton *)sender
{
    NSLog(@"Let's Eat! Button Tapped");
}

@end
