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

#import "ExampleAppDelegate.h"
#import <SFBPopovers/SFBPopoverWindow.h>

@implementation ExampleAppDelegate

@synthesize positionPopup, borderColorWell, backgroundColorWell, viewMarginSlider, borderWidthSlider, cornerRadiusSlider, hasArrowCheckbox, drawRoundCornerBesideArrowCheckbox, arrowWidthSlider, arrowHeightSlider, distanceSlider, toggleButton, popoverWindow, parametersWindow;

- (void) awakeFromNib
{
	[[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
	[parametersWindow center];

	_popoverController = [[SFBPopoverWindowController alloc] initWithWindow:popoverWindow];

	// Set up the popover window the match the UI
	[self changePosition:positionPopup];
	[self changeBorderColor:borderColorWell];
	[self changeBackgroundColor:backgroundColorWell];
	[self changeViewMargin:viewMarginSlider];
	[self changeBorderWidth:borderWidthSlider];
	[self changeCornerRadius:cornerRadiusSlider];
	[self changeHasArrow:hasArrowCheckbox];
	[self changeDrawRoundCornerBesideArrow:drawRoundCornerBesideArrowCheckbox];
	[self changeArrowWidth:arrowWidthSlider];
	[self changeArrowHeight:arrowHeightSlider];
	[self changeDistance:distanceSlider];
}

- (IBAction) changePosition:(id)sender
{
	NSInteger position = [sender indexOfSelectedItem];
	if(12 == position) {
		NSPoint where = [toggleButton frame].origin;
		where.x += [toggleButton frame].size.width / 2;
		where.y += [toggleButton frame].size.height / 2;
		position = [_popoverController bestPositionInWindow:[toggleButton window] atPoint:where];
	}

	[[_popoverController popoverWindow] setPopoverPosition:(SFBPopoverPosition)position];
}

- (IBAction) changeBorderColor:(id)sender
{
	[[_popoverController popoverWindow] setBorderColor:[sender color]];
}

- (IBAction) changeBackgroundColor:(id)sender
{
	[[_popoverController popoverWindow] setPopoverBackgroundColor:[sender color]];
}

- (IBAction) changeViewMargin:(id)sender
{
	[[_popoverController popoverWindow] setViewMargin:floorf([sender floatValue])];
}

- (IBAction) changeBorderWidth:(id)sender
{
	[[_popoverController popoverWindow] setBorderWidth:floorf([sender floatValue])];
}

- (IBAction) changeCornerRadius:(id)sender
{
	[[_popoverController popoverWindow] setCornerRadius:floorf([sender floatValue])];
}

- (IBAction) changeHasArrow:(id)sender
{
	[[_popoverController popoverWindow] setDrawsArrow:(NSOnState == [sender state])];
}

- (IBAction) changeDrawRoundCornerBesideArrow:(id)sender
{
	[[_popoverController popoverWindow] setDrawRoundCornerBesideArrow:(NSOnState == [sender state])];
}

- (IBAction) changeArrowWidth:(id)sender
{
	[[_popoverController popoverWindow] setArrowWidth:floorf([sender floatValue])];
}

- (IBAction) changeArrowHeight:(id)sender
{
	[[_popoverController popoverWindow] setArrowHeight:floorf([sender floatValue])];
}

- (IBAction) changeDistance:(id)sender
{
	[[_popoverController popoverWindow] setDistance:floorf([sender floatValue])];
}

- (IBAction) togglePopover:(id)sender
{
	if([[_popoverController window] isVisible])
		[_popoverController closePopover:sender];
	else {
		NSPoint where = [toggleButton frame].origin;
		where.x += [toggleButton frame].size.width / 2;
		where.y += [toggleButton frame].size.height / 2;

		[_popoverController displayPopoverInWindow:[toggleButton window] atPoint:where];
	}
}

- (void)windowDidResize:(NSNotification *)notification
{
	if([[_popoverController window] isVisible]) {
		NSPoint where = [toggleButton frame].origin;
		where.x += [toggleButton frame].size.width / 2;
		where.y += [toggleButton frame].size.height / 2;

		[_popoverController movePopoverToPoint:where];
    }
}

@end
