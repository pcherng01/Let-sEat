//
//  ReserveViewController.m
//  LetsEat
//
//  Created by Monte's Pro 13" on 10/10/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "ReserveViewController.h"

#import "Reservation.h"
#import <Parse/Parse.h>

@interface ReserveViewController ()

@property Reservation *reservation;

@end

@implementation ReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage *btnImage = [UIImage imageNamed:@"eatButton.png"];
//    UIButton *btnLogo = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnLogo.frame = CGRectMake(150, 700, 250, 150);
//    [btnLogo addTarget:self action:@selector(showQRVC:) forControlEvents:UIControlEventTouchUpInside];
//    [btnLogo setImage:btnImage forState:UIControlStateNormal];
//    [self.view addSubview:btnLogo];
    [self.view endEditing:YES];
    
    [_Name setDelegate:self];
    [_Phone setDelegate:self];
    [_PartySize setDelegate:self];
}

-(BOOL) textFieldShouldReturn:(UITextField *) textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reserveButton:(UIButton *)sender
{
    // Validate the text fields and make sure they are not empty
    if (self.Name.text.length == 0)
    {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Invalid!"
                                     message:@"Name cannot be empty!"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    } else if (self.Phone.text.length <10)
    {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Invalid!"
                                     message:@"Phone number has to be atleast 10 digits!"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    } else if (self.PartySize.text.length == 0)
    {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Invalid!"
                                     message:@"Party size cannot be empty!"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }
    else {
    //If everything is input correctly, display success message!
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Your reservation has been placed!"
                                 message:@"Thank you!"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                             
                         }];
    
    [view addAction:ok];
    [view setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = [view
                                                    popoverPresentationController];
    popPresenter.sourceView = _reserveButton;
    popPresenter.sourceRect = _reserveButton.bounds;
    [self presentViewController:view animated:YES completion:nil];
    
        
    //display button pressed for debugging
    NSLog(@"Reserve Button Tapped!");
    
    //convert textField to NSNumber
   // NSNumber *phone_number = @([self.Phone.text floatValue]);
    NSNumber *partySize_number = @([self.PartySize.text longLongValue]);
    
    //store the user entry into a object locally
    self.reservation = [[Reservation alloc]init];
    self.reservation.name = self.Name.text;
    self.reservation.phone = self.Phone.text;
    self.reservation.partySize = partySize_number;
    
    //print the object to be stored for debugging
    NSLog(@"%@", self.reservation.name);
    NSLog(@"%@", self.reservation.phone);
    NSLog(@"%@", self.reservation.partySize);
    
    
    //send data to parse and store it
    PFObject *newReservation = [PFObject objectWithClassName:@"ReservationList"];
    newReservation[@"customerName"]= self.reservation.name;
    newReservation[@"customerPhone"]= self.reservation.phone;
    newReservation[@"customerPartySize"]= self.reservation.partySize;
        
    [newReservation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"%@", newReservation);
        } else {
            // There was a problem, check error.description
            NSLog(@"%@", error.description);
        }
    }];
        
    }
}

@end
