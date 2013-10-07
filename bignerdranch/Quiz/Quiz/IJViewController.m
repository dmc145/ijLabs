//
//  IJViewController.m
//  Quiz
//
//  Created by Daniel Muñoz on 25/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "IJViewController.h"

@implementation IJViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        
        questions = [[NSMutableArray alloc] init];
        answers = [[NSMutableArray alloc] init];
        
        [questions addObject:@"What's your name?"];
        [answers addObject:@"Daniel Muñoz"];

        [questions addObject:@"What's your company name?"];
        [answers addObject:@"InfoJobs"];
        
        [questions addObject:@"What's your role?"];
        [answers addObject:@"I'm technical leader..."];
    
    }
    
    return self;
}

- (IBAction)showQuestion:(id)sender
{
    currentQuestionIndex++;
    
    if (currentQuestionIndex == [questions count]) {
        currentQuestionIndex = 0;
    }
    
    NSString *question = [questions objectAtIndex:currentQuestionIndex];
    
    NSLog(@"Getting question %@:", question);
    
    [questionField setText:question];
    [answerField setText:@"???"];
}

- (IBAction)showAnswer:(id)sender
{
    NSString *answer = [answers objectAtIndex:currentQuestionIndex];
    [answerField setText:answer];
}

@end
