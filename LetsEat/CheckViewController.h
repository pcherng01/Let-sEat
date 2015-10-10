//
//  CheckViewController.h
//  LetsEat
//
//  Created by Monte's Pro 13" on 10/10/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STPBackendCharging <NSObject>

- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion;
@end

@interface CheckViewController : UIViewController<STPBackendCharging>

@end
