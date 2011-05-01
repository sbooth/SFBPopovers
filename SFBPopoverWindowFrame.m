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

#import "SFBPopoverWindowFrame.h"
#import "SFBPopoverWindow.h"

@interface SFBPopoverWindowFrame (Private)
- (NSBezierPath *) popoverFramePathForContentRect:(NSRect)rect;
- (void) appendArrowToPath:(NSBezierPath *)path;
@end

@implementation SFBPopoverWindowFrame

@synthesize popoverPosition = _popoverPosition;

@synthesize distance = _distance;

@synthesize borderColor = _borderColor;
@synthesize borderWidth = _borderWidth;
@synthesize cornerRadius = _cornerRadius;

@synthesize drawsArrow = _drawsArrow;
@synthesize arrowWidth = _arrowWidth;
@synthesize arrowHeight = _arrowHeight;
@synthesize drawRoundCornerBesideArrow = _drawRoundCornerBesideArrow;

@synthesize viewMargin = _viewMargin;
@synthesize backgroundColor = _backgroundColor;

- (id) initWithFrame:(NSRect)frame
{
	if((self = [super initWithFrame:frame])) {
		// Set the default appearance
		_popoverPosition = SFBPopoverPositionBottom;

		_distance = 0;

		_borderColor = [[NSColor whiteColor] copy];
		_borderWidth = 2;
		_cornerRadius = 8;

		_drawsArrow = YES;
		_arrowWidth = 20;
		_arrowHeight = 16;
		_drawRoundCornerBesideArrow = YES;

		_viewMargin = 2;
		_backgroundColor = [[NSColor colorWithCalibratedWhite:(CGFloat)0.1 alpha:(CGFloat)0.75] copy];
	}

	return self;
}

- (void) dealloc
{
	[_borderColor release], _borderColor = nil;
	[_backgroundColor release], _backgroundColor = nil;

	[super dealloc];
}

- (NSRect) frameRectForContentRect:(NSRect)contentRect
{
	NSRect frameRect = NSInsetRect(contentRect, -_viewMargin, -_viewMargin);

	CGFloat offset = _arrowHeight + _distance;
	switch(_popoverPosition) {
		case SFBPopoverPositionLeft:
		case SFBPopoverPositionLeftTop:
		case SFBPopoverPositionLeftBottom:
			frameRect.size.width += offset;
			break;

		case SFBPopoverPositionRight:
		case SFBPopoverPositionRightTop:
		case SFBPopoverPositionRightBottom:
			frameRect.size.width += offset;
			frameRect.origin.x -= offset;
			break;
			
		case SFBPopoverPositionTop:
		case SFBPopoverPositionTopLeft:
		case SFBPopoverPositionTopRight:
			frameRect.size.height += offset;
			frameRect.origin.y += offset;
			break;

		case SFBPopoverPositionBottom:
		case SFBPopoverPositionBottomLeft:
		case SFBPopoverPositionBottomRight:
			frameRect.size.height += offset;
			break;
	}

	return NSInsetRect(frameRect, -_borderWidth, -_borderWidth);
}

- (NSRect) contentRectForFrameRect:(NSRect)windowFrame
{
	NSRect contentRect = NSInsetRect(windowFrame, _borderWidth, _borderWidth);

	CGFloat offset = _arrowHeight + _distance;
	switch(_popoverPosition) {
		case SFBPopoverPositionLeft:
		case SFBPopoverPositionLeftTop:
		case SFBPopoverPositionLeftBottom:
			contentRect.size.width -= offset;
			break;

		case SFBPopoverPositionRight:
		case SFBPopoverPositionRightTop:
		case SFBPopoverPositionRightBottom:
			contentRect.size.width -= offset;
			contentRect.origin.x += offset;
			break;
			
		case SFBPopoverPositionTop:
		case SFBPopoverPositionTopLeft:
		case SFBPopoverPositionTopRight:
			contentRect.size.height -= offset;
			contentRect.origin.y += offset;
			break;

		case SFBPopoverPositionBottom:
		case SFBPopoverPositionBottomLeft:
		case SFBPopoverPositionBottomRight:
			contentRect.size.height -= offset;
			break;
	}
	
	return NSInsetRect(contentRect, _viewMargin, _viewMargin);
}

- (NSPoint) attachmentPoint
{
	return [self attachmentPointForRect:[self bounds]];
}

- (NSPoint) attachmentPointForRect:(NSRect)rect;
{
	NSPoint arrowheadPosition = NSZeroPoint;

	CGFloat minX = NSMinX(rect);
	CGFloat midX = NSMidX(rect);
	CGFloat maxX = NSMaxX(rect);

	CGFloat minY = NSMinY(rect);
	CGFloat midY = NSMidY(rect);
	CGFloat maxY = NSMaxY(rect);

	CGFloat arrowDistance = (_arrowHeight / 2) + (2 * _borderWidth);
	if(_drawRoundCornerBesideArrow)
		arrowDistance += _cornerRadius;

	switch(_popoverPosition) {
		case SFBPopoverPositionLeft:
			arrowheadPosition = NSMakePoint(maxX, midY);
			break;

		case SFBPopoverPositionLeftTop:
			arrowheadPosition = NSMakePoint(maxX, minY + arrowDistance);
			break;

		case SFBPopoverPositionLeftBottom:
			arrowheadPosition = NSMakePoint(maxX, maxY - arrowDistance);
			break;

		case SFBPopoverPositionRight:
			arrowheadPosition = NSMakePoint(minX, midY);
			break;

		case SFBPopoverPositionRightTop:
			arrowheadPosition = NSMakePoint(minX, minY + arrowDistance);
			break;

		case SFBPopoverPositionRightBottom:
			arrowheadPosition = NSMakePoint(minX, maxY - arrowDistance);
			break;
			
		case SFBPopoverPositionTop:
			arrowheadPosition = NSMakePoint(midX, minY);
			break;

		case SFBPopoverPositionTopLeft:
			arrowheadPosition = NSMakePoint(maxX - arrowDistance, minY);
			break;

		case SFBPopoverPositionTopRight:
			arrowheadPosition = NSMakePoint(minX + arrowDistance, minY);
			break;

		case SFBPopoverPositionBottom:
			arrowheadPosition = NSMakePoint(midX, maxY);
			break;

		case SFBPopoverPositionBottomLeft:
			arrowheadPosition = NSMakePoint(maxX - arrowDistance, maxY);
			break;

		case SFBPopoverPositionBottomRight:
			arrowheadPosition = NSMakePoint(minX + arrowDistance, maxY);
			break;
	}
	
	return arrowheadPosition;
}

- (void) drawRect:(NSRect)dirtyRect
{
	[NSBezierPath clipRect:dirtyRect];

	NSRect contentRect = [self contentRectForFrameRect:[self bounds]];
    NSBezierPath *path = [self popoverFramePathForContentRect:contentRect];

    [_backgroundColor set];
    [path fill];
    
	[path setLineWidth:_borderWidth];
    [_borderColor set];
    [path stroke];
}

@end

@implementation SFBPopoverWindowFrame (Private)

- (NSBezierPath *) popoverFramePathForContentRect:(NSRect)contentRect
{
	contentRect = NSInsetRect(contentRect, -_viewMargin, -_viewMargin);
	contentRect = NSInsetRect(contentRect, -_borderWidth / 2, -_borderWidth / 2);

	CGFloat minX = NSMinX(contentRect);
	CGFloat midX = NSMidX(contentRect);
	CGFloat maxX = NSMaxX(contentRect);

	CGFloat minY = NSMinY(contentRect);
	CGFloat midY = NSMidY(contentRect);
	CGFloat maxY = NSMaxY(contentRect);

	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineJoinStyle:NSRoundLineJoinStyle];

	NSPoint currentPoint = NSMakePoint(minX, maxY);
	if(0 < _cornerRadius && (_drawRoundCornerBesideArrow || (SFBPopoverPositionBottomRight != _popoverPosition && SFBPopoverPositionRightBottom != _popoverPosition)))
		currentPoint.x += _cornerRadius;

	NSPoint endOfLine = NSMakePoint(maxX, maxY);
	BOOL shouldDrawNextCorner = NO;
	if(0 < _cornerRadius && (_drawRoundCornerBesideArrow || (SFBPopoverPositionBottomLeft != _popoverPosition && SFBPopoverPositionLeftBottom != _popoverPosition))) {
		endOfLine.x -= _cornerRadius;
		shouldDrawNextCorner = YES;
	}

	[path moveToPoint:currentPoint];

	// If arrow should be drawn at top-left point, draw it.
	if(SFBPopoverPositionBottomRight == _popoverPosition)
		[self appendArrowToPath:path];
	else if(SFBPopoverPositionBottom == _popoverPosition) {
		[path lineToPoint:NSMakePoint(midX - (_arrowWidth / 2), maxY)];
		[self appendArrowToPath:path];
	}
	else if(SFBPopoverPositionBottomLeft == _popoverPosition) {
		[path lineToPoint:NSMakePoint(endOfLine.x - _arrowWidth, maxY)];
		[self appendArrowToPath:path];
	}

	// Line to end of this side.
	[path lineToPoint:endOfLine];

	// Rounded corner on top-right.
	if(shouldDrawNextCorner)
		[path appendBezierPathWithArcFromPoint:NSMakePoint(maxX, maxY) 
									   toPoint:NSMakePoint(maxX, maxY - _cornerRadius) 
										radius:_cornerRadius];

	// Draw the right side, beginning at the top-right.
	endOfLine = NSMakePoint(maxX, minY);
	shouldDrawNextCorner = NO;
	if(0 < _cornerRadius && (_drawRoundCornerBesideArrow || (SFBPopoverPositionTopLeft != _popoverPosition && SFBPopoverPositionLeftTop != _popoverPosition))) {
		endOfLine.y += _cornerRadius;
		shouldDrawNextCorner = YES;
	}

	// If arrow should be drawn at right-top point, draw it.
	if(SFBPopoverPositionLeftBottom == _popoverPosition)
		[self appendArrowToPath:path];
	else if(SFBPopoverPositionLeft == _popoverPosition) {
		[path lineToPoint:NSMakePoint(maxX, midY + (_arrowWidth / 2))];
		[self appendArrowToPath:path];
	}
	else if(SFBPopoverPositionLeftTop == _popoverPosition) {
		[path lineToPoint:NSMakePoint(maxX, endOfLine.y + _arrowWidth)];
		[self appendArrowToPath:path];
	}

	// Line to end of this side.
	[path lineToPoint:endOfLine];

	// Rounded corner on bottom-right.
	if(shouldDrawNextCorner)
		[path appendBezierPathWithArcFromPoint:NSMakePoint(maxX, minY) 
									   toPoint:NSMakePoint(maxX - _cornerRadius, minY) 
										radius:_cornerRadius];

	// Draw the bottom side, beginning at the bottom-right.
	endOfLine = NSMakePoint(minX, minY);
	shouldDrawNextCorner = NO;
	if(0 < _cornerRadius && (_drawRoundCornerBesideArrow || (SFBPopoverPositionTopRight != _popoverPosition && SFBPopoverPositionRightTop != _popoverPosition))) {
		endOfLine.x += _cornerRadius;
		shouldDrawNextCorner = YES;
	}

	// If arrow should be drawn at bottom-right point, draw it.
	if(SFBPopoverPositionTopLeft == _popoverPosition)
		[self appendArrowToPath:path];
	else if(SFBPopoverPositionTop == _popoverPosition) {
		[path lineToPoint:NSMakePoint(midX + (_arrowWidth / 2), minY)];
		[self appendArrowToPath:path];
	}
	else if(SFBPopoverPositionTopRight == _popoverPosition) {
		[path lineToPoint:NSMakePoint(endOfLine.x + _arrowWidth, minY)];
		[self appendArrowToPath:path];
	}

	// Line to end of this side.
	[path lineToPoint:endOfLine];

	// Rounded corner on bottom-left.
	if(shouldDrawNextCorner)
		[path appendBezierPathWithArcFromPoint:NSMakePoint(minX, minY) 
									   toPoint:NSMakePoint(minX, minY + _cornerRadius) 
										radius:_cornerRadius];

	// Draw the left side, beginning at the bottom-left.
	endOfLine = NSMakePoint(minX, maxY);
	shouldDrawNextCorner = NO;
	if(0 < _cornerRadius && (_drawRoundCornerBesideArrow || (SFBPopoverPositionRightBottom != _popoverPosition && SFBPopoverPositionBottomRight != _popoverPosition))) {
		endOfLine.y -= _cornerRadius;
		shouldDrawNextCorner = YES;
	}

	// If arrow should be drawn at left-bottom point, draw it.
	if(SFBPopoverPositionRightTop == _popoverPosition)
		[self appendArrowToPath:path];
	else if(SFBPopoverPositionRight == _popoverPosition) {
		[path lineToPoint:NSMakePoint(minX, midY - (_arrowWidth / 2))];
		[self appendArrowToPath:path];
	}
	else if(SFBPopoverPositionRightBottom == _popoverPosition) {
		[path lineToPoint:NSMakePoint(minX, endOfLine.y - _arrowWidth)];
		[self appendArrowToPath:path];
	}

	// Line to end of this side.
	[path lineToPoint:endOfLine];

	// Rounded corner on top-left.
	if(shouldDrawNextCorner)
		[path appendBezierPathWithArcFromPoint:NSMakePoint(minX, maxY) 
									   toPoint:NSMakePoint(minX + _cornerRadius, maxY) 
										radius:_cornerRadius];

	[path closePath];
	return path;
}


- (void) appendArrowToPath:(NSBezierPath *)path
{
	if(!_drawsArrow)
		return;

	NSPoint currentPoint = [path currentPoint];
	NSPoint tipPoint = currentPoint;
	NSPoint endPoint = currentPoint;

	switch(_popoverPosition) {
		case SFBPopoverPositionLeft:
		case SFBPopoverPositionLeftTop:
		case SFBPopoverPositionLeftBottom:
			// Arrow points towards right. We're starting from the top.
			tipPoint.x += _arrowHeight;
			tipPoint.y -= _arrowWidth / 2;
			endPoint.y -= _arrowWidth;
			break;

		case SFBPopoverPositionRight:
		case SFBPopoverPositionRightTop:
		case SFBPopoverPositionRightBottom:
			// Arrow points towards left. We're starting from the bottom.
			tipPoint.x -= _arrowHeight;
			tipPoint.y += _arrowWidth / 2;
			endPoint.y += _arrowWidth;
			break;

		case SFBPopoverPositionTop:
		case SFBPopoverPositionTopLeft:
		case SFBPopoverPositionTopRight:
			// Arrow points towards bottom. We're starting from the right.
			tipPoint.y -= _arrowHeight;
			tipPoint.x -= _arrowWidth / 2;
			endPoint.x -= _arrowWidth;
			break;

		case SFBPopoverPositionBottom:
		case SFBPopoverPositionBottomLeft:
		case SFBPopoverPositionBottomRight:
			// Arrow points towards top. We're starting from the left.
			tipPoint.y += _arrowHeight;
			tipPoint.x += _arrowWidth / 2;
			endPoint.x += _arrowWidth;
			break;
	}

	[path lineToPoint:tipPoint];
	[path lineToPoint:endPoint];
}

@end
