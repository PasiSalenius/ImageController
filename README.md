# ImageController

This controller demonstrates a modernized Swift version of Peter Steinberger's "contentInset setting" method of centering an UIImageView inside a UIScrollView. It seemed difficult to find a fully working version so I decided to make my own.

It otherwise uses auto layout but directly sets the frame of the UIImageView, as using contraints there proved problematic. It should correctly handle changes to the controller's size, such as device rotation.

I'm using ImageController in my [Kartasto](https://freshbits.fi/apps/kartasto/) iOS map app for hiking and other outdoor activities. This controller is used as part of a paging controller to show a list of images attached to a map location.

<a href="https://apps.apple.com/us/app/kartasto/id1524211335" target="_blank"><img width="150" alt="Download on the App Store" src="https://developer.apple.com/assets/elements/badges/download-on-the-app-store.svg"/></a>

## References
* http://petersteinberger.com/blog/2013/how-to-center-uiscrollview/
* https://github.com/steipete/PSTCenteredScrollView/blob/master/PSTCenteredScrollView/PSTContentInsetCenteredScrollView.m#L13
