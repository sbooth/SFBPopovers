//
// Copyright (c) 2011 - 2021 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/SFBPopovers
// MIT license
//

#import <Cocoa/Cocoa.h>

/// Popover positioning constants
typedef NS_ENUM(NSUInteger, SFBPopoverPosition) {
	/// Center the popover vertically to the left of the attachment point
	SFBPopoverPositionLeft          = NSMinXEdge,
	/// Center the popover vertically to the right of the attachment point
	SFBPopoverPositionRight         = NSMaxXEdge,
	/// Center the popover horizontally above the attachment point
	SFBPopoverPositionTop           = NSMaxYEdge,
	/// Center the popover horizontally below the attachment point
	SFBPopoverPositionBottom        = NSMinYEdge,
	/// Position the popover to the left of and above the attachment point
	SFBPopoverPositionLeftTop       = 4,
	/// Position the popover to the left of and below the attachment point
	SFBPopoverPositionLeftBottom    = 5,
	/// Position the popover to the right of and above the attachment point
	SFBPopoverPositionRightTop      = 6,
	/// Position the popover to the right of and below the attachment point
	SFBPopoverPositionRightBottom   = 7,
	/// Position the popover above and to the left of the attachment point
	SFBPopoverPositionTopLeft       = 8,
	/// Position the popover above and to the right of the attachment point
	SFBPopoverPositionTopRight      = 9,
	/// Position the popover below and to the left of the attachment point
	SFBPopoverPositionBottomLeft    = 10,
	/// Position the popover below and to the right of the attachment point
	SFBPopoverPositionBottomRight   = 11
};

/// A class that controls display of a popover
@interface SFBPopover : NSResponder


// MARK: Properties

/// Specifies whether the popover animates when displayed
@property (nonatomic, assign) BOOL animates;
/// Specifies whether the popover closes when it resigns key status
/// @note This is determined by receiving @c NSWindowDidResignKeyNotification
@property (nonatomic, assign) BOOL closesWhenPopoverResignsKey;
/// Specifies whether the popover closes when the application becomes inactive
/// @note This is determined by receiving @c NSApplicationDidResignActiveNotification
@property (nonatomic, assign) BOOL closesWhenApplicationBecomesInactive;


// MARK: Creation

/// Initializes and returns a popover containing @c contentView
/// @param contentView The popover's content view
/// @return An initialized popover containing @c contentView
- (nullable instancetype)initWithContentView:(nonnull NSView *)contentView;
/// Initializes and returns a popover with @c contentViewController
/// @param contentViewController The popover's content view controller
/// @return An initialized popover containing @c contentViewController.view
- (nullable instancetype)initWithContentViewController:(nonnull NSViewController *)contentViewController;


// MARK: Geometry determination

/// Returns the best position for @c point in @c window to keep the popover on screen
/// @param window The window to which the popover will attach
/// @param point The desired attachment point, in @c window coordinates
/// @return The best position to keep the popover visible on the same screen as @c window
- (SFBPopoverPosition)bestPositionInWindow:(nonnull NSWindow *)window atPoint:(NSPoint)point;


// Show the popover- prefer these to showWindow:
/// Displays the popover
/// @param window The window to which the popover will attach
/// @param point The desired attachment point, in @c window coordinates
- (void)displayPopoverInWindow:(nonnull NSWindow *)window atPoint:(NSPoint)point;
/// Displays the popover
/// @param window The window to which the popover will attach
/// @param point The desired attachment point, in @c window coordinates
/// @param chooseBestLocation If @c YES the popover's position will be determined using @c -bestPositionInWindow:atPoint:
- (void)displayPopoverInWindow:(nonnull NSWindow *)window atPoint:(NSPoint)point chooseBestLocation:(BOOL)chooseBestLocation;
/// Displays the popover
/// @param window The window to which the popover will attach
/// @param point The desired attachment point, in @c window coordinates
/// @param chooseBestLocation If @c YES the popover's position will be determined using @c -bestPositionInWindow:atPoint:
/// @param makeKey If @c YES the popover will be made the key window
- (void)displayPopoverInWindow:(nonnull NSWindow *)window atPoint:(NSPoint)point chooseBestLocation:(BOOL)chooseBestLocation makeKey:(BOOL)makeKey;


/// Moves the popover to a new attachment point
/// @note The popover should be displayed when calling this method
/// @param point The new attachment point
- (void)movePopoverToPoint:(NSPoint)point;


/// Closes the popover
/// @param sender An optional sender
- (IBAction)closePopover:(nullable id)sender;

/// The popover window
@property (nonatomic, readonly, nonnull) NSWindow * popoverWindow;


/// @c YES if the popover is visible
@property (nonatomic, readonly) BOOL isVisible;


// MARK: Popover window properties

/// The popover's position relative to its attachment point
@property (nonatomic, assign) SFBPopoverPosition position;

/// The distance between the attachment point and the popover window
@property (nonatomic, assign) CGFloat distance;

/// The popover's border color
@property (nonatomic, copy, nonnull) NSColor * borderColor;

/// The width of the popover window's border
@property (nonatomic, assign) CGFloat borderWidth;

/// The radius of the popover window's border
@property (nonatomic, assign) CGFloat cornerRadius;

/// Specifies if the popover window has an arrow pointing toward the attachment point
@property (nonatomic, assign) BOOL drawsArrow;

/// The width of the arrow, if applicable
@property (nonatomic, assign) CGFloat arrowWidth;

/// The height of the arrow, if applicable
@property (nonatomic, assign) CGFloat arrowHeight;

/// If the arrow is drawn by a corner of the window, specifies whether that corner should be rounded
@property (nonatomic, assign) BOOL drawRoundCornerBesideArrow;

/// The spacing between the edge of the popover's content view and its border
@property (nonatomic, assign) CGFloat viewMargin;

/// The popover's background color
@property (nonatomic, copy, nonnull) NSColor * backgroundColor;

/// Specifies whether the popover may be moved by dragging
@property (nonatomic, assign, getter=isMovable) BOOL movable;

/// Specifies whether the popover may be resized
@property (nonatomic, assign, getter=isResizable) BOOL resizable;

@end
