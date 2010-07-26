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
  UISlider *trackSlider;
  UIButton *triggerPopOver;
  UIView *thumbView;
  UILabel *thumbViewLabel;
  UIImageView *thumbNailImage;
}

@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic, retain) UIImageView *tapImageView;

@property (nonatomic, retain) IBOutlet UIImageView *slideImageView;
@property (nonatomic, retain) IBOutlet UISlider *trackSlider;
@property (nonatomic, retain) IBOutlet UIButton *triggerPopOver;
@property (nonatomic, retain) IBOutlet UIView *thumbView;
@property (nonatomic, retain) IBOutlet UILabel *thumbViewLabel;
@property (nonatomic, retain) IBOutlet UIImageView *thumbNailImage;

-(IBAction) sliderChanged: (id) sender;
-(IBAction) showPopOver: (id) sender;
-(IBAction) endSlideAction: (id) sender;
-(IBAction) startSlideAction: (id) sender;


@end
