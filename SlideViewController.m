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

// from xib file
@synthesize slideImage, trackSlider, pageXOfYLabel;

@synthesize swipeRecognizer, tapRecognizer, tapImageView;
@synthesize sliderMoving, thumbnailView, pop;

#pragma mark -
#pragma mark Responding to UISlider

-(IBAction) startSlideAction: (id) sender {
  UISlider *slider = (UISlider *)sender;
  NSLog(@"startSlideAction %.1f", slider.value);
  //thumbView.hidden = NO;
	
	sliderMoving = YES;  
}

-(IBAction) endSlideAction: (id) sender {
  UISlider *slider = (UISlider *)sender;
  NSLog(@"endSlideAction %.1f", slider.value);
  //thumbView.hidden = YES;
	sliderMoving = NO;
	
	if (pop.popoverVisible == YES) {
		[pop dismissPopoverAnimated:NO];
		NSLog(@"Dismissing");
	}
}


-(IBAction) sliderChanged: (id) sender {
  UISlider *slider = (UISlider *)sender;
  
	if (pop.popoverVisible == YES) {
		[pop dismissPopoverAnimated:NO];
	}
		
	CGRect popoverRect = [slider frame];
	NSLog(@"UISlide Frame is %@", NSStringFromCGRect(popoverRect));

	
	popoverRect.origin.x += (slider.value* 14.48) -14.48;
	popoverRect.size.width = 23;
	NSLog(@"Updated to %@ for value = %0.1f", NSStringFromCGRect(popoverRect), slider.value);
	
	[pop presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:NO];
	
  pageXOfYLabel.text = [NSString stringWithFormat:@"%.0f of 30", slider.value];
  
  //int r = (rand() % 6) +1;
  //NSString  *imageName = [NSString stringWithFormat:@"Slide%d.jpg",r];  
}

#pragma mark -
#pragma mark Creating a UIPopOver

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {	
  NSLog(@"popoverControllerShouldDismissPopover NO");
	return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  NSLog(@"popoverControllerDidDismissPopover");
	
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
	
	sliderMoving = NO;
	
	thumbnailView = [[ThumbnailViewController alloc] initWithNibName:@"ThumbnailViewController" bundle:nil];
	
	pop = [[UIPopoverController alloc] initWithContentViewController:thumbnailView];
  pop.delegate = self; //if UIPopOverControllerDelegate protocol
	[pop setPopoverContentSize:thumbnailView.view.frame.size];


  self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  
	UIGestureRecognizer *recognizer;
	
	recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
	[self.view addGestureRecognizer:recognizer];
	self.tapRecognizer = (UITapGestureRecognizer *)recognizer;
	recognizer.delegate = self;
	[recognizer release];
		
//	recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//	[self.view addGestureRecognizer:recognizer];
//	self.swipeRecognizer = (UISwipeGestureRecognizer *)recognizer;
//	[recognizer release];
	
//	recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
//	[self.view addGestureRecognizer:recognizer];
//	[recognizer release];
			
	slideImage.image = [UIImage imageNamed:@"Slide1.jpg"];
	slideImage.alpha = 1.0;
	
	/*
	 Create an image view to display the gesture description.
	 */
	UIImageView *anImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 75.0)];
	anImageView.contentMode = UIViewContentModeCenter;
	self.tapImageView = anImageView;
	[anImageView release];
	[self.view addSubview:tapImageView];

  // UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"left-tracker.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
  // UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"right-tracker.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
  // [trackSlider setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
  // [trackSlider setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
  
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
  
  [UIView beginAnimations:nil context:nil];
	tapImageView.alpha = 1.0;
  [UIView setAnimationDuration:0.8];
	tapImageView.alpha = 0.0;  
  [UIView commitAnimations];
}

-(void)handleSlideChange {
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  [UIView beginAnimations:nil context:context];
  
  //[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
  
  // -- These don't work on the simulator and the curl up will turn into a fade -- //
  //[UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:[self superview] cache:YES];
  //[UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:[self superview] cache:YES];
  
  //[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
  [UIView setAnimationDuration:0.8];
  
  // Below assumes you have two subviews that you're trying to transition between
  slideImage.alpha = 0.3;
  slideImage.image = [UIImage imageNamed:@"Slide2.jpg"];
  slideImage.alpha = 1.0;

  [UIView commitAnimations];
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.tapRecognizer = nil;
	self.swipeRecognizer = nil;
	self.slideImage = nil;
	self.tapImageView = nil;
	self.pop = nil;
	self.thumbnailView = nil;
	
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	
	[tapRecognizer release];
	[swipeRecognizer release];
	[slideImage release];
	[tapImageView release];
  
	[pop release];
	[thumbnailView release];
  
	[super dealloc];
}

@end
