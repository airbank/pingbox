# Pingbox

[![Version](https://img.shields.io/cocoapods/v/pingbox.svg?style=flat)](http://cocoapods.org/pods/pingbox)
[![License](https://img.shields.io/cocoapods/l/pingbox.svg?style=flat)](http://cocoapods.org/pods/pingbox)
[![Platform](https://img.shields.io/cocoapods/p/pingbox.svg?style=flat)](http://cocoapods.org/pods/pingbox)

Pingbox is an easy to use in-app messaging user interface component for iOS written in Objective-C.

This is how it looks in action:

![alt tag](https://raw.githubusercontent.com/airbank/pingbox/master/docs/animation.gif)

## Installation

Pingbox is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "pingbox"
```

## Usage

Using pingbox is super simple - you just need to create a `LMNotification` object and post it to `LMNotificationCenter`, like so:

```objc
LMNotification *notification = [[LMNotification alloc] init];
notification.title = @"Great news!";
notification.message = @"You just got a great benefit from us.";
notification.approveButtonTitle = @"Learn more";
notification.cancelButtonTitle = @"Cancel";
notification.icon = [UIImage imageNamed:@"icon.png"];
notification.userInfo = @{ // any object info that identifies the notification
    @"id" : @"notification_12"
};

[[LMNotificationCenter defaultCenter] postNotification:notification];
```

In order to get callbacks based on taps on notification buttons, you need to set the delegate to `LMNotificationCenter` default instance. In order to handle notifications globally, you need to have a single delegate instance - a good place to handle delegate callbacks is in the main application delegate instance. This is also the place where you receive the push notification callbacks, that usually trigger in-app message display.

```objc
[LMNotificationCenter defaultCenter].delegage = self;
```

The `LMNotificationCenterDelegate` implements following callbacks:

```objc
- (void) didOpenNotification:(LMNotification *)notification
{
}

- (void) didCloseNotification:(LMNotification *)notification
{   
}
```

You can manually remove notifications that are no longer valid:

```objc
[[LMNotificationCenter defaultCenter] removeNotification:notification];
```

Or you can remove all notifications:

```objc
[[LMNotificationCenter defaultCenter] removeAllNotifications];
```

It is possible to customize the appearance of the dialog using attributes in `LMConfiguration` instance. Following attributes are available for customization:

```objc
LMConfiguration *configuration = [[LMNotificationCenter defaultCenter].configuration;

// Margin around the message box
configuration.margin = LMNOTIFICATION_PADDING; // 10.0

// Inner padding of the message box
configuration.innerPadding = LMNOTIFICATION_INNER_PADDING; // 15.0

// Total notification height
configuration.height = LMNOTIFICATION_HEIGHT; // 155.0

// Text row height
configuration.rowHeight = LMNOTIFICATION_ROW; // 20.0

// Button height
configuration.buttonHeight = LMNOTIFICATION_BUTTON_HEIGHT; // 35.0

// Gap size between buttons
configuration.buttonGap = LMNOTIFICATION_BUTTON_GAP; // 10.0

// Message box corner radius
configuration.cornerRadius = LMNOTIFICATION_CORNER_RADIUS; // 8.0

// Button corner radius
configuration.buttonCornerRadius = LMNOTIFICATION_BUTTON_CORNER_RADIUS; // 4.0

// Notification background color
configuration.backgroundColor = [UIColor whiteColor];

// Background overlay color
configuration.overlayColor = [UIColor colorWithWhite:0.0 alpha:0.5];

// Text alignment
configuration.textAlignment = NSTextAlignmentCenter;

// Title text color
configuration.headingColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];

// Message text color
configuration.messageColor = [UIColor colorWithWhite:0.5 alpha:1.0];

// Icon background color
configuration.iconBackgroundColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];

// Cancel button title color
configuration.cancelButtonTitleColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];

// Cancel button background color
configuration.cancelButtonBackgroundColor = [UIColor whiteColor];

// Cancel button border color
configuration.cancelButtonBorderColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];

// Approve button title color
configuration.approveButtonTitleColor = [UIColor whiteColor];

// Approve button background color
configuration.approveButtonBackgroundColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];

// Approve button border color
configuration.approveButtonBorderColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
```

## Example project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Petr Dvorak, petr@lime-company.eu

## License

Pingbox is available under the MIT license. See the LICENSE file for more info.
