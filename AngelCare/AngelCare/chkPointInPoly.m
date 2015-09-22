//
//  chkPointInPoly.m
//  testPointInPolyArea
//
//  Created by Roger on 2014/6/3.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "chkPointInPoly.h"
//#import "m_Point.h"
@implementation chkPointInPoly
{
    NSMutableArray *points;
    NSMutableArray *vectorsC;
    NSMutableArray *vectorsV;
    m_Point *org;
}
#pragma mark - new algo 判斷點是否在多邊形內
-(void)doInitWithOrg:(m_Point*)m_org{
    points = [NSMutableArray new];
    vectorsC = [NSMutableArray new];
    vectorsV = [NSMutableArray new];
    org = [m_Point new];
    org = m_org;
}
- (int) point_in_poly:(int)maxVertix{
    //org : 目標點
    //points(array): 多邊形的所有頂點
    int i, j, c = 0;
    for (i = 0, j = maxVertix-1; i < maxVertix; j = i++) {
        //        NSLog(@"------");
        //        NSLog(@"i = %d",i);
        //        NSLog(@"j = %d",j);
        BOOL firstR = ([points[i] getY]>[org getY]);
        BOOL firstL = ([points[j] getY]>[org getY]);
        double secondR1 = ([points[j] getX]-[points[i] getX]);
        double secondR2 = ([org getY]-[points[i] getY]);
        double secondR3 = ([points[j] getY]-[points[i] getY]);
        double secondR4 = [points[i] getX];
        double secondL1 = [org getX];
        NSLog(@"****** i = %i ******",i);
        NSLog(@"firstR = %i",firstR);
        NSLog(@"firstL = %i",firstL);
        NSLog(@"secondR1 = %@",[NSNumber numberWithDouble:secondR1]);
        NSLog(@"secondR2 = %@",[NSNumber numberWithDouble:secondR2]);
        NSLog(@"secondR3 = %@",[NSNumber numberWithDouble:secondR3]);
        NSLog(@"secondR4 = %@",[NSNumber numberWithDouble:secondR4]);
        NSLog(@"secondL1 = %@",[NSNumber numberWithDouble:secondL1]);
        NSLog(@"****** EndEnd ******");
        if ( (firstR !=firstL) &&
            (secondL1 <  secondR1 *  secondR2 / secondR3 + secondR4) )
            c = !c;
    }
    return c;
}
#pragma mark - 重新將頂點逆時針排序
- (NSMutableArray*)reProducePoints:(NSArray *) a_point{
    int k = 0;
    for (int i = 1;  i <  [a_point count]; i++) {
        if (([(m_Point*)a_point[i] getY] < [(m_Point*)a_point[k] getY])||
            (([(m_Point*)a_point[i] getY] == [(m_Point*)a_point[k] getY])&&([(m_Point*)a_point[i] getX] < [(m_Point*)a_point[k] getX]))) {
            k = i;
        }
    }
    NSMutableArray *tmpA = [NSMutableArray new];
    for (int i = 0;  i < [a_point count]; i++) {
        if (i != k) {
            [tmpA addObject:a_point[i]];
        }
    }
    //    [tmpA addObject:[tmpA firstObject]];
    //    NSLog(@"tmpA.count %lu",(unsigned long)tmpA.count);
    //    NSLog(@"k = %d",k); //ori get
    m_Point *ori = (m_Point*)a_point[k];
//    UILabel *lblorg = [[UILabel alloc]initWithFrame:CGRectMake([ori getX], [ori getY], 5, 5)];
//    [lblorg setBackgroundColor:[UIColor greenColor]];
//    [self.view addSubview:lblorg];
    
    
    
    int range = (int)[tmpA count];
    NSMutableArray *resArray = [NSMutableArray new];
    for (int i = 0; i < range; i++) {
        //        NSLog(@"i = %d",i);
        [resArray addObject:[self findMin:tmpA andOri:ori]];
    }
    [resArray insertObject:ori atIndex:0];
    //    NSLog(@"resArray = %@",resArray);
    points = resArray;
    return  resArray;
}
//計算角度
- (double)calYdivXWithStart:(m_Point*)start andEnd:(m_Point*)end{
    double res;
    double x = [end getX] - [start getX];
    double y = [end getY] - [start getY];
    res = y/x * 1.0;
    //    res = y/x * 1.0;
    res = atan2f(y, x);//(res);
    //    NSLog(@"y = %f",y);
    return res;
}
//計算距離
- (double)calDistWithStart:(m_Point*)start andEnd:(m_Point*)end{
    double res;
    double x = [end getX] - [start getX];
    double y = [end getY] - [start getY];
    res = sqrt(y*y + x*x) * 1.0;
    return res;
}
//找出角度最小的
- (m_Point*)findMin:(NSMutableArray*)pA andOri:(m_Point*)ori{
    //    NSLog(@"pA.cout = %lu",(unsigned long)pA.count);
    m_Point *min;
    if (pA.count == 1) {
        NSLog(@"0 return");
        return pA[0];
    }
    int k = 0;
    for (int i = 0;  i < [pA count]; i++) {
        double tI = [self calYdivXWithStart:ori andEnd:(m_Point*)pA[i]];
        double tK = [self calYdivXWithStart:ori andEnd:(m_Point*)pA[k]];
        double dI = [self calDistWithStart:ori andEnd:(m_Point*)pA[i]];
        double dK = [self calDistWithStart:ori andEnd:(m_Point*)pA[k]];
        //        NSLog(@"tI = %f,tK = %f",tI,tK);
        if (( tI < tK) ||
            ((tI == tK)&&(dI < dK))) {
            k = i;
            //            NSLog(@"change!");
        }
    }
    //    NSLog(@"min k = %d",k);
    min = pA[k];
    [pA removeObjectAtIndex:k];
    
    return min;
}

@end
