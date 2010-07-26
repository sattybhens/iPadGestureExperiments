//
//  SlideViewController.m
//  iPadGestureExperiments
//
//  Created by Satty Bhens on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SlideViewController.h"
#import "ThumbnailViewController.h"


#include <stdlib.h>

@implementation SlideViewController

@synthesize swipeRecognizer, tapRecognizer, slideImageView, tapImageView, trackSlider, triggerPopOver;
@synthesize thumbView, thumbViewLabel, thumbNailImage;

#pragma mark -
#pragma mark Responding to UISlider

-(IBAction) endSlideAction: (id) sender {
  UISlider *slider = (UISlider *)sender;
  NSLog(@"endSlideAction %.1f", slider.value);
  thumbView.hidden = YES;
}

-(IBAction) startSlideAction: (id) sender {
  UISlider *slider = (UISlider *)sender;
  NSLog(@"startSlideAction %.1f", slider.value);
  thumbView.hidden = NO;
}

-(IBAction) sliderChanged: (id) sender {
  UISlider *slider = (UISlider *)sender;
  
  // NSLog(@"MinimumValue %.1f", slider.minimumValue);
  // NSLog(@"MaximumValue %.1f", slider.maximumValue);
  thumbViewLabel.text = [NSString stringWithFormat:@"%.0f of 30", slider.value];
  
  int r = (rand() % 6) +1;
  NSString  *imageName = [NSString stringWithFormat:@"Slide%d.jpg",r];  

  thumbNailImage.image = [UIImage imageNamed:imageName];
}


#pragma mark -
#pragma mark Creating a UIPopOver

-(IBAction) showPopOver: (id) sender {
  
  NSLog(@"Popped");
  UIButton *btn = sender;
  
  ThumbnailViewController *thumb = [[ThumbnailViewController alloc] initWithNibName:@"ThumbnailViewController" bundle:nil];
  //thumb.delegate = self; // setup code for your embedded view controller
  
  UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:thumb];
  
  // pop delegate = self; if UIPopOverControllerDelegate protocol
  [pop setPopoverContentSize:thumb.view.frame.size];

  CGRect popoverRect = [btn frame];
  [pop presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

  [thumb release];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
  self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  
	UIGestureRecognizer *recognizer;
	
	recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
	[self.view addGestureRecognizer:recognizer];
	self.tapRecognizer = (UITapGestureRecognizer *)recognizer;
	recognizer.delegate = self;
	[recognizer release];
	
	
	// recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
	// [self.view addGestureRecognizer:recognizer];
	// [recognizer release];
	
	recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
	[self.view addGestureRecognizer:recognizer];
	[recognizer release];
			
	slideImageView.image = [UIImage imageNamed:@"Slide1.jpg"];
	slideImageView.alpha = 1.0;
	
	/*
	 Create an image view to display the gesture description.
	 */
	UIImageView *anImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 75.0)];
	anImageView.contentMode = UIViewContentModeCenter;
	self.tapImageView = anImageView;
	[anImageView release];
	[self.view addSubview:tapImageView];

  //UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"left-tracker.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
  //UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"right-tracker.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
  //[trackSlider setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
  //[trackSlider setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
  
  UIImage *trackImage = [UIImage imageNamed: @"tracker.png"];
  [trackSlider setThumbImage: trackImage forState: UIControlStateNormal];
  [trackImage release];
  
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Overriden to allow any orientation.
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.tapRecognizer = nil;
	self.swipeRecognizer = nil;
	self.slideImageView = nil;
	self.tapImageView = nil;
	
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Responding to gestures

- (void)showImageWithText:(NSString *)string atPoint:(CGPoint)centerPoint {
	
	/*
	 Set the appropriate image for the image view, move the image view to the given point, then dispay it by setting its alpha to 1.0.
	 */
	NSString *imageName = [string stringByAppendingString:@".png"];
	tapImageView.image = [UIImage imageNamed:imageName];
	tapImageView.center = centerPoint;
	tapImageView.alpha = 1.0;	
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	
	CGPoint location = [recognizer locationInView:self.view];
	[self showImageWithText:@"tap" atPoint:location];
	tapImageView.alpha = 0.0;
	  
  CGContextRef context = UIGraphicsGetCurrentContext();
  [UIView beginAnimations:nil context:context];
  
  //[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
  
  // -- These don't work on the simulator and the curl up will turn into a fade -- //
  //[UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:[self superview] cache:YES];
  //[UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:[self superview] cache:YES];
  
  //[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
  [UIView setAnimationDuration:0.8];
  
  // Below assumes you have two subviews that you're trying to transition between
  slideImageView.alpha = 0.3;
  slideImageView.image = [UIImage imageNamed:@"Slide2.jpg"];
  slideImageView.alpha = 1.0;

  [UIView commitAnimations];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
	[tapRecognizer release];
	[swipeRecognizer release];
	[slideImageView release];
	[tapImageView release];
	[super dealloc];
}


@end
