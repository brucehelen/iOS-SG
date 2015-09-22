//
//  m_Point.m
//  testPointInPolyArea
//
//  Created by Roger on 2014/5/12.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "m_Point.h"

@implementation m_Point
{
    double x;
    double y;
}

- (double) cross:(m_Point*) end{
    return self->x*end->y - self->y*end->x;
}
- (m_Point*) makeVecotr:(m_Point*)end{
    m_Point *p = [m_Point new];
    double px = end->x - self->x;
    double py = end->y - self->y;
    [p initPointWithX:px andY:py];
    return p;
}
- (void)initPointWithX:(double)px andY:(double)py{
    self->x = px;
    self->y = py;
}
- (double)getX{
    return x;
}
- (double)getY{
    return y;
}
@end
