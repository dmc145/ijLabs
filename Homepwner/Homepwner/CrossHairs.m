//
//  CrossHairs.m
//  Homepwner
//
//  Created by Daniel Muñoz on 14/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "CrossHairs.h"

@implementation CrossHairs

@synthesize crossHairColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setCrossHairColor:[UIColor colorWithRed:8 green:8 blue:8 alpha:.7]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = (bounds.origin.y + bounds.size.height / 2.0);//-20; // 20 up because of toolbar at bottom.
    
    // The width of the crosshairs should be 2px
    CGContextSetLineWidth(ctx, 2);
    
    // Start and end points for vertical line
    CGPoint topVert;
    topVert.x = center.x;
    topVert.y = center.y - 20;
    
    CGPoint botVert;
    botVert.x = center.x;
    botVert.y = center.y + 20;
    
    // Start and end points for horizontal line
    CGPoint topHori;
    topHori.y = center.y;
    topHori.x = center.x - 20;
    
    CGPoint botHori;
    botHori.y = center.y;
    botHori.x = center.x + 20;
    
    // Stroke color and bg
    [[self crossHairColor] setStroke];
    
    // Draw vertical line
    CGContextMoveToPoint(ctx, topVert.x, topVert.y);
    CGContextAddLineToPoint(ctx, botVert.x, botVert.y);
    CGContextStrokePath(ctx);
    
    // Draw horizontal line
    CGContextMoveToPoint(ctx, topHori.x, topHori.y);
    CGContextAddLineToPoint(ctx, botHori.x, botHori.y);
    CGContextStrokePath(ctx);
}

/*
 add this method to the reticle view to ignore touches to its view and pass through to the view below it (allowing camera buttons/editing to work)
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}


@end
