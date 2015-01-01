/*
 *  Copyright (C) 2011, 2012, 2013, 2014, 2015 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
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

#import "ExampleAppDelegate.h"
#import <SFBPopovers/SFBPopover.h>

@interface ExampleAppDelegate ()
{
@private
	SFBPopover * _popover;
}
@end

@implementation ExampleAppDelegate

- (void) awakeFromNib
{
	[[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
	[self.parametersWindow center];

	_popover = [[SFBPopover alloc] initWithContentView:self.popoverView];

	// Set up the popover window the match the UI
	[self changePosition:self.positionPopup];
	[self changeBorderColor:self.borderColorWell];
	[self changeBackgroundColor:self.backgroundColorWell];
	[self changeViewMargin:self.viewMarginSlider];
	[self changeBorderWidth:self.borderWidthSlider];
	[self changeCornerRadius:self.cornerRadiusSlider];
	[self changeHasArrow:self.hasArrowCheckbox];
	[self changeDrawRoundCornerBesideArrow:self.drawRoundCornerBesideArrowCheckbox];
	[self changeMovable:self.movableCheckbox];
//	[self changeResizable:self.resizableCheckbox];
	[self changeArrowWidth:self.arrowWidthSlider];
	[self changeArrowHeight:self.arrowHeightSlider];
	[self changeDistance:self.distanceSlider];
}

- (IBAction) changePosition:(id)sender
{
	NSInteger position = [sender indexOfSelectedItem];
	if(12 == position) {
		NSPoint where = [self.toggleButton frame].origin;
		where.x += [self.toggleButton frame].size.width / 2;
		where.y += [self.toggleButton frame].size.height / 2;
		position = [_popover bestPositionInWindow:[self.toggleButton window] atPoint:where];
	}

	[_popover setPosition:(SFBPopoverPosition)position];
}

- (IBAction) changeBorderColor:(id)sender
{
	[_popover setBorderColor:[sender color]];
}

- (IBAction) changeBackgroundColor:(id)sender
{
	[_popover setBackgroundColor:[sender color]];
}

- (IBAction) changeViewMargin:(id)sender
{
	[_popover setViewMargin:floorf([sender floatValue])];
}

- (IBAction) changeBorderWidth:(id)sender
{
	[_popover setBorderWidth:floorf([sender floatValue])];
}

- (IBAction) changeCornerRadius:(id)sender
{
	[_popover setCornerRadius:floorf([sender floatValue])];
}

- (IBAction) changeHasArrow:(id)sender
{
	[_popover setDrawsArrow:(NSOnState == [sender state])];
}

- (IBAction) changeDrawRoundCornerBesideArrow:(id)sender
{
	[_popover setDrawRoundCornerBesideArrow:(NSOnState == [sender state])];
}

- (IBAction) changeMovable:(id)sender
{
	[_popover setMovable:(NSOnState == [sender state])];
}

//- (IBAction) changeResizable:(id)sender
//{
//	[_popover setResizable:(NSOnState == [sender state])];
//}

- (IBAction) changeArrowWidth:(id)sender
{
	[_popover setArrowWidth:floorf([sender floatValue])];
}

- (IBAction) changeArrowHeight:(id)sender
{
	[_popover setArrowHeight:floorf([sender floatValue])];
}

- (IBAction) changeDistance:(id)sender
{
	[_popover setDistance:floorf([sender floatValue])];
}

- (IBAction) togglePopover:(id)sender
{
	if([_popover isVisible])
		[_popover closePopover:sender];
	else {
		NSPoint where = [self.toggleButton frame].origin;
		where.x += [self.toggleButton frame].size.width / 2;
		where.y += [self.toggleButton frame].size.height / 2;

		[_popover displayPopoverInWindow:[self.toggleButton window] atPoint:where];
	}
}

- (void) windowDidResize:(NSNotification *)notification
{
	if([_popover isVisible]) {
		NSPoint where = [self.toggleButton frame].origin;
		where.x += [self.toggleButton frame].size.width / 2;
		where.y += [self.toggleButton frame].size.height / 2;

		[_popover movePopoverToPoint:where];
    }
}

@end
