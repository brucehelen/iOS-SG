//
//  m_Point.h
//  testPointInPolyArea
//
//  Created by Roger on 2014/5/12.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface m_Point : NSObject
- (double)getX;
- (double)getY;
- (double) cross:(m_Point*) end;
- (m_Point*) makeVecotr:(m_Point*)end;
- (void)initPointWithX:(double)px andY:(double)py;
@end
