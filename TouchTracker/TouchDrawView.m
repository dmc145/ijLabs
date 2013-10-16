//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Daniel Muñoz on 15/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView

@synthesize selectedLine;


- (id)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (self) {
        linesInProcess = [[NSMutableDictionary alloc] init];
        
        // Don't let the autocomplete fool you on the next line,
        // make sure you are instantiating an NSMutableArray
        // and not an NSMutableDictionary!
        completeLines = [[NSMutableArray alloc] init];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        // Without this, only one touch at a time can be active on a view
        [self setMultipleTouchEnabled:YES];
        
        UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tap:)];
        
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(longPress:)];
        
        // By default, a touch must be held 0.5 seconds to become a long press,
        // but you can change the minimumPressDuration of the gesture recognizer if you like.
        
        [self addGestureRecognizer:pressRecognizer];
        
        moveRecognizer = [[UIPanGestureRecognizer alloc]
                          initWithTarget:self action:@selector(moveLine:)];
        [moveRecognizer setDelegate:self];
        [moveRecognizer setCancelsTouchesInView:NO]; //Every UIGestureRecognizer has this property and, by default, this property is YES. This means that the gesture recognizer will eat any touch it recognizes so that the view will not have a chance to handle it via the traditional UIResponder methods, like touchesBegan:withEvent:. Usually, this is what you want, but not always. In our case, the gesture that the pan recognizer recognizes is the same kind of touch that the view handles to draw lines using the UIResponder methods. If the gesture recognizer eats these touches, then users will not be able to draw lines.
        
        [self addGestureRecognizer:moveRecognizer];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    // Draw complete lines in black
    [[UIColor blackColor] set];
    for (Line *line in completeLines) {
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    // Draw lines in process in red (Don't copy and paste the previous loop;
    // this one is way different)
    [[UIColor redColor] set];
    for (NSValue *v in linesInProcess) {
        Line *line = [linesInProcess objectForKey:v];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    // If there is a selected line, draw it
    if ([self selectedLine]) {
        [[UIColor greenColor] set];
        CGContextMoveToPoint(context, [[self selectedLine] begin].x,
                             [[self selectedLine] begin].y);
        CGContextAddLineToPoint(context, [[self selectedLine] end].x,
                                [[self selectedLine] end].y);
        CGContextStrokePath(context);
    }
    
    /* Chap. 21 Wasting time for Instruments
    float f = 0.0;
    for (int i = 0; i < 100000; i++) {
        f = f + sin(sin(time(NULL) + i));
    }
    NSLog(@"f = %f", f);
    */
}

- (void)clearAll
{
    // Clear the collections
    [linesInProcess removeAllObjects];
    [completeLines removeAllObjects];
    
    // Redraw
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        // Is this a double tap?
        if ([t tapCount] > 1) {
            [self clearAll];
            return;
        }
        
        // Use the touch object (packed in an NSValue) as the key
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        // Create a line for the value
        CGPoint loc = [t locationInView:self];
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        
        // Put pair in dictionary
        [linesInProcess setObject:newLine forKey:key];
    }
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    // Update linesInProcess with moved touches
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        // Find the line for this touch
        Line *line = [linesInProcess objectForKey:key]; // REVISAR, que es key???
        
        // Update the line
        CGPoint loc = [t locationInView:self];
        [line setEnd:loc];
    }
    // Redraw
    [self setNeedsDisplay];
}

- (void)endTouches:(NSSet *)touches
{
    // Remove ending touches from dictionary
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = [linesInProcess objectForKey:key];
        
        // If this is a double tap, 'line' will be nil,
        // so make sure not to add it to the array
        if (line) {
            [completeLines addObject:line];
            [linesInProcess removeObjectForKey:key];
        }
    }
    // Redraw
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches
               withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

#pragma-mark Chap. 20

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    
    CGPoint point = [gr locationInView:self];
    [self setSelectedLine:[self lineAtPoint:point]];
    
    // If we just tapped, remove all lines in process
    // so that a tap doesn't result in a new line
    [linesInProcess removeAllObjects];
    
    if ([self selectedLine]) {
        
        //For a menu controller to appear, the view that is presenting the menu controller must be the first responder of the window. So we sent the message becomeFirstResponder to the TouchDrawView before getting the menu controller. However, you might remember from Chapter 6 that you must override canBecomeFirstResponder in a view if it needs to become the first responder.
        [self becomeFirstResponder];
        
        // Grab the menu controller
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        // Create a new "Delete" UIMenuItem
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete"
                                                            action:@selector(deleteLine:)];
        [menu setMenuItems:[NSArray arrayWithObject:deleteItem]];
        
        // Tell the menu where it should come from and show it
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        // Hide the menu if no line is selected
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (Line *)lineAtPoint:(CGPoint)p
{
    // Find a line close to p
    for (Line *l in completeLines) {
        CGPoint start = [l begin];
        CGPoint end = [l end];
        
        // Check a few points on the line
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            // If the tapped point is within 20 points, let's return this line
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    
    // If nothing is close enough to the tapped point, then we didn't select a line
    return nil;
}

- (void)deleteLine:(id)sender
{
    // Remove the selected line from the list of completeLines
    // the selectedLine property was declared as weak, so when it is removed from the completeLines array, selectedLine is automatically set to nil.
    [completeLines removeObject:[self selectedLine]];
    
    // Redraw everything
    [self setNeedsDisplay];
}
- (void)longPress:(UIGestureRecognizer *)gr
{
    if ([gr state] == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        [self setSelectedLine:[self lineAtPoint:point]];
        
        if ([self selectedLine]) {
            [linesInProcess removeAllObjects];
        }
    } else if ([gr state] == UIGestureRecognizerStateEnded) {
        [self setSelectedLine:nil];
    }
    [self setNeedsDisplay];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other
{
    if (gestureRecognizer == moveRecognizer)
        return YES;
    return NO;
}

// Notice that because we will send the gesture recognizer a method from the UIPanGestureRecognizer class, the parameter of this method must be a pointer to an instance of UIPanGestureRecognizer rather than UIGestureRecognizer.

- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    // If we haven't selected a line, we don't do anything here
    if (![self selectedLine])
        return;
    
    // When the pan recognizer changes its position...
    if ([gr state] == UIGestureRecognizerStateChanged) {
        // How far as the pan moved?
        CGPoint translation = [gr translationInView:self];
        
        // Add the translation to the current begin and end points of the line
        CGPoint begin = [[self selectedLine] begin];
        CGPoint end = [[self selectedLine] end];
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        // Set the new beginning and end points of the line
        [[self selectedLine] setBegin:begin];
        [[self selectedLine] setEnd:end];
        
        // Redraw the screen
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}


/*
 If you override a method from UIResponderStandardEditActions in a view, its menu item will automatically appear in any menu you show for that view. This works because the menu controller sends the message canPerformAction:withSender: to its view, which returns YES or NO depending on whether the view implements this method.
 */
- (void)copy:(id)sender
{
    [super copy:sender];
}

/*
 If you want to implement one of these methods but don’t want it to appear in the menu, you can override canPerformAction:withSender: to return NO.
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:))
        return NO;
    
    // The superclass' implementation will return YES if the method is in the .m file
    return [super canPerformAction:action withSender:sender];
}

#pragma-mark Chap. 21

- (int)numberOfLines
{
    int count;
    
    // Check that they are non-nil before we add their counts...
    if (linesInProcess && completeLines)
        count = [linesInProcess count] + [completeLines count];
    
    return count;
}

@end
