//
//  QFile.h
//  TLX
//
//  Created by Justin Proffitt on 6/9/11.
//  Copyright (c) 2011 University Of Kentucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QFile : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * numOfQuestions;
@property (nonatomic, retain) NSNumber * rangeLowerBound;
@property (nonatomic, retain) NSNumber * rangeUpperBound;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * lowLabelNames;
@property (nonatomic, retain) NSNumber * rangeIncrement;
@property (nonatomic, retain) NSString * questionNames;
@property (nonatomic, retain) NSString * highLabelNames;

@end
