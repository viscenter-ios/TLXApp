//
//  Experiment.h
//  TLX
//
//  Created by Justin Proffitt on 6/9/11.
//  Copyright (c) 2011 University Of Kentucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Experiment : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * qFileName;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * dataString;
@property (nonatomic, retain) NSNumber * lastTrial;

@end
