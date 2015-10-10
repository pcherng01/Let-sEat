//
//  SCShapeView.m
//  LetsEat
//
//  Created by Pongsakorn Cherngchaosil on 10/10/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "SCShapeView.h"

@interface SCShapeView () {
   CAShapeLayer *_outline;
}
@end

@implementation SCShapeView

-(id)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code
      _outline = [CAShapeLayer new] ;
      _outline.strokeColor = [[[UIColor blueColor]colorWithAlphaComponent:0.8]CGColor];
      _outline.lineWidth = 2.0;
      _outline.fillColor = [[UIColor clearColor]CGColor];
      [self.layer addSublayer:_outline];
   }
   return self;
}

- (void)setCorners:(NSArray *)corners {
   if (corners != _corners) {
      _corners = corners;
      _outline.path = [[self createPathFromPoints:corners]CGPath];
   }
}

- (UIBezierPath *)createPathFromPoints:(NSArray *)points {
   UIBezierPath *path = [UIBezierPath new];
   // Start at the first corner
   [path moveToPoint:[[points firstObject]CGPointValue]];
   
   // Now drae lines around the corners
   for (NSUInteger i = 1; i < [points count]; i++) {
      [path addLineToPoint:[points[i] CGPointValue]];
   }
   
   // And join it back to the first corner
   [path addLineToPoint:[[points firstObject] CGPointValue]];
   
   return path;
}

@end
