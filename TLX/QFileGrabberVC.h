//
//  QFileGrabberVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QFileGrabberVC : UIViewController {
  IBOutlet UITextField *addressText;
  IBOutlet UIWebView *webView;
  IBOutlet UILabel *infoLabel;
  NSString *questionString;
  IBOutlet UITextView *textView;
}

-(IBAction) downloadQFile;
@end
