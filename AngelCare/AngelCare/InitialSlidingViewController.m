//
//  InitialSlidingViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/25/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "InitialSlidingViewController.h"
#import "AppDelegate.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Index"];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return NO;
}
*/

@end
