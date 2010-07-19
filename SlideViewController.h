//
//  SlideViewController.h
//  iPadGestureExperiments
//
//  Created by Satty Bhens on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SlideViewController : UIViewController <UIGestureRecognizerDelegate> {
	UITapGestureRecognizer *tapRecognizer;
	UISwipeGestureRecognizer *swipeRecognizer;
	UIImageView *slideImageView;
	UIImageView *tapImageView;
}

@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic, retain) UIImageView *slideImageView;
@property (nonatomic, retain) UIImageView *tapImageView;

@end
