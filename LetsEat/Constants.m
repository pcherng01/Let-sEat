//
//  Constants.m
//  StripeExample
//
//  Created by Jack Flintermann on 8/22/14.
//  Copyright (c) 2014 Stripe. All rights reserved.
//

#import "Constants.h"

/**
 *  Replace these with your own values and then remove this warning.
 *  Make sure to replace the values in Example/Parse/config/global.json as well if you want to use Parse.
 */

// This can be found at https://dashboard.stripe.com/account/apikeys
NSString *const StripePublishableKey = @"pk_test_L0Yaax9EXFoKytoaO8Ow1OHE"; // TODO: replace nil with your own value

// To set this up, check out https://github.com/stripe/example-ios-backend
// This should be in the format https://my-shiny-backend.herokuapp.com
NSString *const BackendChargeURLString = @"https://letsseat.herokuapp.com"; // TODO: replace nil with your own value

@implementation Constants
@end
