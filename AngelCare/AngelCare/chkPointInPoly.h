//
//  chkPointInPoly.h
//  testPointInPolyArea
//
//  Created by Roger on 2014/6/3.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "m_Point.h"
@interface chkPointInPoly : NSObject
- (int) point_in_poly:(int)maxVertix;
- (NSMutableArray*)reProducePoints:(NSArray *) a_point;
-(void)doInitWithOrg:(m_Point*)m_org;
@end
