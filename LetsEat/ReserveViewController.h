//
//  ReserveViewController.h
//  LetsEat
//
//  Created by Monte's Pro 13" on 10/10/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReserveViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Phone;
@property (weak, nonatomic) IBOutlet UITextField *PartySize;


@property (weak, nonatomic) IBOutlet UIButton *reserveButton;

- (IBAction)reserveButton:(UIButton *)sender;

@end
