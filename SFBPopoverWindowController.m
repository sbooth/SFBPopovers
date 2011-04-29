/*
 *  Copyright (C) 2011 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *    - Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    - Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    - Neither the name of Stephen F. Booth nor the names of its 
 *      contributors may be used to endorse or promote products derived
 *      from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SFBPopoverWindowController.h"
#import "SFBPopoverWindowFrame.h"

#include <QuartzCore/QuartzCore.h>

@interface SFBPopoverWindow (Private)
- (SFBPopoverWindowFrame *) popoverWindowFrame;
@end

@implementation SFBPopoverWindowController

@synthesize animates = _animates;

- (id) initWithView:(NSView *)view
{
	NSParameterAssert(nil != view);

	NSViewController *viewController = [[NSViewController alloc] initWithNibName:nil bundle:nil];
	[viewController setView:view];

	return [self initWithViewController:[viewController autorelease]];
}

- (id) initWithViewController:(NSViewController *)viewController
{
	NSParameterAssert(nil != viewController);

	NSWindow *window = [[SFBPopoverWindow alloc] initWithContentRect:NSZeroRect
														   styleMask:NSBorderlessWindowMask 
															 backing:NSBackingStoreBuffered 
															   defer:YES];

	if((self = [super initWithWindow:[window autorelease]])) {
		_viewController = [_viewController retain];
		[[self popoverWindow] setContentView:[viewController view]];
//		_animates = YES;

		CAAnimation *animation = [CABasicAnimation animation];
		[animation setDelegate:self];
		[[self window] setAnimations:[NSDictionary dictionaryWithObject:animation forKey:@"alphaValue"]];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidResignActive:) name:NSApplicationDidResignActiveNotification object:nil];
	}

	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[_viewController release], _viewController = nil;

	[super dealloc];
}

- (void) windowDidLoad
{
	[super windowDidLoad];
}

- (SFBPopoverPosition) bestPositionInWindow:(NSWindow *)window atPoint:(NSPoint)point
{
	// Get all relevant geometry in screen coordinates.
	NSRect screenFrame = NSZeroRect;
	if(window && [window screen])
		screenFrame = [[window screen] visibleFrame];
	else
		screenFrame = [[NSScreen mainScreen] visibleFrame];

	NSPoint pointOnScreen = (nil != window) ? [window convertBaseToScreen:point] : point;

	SFBPopoverWindow *popoverWindow = [self popoverWindow];
	NSSize popoverSize = [popoverWindow frame].size;

	// By default, position us centered below.
	SFBPopoverPosition side = SFBPopoverPositionBottom;

	// We'd like to display directly below the specified point, since this gives a 
	// sense of a relationship between the point and this window. Check there's room.
	if(pointOnScreen.y - popoverSize.height - [popoverWindow arrowHeight] < NSMinY(screenFrame)) {
		// We'd go off the bottom of the screen. Try the right.
		if(pointOnScreen.x + popoverSize.width + [popoverWindow arrowHeight] >= NSMaxX(screenFrame)) {
			// We'd go off the right of the screen. Try the left.
			if(pointOnScreen.x - popoverSize.width - [popoverWindow arrowHeight] < NSMinX(screenFrame)) {
				// We'd go off the left of the screen. Try the top.
				if (pointOnScreen.y + popoverSize.height + [popoverWindow arrowHeight] < NSMaxY(screenFrame))
					side = SFBPopoverPositionTop;
			}
			else
				side = SFBPopoverPositionLeft;
		}
		else
			side = SFBPopoverPositionRight;
	}

	CGFloat halfWidth = popoverSize.width / 2;
	CGFloat halfHeight = popoverSize.height / 2;

	NSRect parentFrame = (window) ? [window frame] : screenFrame;
	CGFloat arrowInset = ([popoverWindow arrowWidth] / 2) + ([popoverWindow drawRoundCornerBesideArrow] ? [popoverWindow cornerRadius] : 0);

	// We're currently at a primary side.
	// Try to avoid going outwith the parent area in the secondary dimension,
	// by checking to see if an appropriate corner side would be better.
	switch(side) {
		case SFBPopoverPositionBottom:
		case SFBPopoverPositionTop:
			// Check to see if we go beyond the left edge of the parent area.
			if(pointOnScreen.x - halfWidth < NSMinX(parentFrame)) {
				// We go beyond the left edge. Try using right position.
				if(pointOnScreen.x + popoverSize.width - arrowInset < NSMaxX(screenFrame)) {
					// We'd still be on-screen using right, so use it.
					if(SFBPopoverPositionBottom == side)
						side = SFBPopoverPositionBottomRight;
					else
						side = SFBPopoverPositionTopRight;
				}
			}
			else if(pointOnScreen.x + halfWidth >= NSMaxX(parentFrame)) {
				// We go beyond the right edge. Try using left position.
				if(pointOnScreen.x - popoverSize.width + arrowInset >= NSMinX(screenFrame)) {
					// We'd still be on-screen using left, so use it.
					if(SFBPopoverPositionBottom == side)
						side = SFBPopoverPositionBottomLeft;
					else
						side = SFBPopoverPositionTopLeft;
				}
			}
			break;

		case SFBPopoverPositionRight:
		case SFBPopoverPositionLeft:
			// Check to see if we go beyond the bottom edge of the parent area.
			if(pointOnScreen.y - halfHeight < NSMinY(parentFrame)) {
				// We go beyond the bottom edge. Try using top position.
				if(pointOnScreen.y + popoverSize.height - arrowInset < NSMaxY(screenFrame)) {
					// We'd still be on-screen using top, so use it.
					if(SFBPopoverPositionRight == side)
						side = SFBPopoverPositionRightTop;
					else
						side = SFBPopoverPositionLeftTop;
				}
			}
			else if(pointOnScreen.y + halfHeight >= NSMaxY(parentFrame)) {
				// We go beyond the top edge. Try using bottom position.
				if(pointOnScreen.y - popoverSize.height + arrowInset >= NSMinY(screenFrame)) {
					// We'd still be on-screen using bottom, so use it.
					if(SFBPopoverPositionRight == side)
						side = SFBPopoverPositionRightBottom;
					else
						side = SFBPopoverPositionLeftBottom;
				}
			}
			break;

		default:
			break;
	}

	return side;
}

- (void) displayPopoverInWindow:(NSWindow *)window atPoint:(NSPoint)point
{
	[self displayPopoverInWindow:window atPoint:point chooseBestLocation:NO];
}

- (void) displayPopoverInWindow:(NSWindow *)window atPoint:(NSPoint)point chooseBestLocation:(BOOL)chooseBestLocation
{
	if([[self window] isVisible])
		return;

	if(chooseBestLocation)
		[[self popoverWindow] setPopoverPosition:[self bestPositionInWindow:window atPoint:point]];

	NSPoint arrowheadPoint = [[[self popoverWindow] popoverWindowFrame] arrowheadPosition];
	NSPoint pointOnScreen = (nil != window) ? [window convertBaseToScreen:point] : point;

	pointOnScreen.x -= arrowheadPoint.x;
	pointOnScreen.y -= arrowheadPoint.y;

	[[self window] setFrameOrigin:pointOnScreen];

	if(_animates)
		[[self window] setAlphaValue:0];

	[window addChildWindow:[self window] ordered:NSWindowAbove];

	[[self window] makeKeyAndOrderFront:nil];

	if(_animates)
		[[[self window] animator] setAlphaValue:1];
}

- (IBAction) closePopover:(id)sender
{
	if(![[self window] isVisible])
		return;

//	[NSAnimationContext beginGrouping];
//	[[NSAnimationContext currentContext] setDuration:0];
//	[[[self window] animator] setAlphaValue:0];
//	[NSAnimationContext endGrouping];

	if(_animates)
		[[[self window] animator] setAlphaValue:0];
	else {
		[[self window] orderOut:sender];
		NSWindow *parentWindow = [[self window] parentWindow];
		[parentWindow removeChildWindow:[self window]];
		[parentWindow makeKeyAndOrderFront:nil];
	}
}

- (SFBPopoverWindow *) popoverWindow
{
	return (SFBPopoverWindow *)[self window];
}

@end

@implementation SFBPopoverWindowController (NSAnimationDelegateMethods)

- (void) animationDidStop:(CAAnimation *)animation finished:(BOOL)flag 
{
#pragma unused(animation)
	// Detect the end of fade out and close the window
	if(flag && 0 == [[self window] alphaValue]) {
		[[self window] orderOut:nil];
		[[self window] setAlphaValue:1];

		NSWindow *parentWindow = [[self window] parentWindow];
		[parentWindow removeChildWindow:[self window]];
		[parentWindow makeKeyAndOrderFront:nil];
	}
}

@end

@implementation SFBPopoverWindowController (NSWindowDelegateMethods)

//- (void) windowWillClose:(NSNotification *)notification
//{}

- (void) windowDidResignKey:(NSNotification *)notification
{
	if(_closesWhenPopoverResignsKey)
		[self closePopover:notification];
}

- (void) applicationDidResignActive:(NSNotification *)notification
{
	if(_closesWhenApplicationBecomesInactive)
		[self closePopover:notification];
}

@end

