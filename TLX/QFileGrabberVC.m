//
//  QFileGrabberVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "QFileGrabberVC.h"


@implementation QFileGrabberVC

-(void)parseQFile:(NSString *) qFileString
{
  //NSArray *lines = [qFileString componentsSeparatedByString:@"\n"];
  //NSScanner *scanner = [NSScanner scannerWithString:[lines objectAtIndex:1]];
  NSScanner *scanner = [NSScanner scannerWithString:qFileString];
  
  NSString *title;
  NSString *numOfQuestions;
  NSString *range;
  NSString *rangeIncrement;
  
  NSString *questionNames = @"";
  NSString *lowLabelNames = @"";
  NSString *highLabelNames = @"";
  
  NSString *questionName;
  NSString *qLowLabel;
  NSString *qHighLabel;
  
  [scanner scanString:@"TITLE " intoString:NULL];
  
  [scanner scanUpToString:@"\n" intoString:&title];  
  
  [scanner scanString:@"QUESTIONS_PER_FRAME" intoString:NULL];
  
  [scanner scanUpToString:@"\n" intoString:&numOfQuestions];
  
  [scanner scanString:@"RANGE " intoString:NULL];
  
  [scanner scanUpToString:@"\n" intoString:&range];
  
  [scanner scanString:@"RANGE_INCREMENT " intoString:NULL];
  
  [scanner scanUpToString:@"\n" intoString:&rangeIncrement];
  // NSLog(@"title:%@\n numofQ: %@\n range:%@\n rangeinc: %@", title, numOfQuestions, range, rangeIncrement);
  int questionNum = [numOfQuestions intValue];
  NSArray *split = [range componentsSeparatedByString:@" "];
  int lowRange = [[split objectAtIndex:0] intValue];
  int highRange = [[split objectAtIndex:1] intValue];
  int rangeInc = [rangeIncrement intValue];
  for(int i = 0; i < questionNum; ++i){
    [scanner scanString:@"QUESTION " intoString:NULL];
  
    [scanner scanUpToString:@"\n" intoString:&questionName];
  
    [scanner scanString:@"RANGE_MIN_LABEL" intoString:NULL];
  
    [scanner scanUpToString:@"\n" intoString:&qLowLabel];
  
    [scanner scanString:@"RANGE_MAX_LABEL" intoString:NULL];
  
    [scanner scanUpToString:@"\n" intoString:&qHighLabel];
    
    questionNames = [questionNames stringByAppendingFormat:@"%@\n", questionName];
    lowLabelNames = [lowLabelNames stringByAppendingFormat:@"%@\n", qLowLabel];
    highLabelNames = [highLabelNames stringByAppendingFormat:@"%@\n", qHighLabel];
  }
  NSLog(@"%@", questionNames);
  NSLog(@"%@", lowLabelNames);
  NSLog(@"%@", highLabelNames);
  NSLog(@"Low: %d\nHigh: %d\nRange %d", lowRange, highRange, rangeInc); 
  
}

-(IBAction)downloadQFile
{
  NSURL *url = [NSURL URLWithString:[addressText text]];
  NSString *qString = [NSString stringWithContentsOfURL:url
                                               encoding:NSUTF8StringEncoding
                                                error:nil];
  [textView setEditable:YES];
  [textView setText:qString];
  [textView setEditable:NO];
  NSLog(@"%@", qString);
  [self parseQFile:qString];
  
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
