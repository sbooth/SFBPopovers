//
// Copyright (c) 2011 - 2021 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/SFBPopovers
// MIT license
//

import Cocoa
import SFBPopovers

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

	@IBOutlet var window: NSWindow!

	@IBOutlet var positionPopup: NSPopUpButton!
	@IBOutlet var borderColorWell: NSColorWell!
	@IBOutlet var backgroundColorWell: NSColorWell!
	@IBOutlet var viewMarginSlider: NSSlider!
	@IBOutlet var viewMarginTextField: NSTextField!
	@IBOutlet var borderWidthSlider: NSSlider!
	@IBOutlet var borderWidthTextField: NSTextField!
	@IBOutlet var cornerRadiusSlider: NSSlider!
	@IBOutlet var cornerRadiusTextField: NSTextField!
	@IBOutlet var hasArrowCheckbox: NSButton!
	@IBOutlet var drawRoundCornerBesideArrowCheckbox: NSButton!
//	@IBOutlet var movableCheckbox: NSButton!
//	@IBOutlet var resizableCheckbox: NSButton!
	@IBOutlet var arrowWidthSlider: NSSlider!
	@IBOutlet var arrowWidthTextField: NSTextField!
	@IBOutlet var arrowHeightSlider: NSSlider!
	@IBOutlet var arrowHeightTextField: NSTextField!
	@IBOutlet var distanceSlider: NSSlider!
	@IBOutlet var distanceTextField: NSTextField!
	@IBOutlet var toggleButton: NSButton!

	@IBOutlet weak var popoverContentView: NSView!

	var popover: SFBPopover!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		NSColorPanel.shared.showsAlpha = true

		popover = SFBPopover(contentView: popoverContentView)

		// Update the UI with the popover's state
		positionPopup.selectItem(at: Int(popover.position.rawValue))
		borderColorWell.color = popover.borderColor
		backgroundColorWell.color = popover.backgroundColor
		viewMarginSlider.floatValue = Float(popover.viewMargin)
		viewMarginTextField.floatValue = Float(popover.viewMargin)
		borderWidthSlider.floatValue = Float(popover.borderWidth)
		borderWidthTextField.floatValue = Float(popover.borderWidth)
		cornerRadiusSlider.floatValue = Float(popover.cornerRadius)
		cornerRadiusTextField.floatValue = Float(popover.cornerRadius)
		hasArrowCheckbox.state = popover.drawsArrow ? .on : .off
		drawRoundCornerBesideArrowCheckbox.state = popover.drawRoundCornerBesideArrow ? .on : .off
//		movableCheckbox.state = popover.isMovable ? .on : .off
//		resizableCheckbox.state = popover.isResizable ? .on : .off
		arrowWidthSlider.floatValue = Float(popover.arrowWidth)
		arrowWidthTextField.floatValue = Float(popover.arrowWidth)
		arrowHeightSlider.floatValue = Float(popover.arrowHeight)
		arrowHeightTextField.floatValue = Float(popover.arrowHeight)
		distanceSlider.floatValue = Float(popover.distance)
		distanceTextField.floatValue = Float(popover.distance)

		window.center()
		window.makeKeyAndOrderFront(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	// MARK: -

	@IBAction func changePosition(_ sender: AnyObject?) {
		guard let popUpButton = sender as? NSPopUpButton, popUpButton.indexOfSelectedItem != -1 else {
			return
		}

		let selectedIndex = popUpButton.indexOfSelectedItem
		if selectedIndex == 12 {
			var loc = toggleButton.frame.origin
			loc.x += toggleButton.frame.size.width / 2
			loc.y += toggleButton.frame.size.height / 2
			popover.position = popover.bestPosition(in: window, at: loc)
		}
		else {
			if let position = SFBPopoverPosition(rawValue: UInt(selectedIndex)) {
				popover.position = position
			}
		}
	}

	@IBAction func changeBorderColor(_ sender: AnyObject?) {
		guard let colorWell = sender as? NSColorWell else {
			return
		}
		popover.borderColor = colorWell.color
	}

	@IBAction func changeBackgroundColor(_ sender: AnyObject?) {
		guard let colorWell = sender as? NSColorWell else {
			return
		}
		popover.backgroundColor = colorWell.color
	}

	@IBAction func changeViewMargin(_ sender: AnyObject?) {
		guard let control = sender as? NSControl else {
			return
		}
		let viewMargin = floorf(control.floatValue)
		viewMarginSlider.floatValue = viewMargin
		viewMarginTextField.floatValue = viewMargin
		popover.viewMargin = CGFloat(viewMargin)
	}

	@IBAction func changeBorderWidth(_ sender: AnyObject?) {
		guard let control = sender as? NSControl else {
			return
		}
		let borderWidth = floorf(control.floatValue)
		borderWidthSlider.floatValue = borderWidth
		borderWidthTextField.floatValue = borderWidth
		popover.borderWidth = CGFloat(borderWidth)
	}

	@IBAction func changeCornerRadius(_ sender: AnyObject?) {
		guard let control = sender as? NSControl else {
			return
		}
		let cornerRadius = floorf(control.floatValue)
		cornerRadiusSlider.floatValue = cornerRadius
		cornerRadiusTextField.floatValue = cornerRadius
		popover.cornerRadius = CGFloat(cornerRadius)
	}

	@IBAction func changeHasArrow(_ sender: AnyObject?) {
		guard let button = sender as? NSButton else {
			return
		}
		popover.drawsArrow = button.state == .on
	}

	@IBAction func changeDrawRoundCornerBesideArrow(_ sender: AnyObject?) {
		guard let button = sender as? NSButton else {
			return
		}
		popover.drawRoundCornerBesideArrow = button.state == .on
	}

	@IBAction func changeMovable(_ sender: AnyObject?) {
		guard let button = sender as? NSButton else {
			return
		}
		popover.isMovable = button.state == .on
	}

	@IBAction func changeResizable(_ sender: AnyObject?) {
		guard let button = sender as? NSButton else {
			return
		}
		popover.isResizable = button.state == .on
	}

	@IBAction func changeArrowWidth(_ sender: AnyObject?) {
		guard let control = sender as? NSControl else {
			return
		}
		let arrowWidth = floorf(control.floatValue)
		arrowWidthSlider.floatValue = arrowWidth
		arrowWidthTextField.floatValue = arrowWidth
		popover.arrowWidth = CGFloat(arrowWidth)
	}

	@IBAction func changeArrowHeight(_ sender: AnyObject?) {
		guard let control = sender as? NSControl else {
			return
		}
		let arrowHeight = floorf(control.floatValue)
		arrowHeightSlider.floatValue = arrowHeight
		arrowHeightTextField.floatValue = arrowHeight
		popover.arrowHeight = CGFloat(arrowHeight)
	}

	@IBAction func changeDistance(_ sender: AnyObject?) {
		guard let control = sender as? NSControl else {
			return
		}
		let distance = floorf(control.floatValue)
		distanceSlider.floatValue = distance
		distanceTextField.floatValue = distance
		popover.distance = CGFloat(distance)
	}


	@IBAction func togglePopover(_ sender: AnyObject?) {
		if popover.isVisible {
			popover.close(sender)
		}
		else {
			var attachmentPoint = toggleButton.frame.origin
			attachmentPoint.x += toggleButton.frame.size.width / 2
			attachmentPoint.y += toggleButton.frame.size.height / 2
			popover.display(in: window, at: attachmentPoint)
		}
	}

	
	func windowDidResize(_ notification: Notification) {
		if let isVisible = popover?.isVisible, isVisible {
			var attachmentPoint = toggleButton.frame.origin
			attachmentPoint.x += toggleButton.frame.size.width / 2
			attachmentPoint.y += toggleButton.frame.size.height / 2
			popover.move(to: attachmentPoint)
		}
	}

}

