//
//  SlideViewController.h
//  iPadGestureExperiments
//
//  Created by Satty Bhens on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SlideViewController : UIViewController <UIGestureRecognizerDelegate, UIPopoverControllerDelegate> {
	UITapGestureRecognizer *tapRecognizer;
	UISwipeGestureRecognizer *swipeRecognizer;
	UIImageView *slideImage;
	UIImageView *tapImageView;
  UISlider *trackSlider;
  UILabel *pageXOfYLabel;
	BOOL sliderMoving;
	UIViewController *thumbnailView;
	UIPopoverController *pop;
}

@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic, retain) UIImageView *tapImageView;

@property (nonatomic, retain) UIViewController *thumbnailView;
@property (nonatomic, retain) UIPopoverController *pop;

@property (nonatomic, retain) IBOutlet UIImageView *slideImage;
@property (nonatomic, retain) IBOutlet UISlider *trackSlider;
@property (nonatomic, retain) IBOutlet UILabel *pageXOfYLabel;

@property BOOL sliderMoving;

-(IBAction) sliderChanged: (id) sender;
-(IBAction) showPopOver: (id) sender;
-(IBAction) endSlideAction: (id) sender;
-(IBAction) startSlideAction: (id) sender;


@end
