THSlackLogger
===

[![Build Status](https://travis-ci.org/hons82/THSlackLogger.png)](https://travis-ci.org/hons82/THSlackLogger)
[![Pod Version](http://img.shields.io/cocoapods/v/THSlackLogger.svg?style=flat)](http://cocoadocs.org/docsets/THSlackLogger/)
[![Pod Platform](http://img.shields.io/cocoapods/p/THSlackLogger.svg?style=flat)](http://cocoadocs.org/docsets/THSlackLogger/)
[![Pod License](http://img.shields.io/cocoapods/l/THSlackLogger.svg?style=flat)](http://opensource.org/licenses/MIT)
[![Coverage Status](https://coveralls.io/repos/hons82/THSlackLogger/badge.svg)](https://coveralls.io/r/hons82/THSlackLogger)

A Logger for [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) that writes to a custom Slack Channel

# Installation

### CocoaPods

Install with [CocoaPods](http://cocoapods.org) by adding the following to your Podfile:

####Objective-C

``` ruby
platform :ios, '7.0'
pod 'THSlackLogger', '~> 1.0.0'
```
####Swift

``` ruby
platform :ios, '8.0'
use_frameworks!
pod 'THSlackLogger', '~> 1.0.0'
```

**Note**: We follow http://semver.org for versioning the public API.

# Usage

This is a sample initialization taken from the ExampleProject.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    /*
     First method is to directly add the URL at first init
     */
    //[DDLog addLogger:[THSlackLogger initWithWebhookURL:[NSURL URLWithString:@"https://hooks.slack.com/services/xxx/xxx/xxx"]]];
    /*
     ...if not, then add a Slack.plist file to your main bundle including a key named "webHookUrl" with the URL as String value
     */
    [DDLog addLogger:[THSlackLogger sharedInstance]];
    return YES;
}
```

#Contributions

...are really welcome. If you have an idea just fork the library change it and if its useful for others and not affecting the functionality of the library for other users I'll insert it

# License

Source code of this project is available under the standard MIT license. Please see [the license file](LICENSE.md).