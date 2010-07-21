//
//  BaseViewController.h
//  iPadGestureExperiments
//
//  Created by Satty Bhens on 7/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideViewController;
@class AppsViewController;


@interface BaseViewController : UIViewController {
	AppsViewController *appsViewController;
    SlideViewController *slideViewController;
}

@property (nonatomic, retain) IBOutlet AppsViewController *appsViewController;
@property (nonatomic, retain) IBOutlet SlideViewController *slideViewController;

@end
