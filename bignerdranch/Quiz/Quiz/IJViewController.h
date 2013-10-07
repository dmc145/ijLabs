//
//  IJViewController.h
//  Quiz
//
//  Created by Daniel Muñoz on 25/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IJViewController : UIViewController

{
    int currentQuestionIndex;
    
    // The model objects
    NSMutableArray *questions;
    NSMutableArray *answers;
    
    // The view objects - don't worry about IBOutlet -
    // we'll talk about it shortly
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}

- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
