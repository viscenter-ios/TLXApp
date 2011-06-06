//
//  TLXAppDelegate.h
//  TLX
//
//  Created by Justin Proffitt on 6/2/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenu.h"
#import "SettingsVC.h"
#import "FormVC.h"
#import "FileTableVC.h"
#import "Experiment.h"
#import "CoreDataTableVC.h"
@class EmailTableVC;
@class AppendTableVC;
@interface TLXAppDelegate : NSObject <UIApplicationDelegate> {
  UINavigationController *NavController;
}

@property (nonatomic, retain) UINavigationController *NavController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
