//
//  AppendTableVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "AppendTableVC.h"
@implementation AppendTableVC
@synthesize subjectText;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
  ENTITY_NAME *e = [self objForIndexPath:indexPath];
  FormVC *form = [[FormVC alloc] init];
  [form setMoContext:self.moContext];
  [form setSubjectLabelText:[NSString stringWithFormat:@"Subject: %@", [subjectText text]]];
  [form setTrialTextValue:[e valueForKey:@"lastTrial"]];
  [form setFileName:[e valueForKey:KEY_NAME]];
  [form setSubjectName:[subjectText text]];
  [self.navigationController pushViewController:form animated:YES];
  
}
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
}
@end
