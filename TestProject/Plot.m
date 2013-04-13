//
//  Plot.m
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Plot.h"


@implementation Plot

@synthesize ageArray;
@synthesize yArray;
@synthesize unitPixels;
@synthesize yPixels;
@synthesize min;
@synthesize max;
@synthesize plotValues;
@synthesize xmin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.5;
        //NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        //NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        ///[tempDict setValue:[NSValue valueWithCGPoint:CGPointMake(10, 10)] forKey:@"start"];
        //[tempDict setValue:[NSValue valueWithCGPoint:CGPointMake(500, 500)] forKey:@"end"];
        
        //[tempArray addObject:tempDict];
        
        // NSMutableDictionary *tempDict2 = [[NSMutableDictionary alloc] init];
        // [tempDict2 setValue:[NSValue valueWithCGPoint:CGPointMake(400, 10)] forKey:@"start"];
        //[tempDict2 setValue:[NSValue valueWithCGPoint:CGPointMake(500, 500)] forKey:@"end"];
        
        //[tempArray addObject:tempDict2];
        
        //self.ageArray = [NSArray arrayWithArray:tempArray];
        
        
        NSLog(@"PLOT");
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    NSLog(@"DRAW RECT");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor orangeColor] CGColor]));
    int i;
    
    /*
     for (int i = 0; i < [self.ageArray count]; i++)
     {
     CGPoint tempPoint = [[[self.ageArray objectAtIndex:i] objectForKey:@"start"] CGPointValue];
     CGPoint tempPoint2 = [[[self.ageArray objectAtIndex:i] objectForKey:@"end"] CGPointValue];
     
     CGContextMoveToPoint(context, tempPoint.x, tempPoint.y);
     CGContextAddLineToPoint(context, tempPoint2.x, tempPoint2.y);
     }
     */
    float multiX = [self frame].size.width;// - [self frame].origin.x;
    float multiY = [self frame].size.height;// - [self frame].origin.y;
    
    //fabsf((([[self.plotValues objectAtIndex:i] floatValue]-self.min)*yPixels)-multiY)+multiY
    //fabsf((([[self.plotValues objectAtIndex:i+1] floatValue]-self.min)*yPixels)-multiY)+multiY
    NSLog(@"AGE ARRAY COUNT: %d", [self.ageArray count]);
    if([self.ageArray count]>1){
        for(i=0; i<[self.ageArray count]-1; i++){
            CGPoint tempPoint1 = CGPointMake(([[self.ageArray objectAtIndex:i] floatValue]-self.xmin)*unitPixels ,  multiY - (([[self.plotValues objectAtIndex:i] floatValue]-self.min)*yPixels));
            CGPoint tempPoint2 = CGPointMake(([[self.ageArray objectAtIndex:i+1] floatValue]-self.xmin)*unitPixels, multiY - (([[self.plotValues objectAtIndex:i+1] floatValue]-self.min)*yPixels));
            CGContextMoveToPoint(context, tempPoint1.x+2, tempPoint1.y+2);
            CGContextAddLineToPoint(context, tempPoint2.x+2, tempPoint2.y+2);
            
            CGContextAddEllipseInRect(context, CGRectMake(tempPoint1.x, tempPoint1.y, 4, 4));
            
            if(i == [self.ageArray count]-2){
                CGContextAddEllipseInRect(context, CGRectMake(tempPoint2.x, tempPoint2.y, 4, 4));
                
            }
            
            
            NSLog(@"P1: %f %f", tempPoint1.x, tempPoint1.y);
            NSLog(@"P2: %f %f", tempPoint2.x, tempPoint2.y);
        }
        CGContextStrokePath(context);
    }
    else if([self.ageArray count]==1){
        
        CGPoint tempPoint1 = CGPointMake(([[self.ageArray objectAtIndex:0] floatValue]-self.xmin)*unitPixels ,  multiY - (([[self.plotValues objectAtIndex:0] floatValue]-self.min)*yPixels));
        CGContextAddEllipseInRect(context, CGRectMake(tempPoint1.x, tempPoint1.y, 14, 14));
        
        CGContextFillPath(context);
    }
    
    
    
    
    
    NSLog(@"unitPixels: %f", self.unitPixels);
    NSLog(@"yPixels: %f", self.yPixels);
    
    NSLog(@"FRAME: %f", [self frame].size.height);
    NSLog(@"FRAME: %f", [self frame].size.width);
    NSLog(@"X: %f", multiX);
    NSLog(@"Y: %f", multiY);
    
}

@end

