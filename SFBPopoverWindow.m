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

#import "SFBPopoverWindow.h"
#import "SFBPopoverWindowFrame.h"

@interface SFBPopoverWindow (Private)
- (SFBPopoverWindowFrame *) popoverWindowFrame;
- (void) updateGeometryWithContentRect:(NSRect)contentRect display:(BOOL)display;
@end

@implementation SFBPopoverWindow

- (id) initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation
{
#pragma unused(windowStyle)
	if((self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:deferCreation])) {
		[super setBackgroundColor:[NSColor clearColor]];
		[self setMovableByWindowBackground:NO];
		[self setExcludedFromWindowsMenu:YES];
		[self setAlphaValue:1];
		[self setOpaque:NO];
		[self setHasShadow:YES];
		[self useOptimizedDrawing:YES];
	}

	return self;
}

- (void) dealloc
{
	[_popoverContentView release], _popoverContentView = nil;

	[super dealloc];
}

- (NSRect) contentRectForFrameRect:(NSRect)windowFrame
{
	return [[self popoverWindowFrame] contentRectForFrameRect:windowFrame];
}

- (NSRect) frameRectForContentRect:(NSRect)contentRect
{
	return [[self popoverWindowFrame] frameRectForContentRect:contentRect];
}

- (BOOL) canBecomeKeyWindow
{
	return YES;
}

- (BOOL) canBecomeMainWindow
{
	return NO;
}

- (NSView *) contentView
{
	return [[_popoverContentView retain] autorelease];
}

- (void) setContentView:(NSView *)view
{
	if([_popoverContentView isEqualTo:view])
		return;

	SFBPopoverWindowFrame *popoverWindowFrame = [self popoverWindowFrame];
	if(nil == popoverWindowFrame) {
		popoverWindowFrame = [[SFBPopoverWindowFrame alloc] initWithFrame:NSZeroRect];
		[super setContentView:[popoverWindowFrame autorelease]];
	}

	// Automatically resize the window to match the size of the new content
	NSRect windowFrame = [popoverWindowFrame frameRectForContentRect:[view frame]];
	windowFrame.origin = NSZeroPoint;
	[self setFrame:windowFrame display:NO];

	if(_popoverContentView) {
		[_popoverContentView removeFromSuperview];
		[_popoverContentView release], _popoverContentView = nil;
	}

	_popoverContentView = [view retain];
	NSRect viewFrame = [self contentRectForFrameRect:windowFrame];
	[_popoverContentView setFrame:viewFrame];
	[_popoverContentView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];

	[popoverWindowFrame addSubview:_popoverContentView];
}

- (void) setContentSize:(NSSize)size
{
	NSRect contentRect = NSMakeRect(0, 0, size.width, size.height);
	NSRect frameRect = [self frameRectForContentRect:contentRect];
	frameRect.origin = NSZeroPoint;
	[self setFrame:frameRect display:NO];
}

- (SFBPopoverPosition) popoverPosition
{
	return [[self popoverWindowFrame] popoverPosition];
}

- (void) setPopoverPosition:(SFBPopoverPosition)popoverPosition
{
	NSRect contentRect = [self contentRectForFrameRect:[self frame]];
	[[self popoverWindowFrame] setPopoverPosition:popoverPosition];
	[self updateGeometryWithContentRect:contentRect display:YES];
}

- (NSColor *) borderColor
{
	return [[self popoverWindowFrame] borderColor];
}

- (void) setBorderColor:(NSColor *)borderColor
{
	[[self popoverWindowFrame] setBorderColor:borderColor];
	[[self popoverWindowFrame] setNeedsDisplay:YES];
}

- (CGFloat) borderWidth
{
	return [[self popoverWindowFrame] borderWidth];
}

- (void) setBorderWidth:(CGFloat)borderWidth
{
	NSRect contentRect = [self contentRectForFrameRect:[self frame]];
	[[self popoverWindowFrame] setBorderWidth:borderWidth];
	[self updateGeometryWithContentRect:contentRect display:YES];
}

- (CGFloat) cornerRadius
{
	return [[self popoverWindowFrame] cornerRadius];
}

- (void) setCornerRadius:(CGFloat)cornerRadius
{
	NSRect contentRect = [self contentRectForFrameRect:[self frame]];
	[[self popoverWindowFrame] setCornerRadius:cornerRadius];
	[self updateGeometryWithContentRect:contentRect display:YES];
}

- (BOOL) drawsArrow
{
	return [[self popoverWindowFrame] drawsArrow];
}

- (void) setDrawsArrow:(BOOL)drawsArrow
{
	[[self popoverWindowFrame] setDrawsArrow:drawsArrow];
	[[self popoverWindowFrame] setNeedsDisplay:YES];
}

- (CGFloat) arrowWidth
{
	return [[self popoverWindowFrame] arrowWidth];
}

- (void) setArrowWidth:(CGFloat)arrowWidth
{
	[[self popoverWindowFrame] setArrowWidth:arrowWidth];
	[[self popoverWindowFrame] setNeedsDisplay:YES];
}

- (CGFloat) arrowHeight
{
	return [[self popoverWindowFrame] arrowHeight];
}

- (void) setArrowHeight:(CGFloat)arrowHeight
{
	NSRect contentRect = [self contentRectForFrameRect:[self frame]];
	[[self popoverWindowFrame] setArrowHeight:arrowHeight];
	[self updateGeometryWithContentRect:contentRect display:YES];
}

- (BOOL) drawRoundCornerBesideArrow
{
	return [[self popoverWindowFrame] drawRoundCornerBesideArrow];
}

- (void)setDrawRoundCornerBesideArrow:(BOOL)drawRoundCornerBesideArrow
{
	[[self popoverWindowFrame] setDrawRoundCornerBesideArrow:drawRoundCornerBesideArrow];
	[[self popoverWindowFrame] setNeedsDisplay:YES];
}

- (CGFloat) viewMargin
{
	return [[self popoverWindowFrame] viewMargin];
}

- (void) setViewMargin:(CGFloat)viewMargin
{
	NSRect contentRect = [self contentRectForFrameRect:[self frame]];
	[[self popoverWindowFrame] setViewMargin:viewMargin];
	[self updateGeometryWithContentRect:contentRect display:YES];
}

- (NSColor *) popoverBackgroundColor
{
	return [[self popoverWindowFrame] backgroundColor];
}

- (void) setPopoverBackgroundColor:(NSColor *)backgroundColor
{
	[[self popoverWindowFrame] setBackgroundColor:backgroundColor];
	[[self popoverWindowFrame] setNeedsDisplay:YES];
}

@end

@implementation SFBPopoverWindow (Private)

- (SFBPopoverWindowFrame *) popoverWindowFrame
{
	return (SFBPopoverWindowFrame *)[super contentView];
}

- (void) updateGeometryWithContentRect:(NSRect)contentRect display:(BOOL)display
{
	// Update the frames for both the window and content views
	NSRect windowFrame = [self frameRectForContentRect:contentRect];
	windowFrame.origin = NSZeroPoint;
	[self setFrame:windowFrame display:NO];

	contentRect = [self contentRectForFrameRect:windowFrame];
	[_popoverContentView setFrame:contentRect];
	[[self popoverWindowFrame] setNeedsDisplay:display];
}

@end
