//
//  CalendarDay.m
//  TestProject
//
//  Created by Team Ganda on 3/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



#import "CalendarDay.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation CalendarDay
@synthesize appointmentsArr;
@synthesize date;
@synthesize dateLabel;
@synthesize delegate;

@synthesize scroller;
@synthesize textViewArray;

- (void) initializedateLabel:(CGRect) frame{
    
    self.dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(0,5,frame.size.width-5,16)];
    [self.dateLabel setTextColor:UIColorFromRGB(0x006699)];
    self.dateLabel.textAlignment = UITextAlignmentRight;
    [self.dateLabel setFont:[UIFont fontWithName:@"System" size:6]];
    self.dateLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.dateLabel];
    
}

- (void) removeSubviews{
    
    for (UILabel *v in textViewArray) {
        [v removeFromSuperview];
    }
    
    
}

- (void) initializeTextViewWithString:(NSString *) str andNumber: (int) count{
    
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(1, (count*32), 97, 33)];
    
    [textView setFont:[UIFont systemFontOfSize:11]];    //[textVie
    [textView setTextColor:UIColorFromRGB(0x333333)];
    textView.backgroundColor = UIColorFromRGB(0xFFFACD);
    [textView setNumberOfLines:0];
    // textView.editable = NO;
    textView.text = str;
    //textView.scrollEnabled = NO;
    [self.scroller addSubview:textView];
    [self.textViewArray addObject:textView];
    
    textView.layer.borderColor = UIColorFromRGB(0xCDC9A5).CGColor;
    textView.layer.borderWidth = 1;
    
}

- (void) changeContentSize: (int) number{
    self.scroller.contentSize=CGSizeMake(100,(number*34)+(number*7)+10);
    
}

- (void) initializaScrollView:(CGRect) frame{
    self.scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(1, 19, frame.size.width-1, frame.size.height)];
    self.scroller.backgroundColor = [UIColor clearColor];
    self.scroller.scrollEnabled = YES;
    
    [self addSubview:scroller];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedateLabel: frame];
        [self initializaScrollView:frame];
        self.textViewArray = [[NSMutableArray alloc]init ];
        //[self initializeTextView:(CGRect) frame];
        UITapGestureRecognizer *singleFingerTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];        
    }
    return self;
}




-(void)drawRect:(CGRect)rect {
    /*  CGContextRef ctx = UIGraphicsGetCurrentContext();
     CGContextSetRGBFillColor(ctx, 252.00/255.00, 252.00/255.00, 252.00/255.00, 1.0);
     CGContextSetRGBStrokeColor(ctx, 222.00/255.00, 222.00/255.00, 222.00/255.00, 1);
     CGContextBeginPath(ctx);
     CGContextAddRect(ctx, rect);
     CGContextFillPath(ctx);
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    [UIColorFromRGB(0xFFFFFF) setFill];
    [UIColorFromRGB(0xBBBBBB) setStroke];
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.delegate didTapDay:self.date];
}


@end