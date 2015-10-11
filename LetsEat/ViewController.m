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
- (IBAction)changeState:(id)sender {
    UIButton *aButton = (UIButton *)sender;
    aButton.highlighted = NO;
    aButton.selected = NO;
}
- (IBAction)showQRVC:(id)sender {
   QRScanViewController *scanVC = [[QRScanViewController alloc]init];
   [self presentViewController:scanVC animated:YES completion:nil];
}

@end
