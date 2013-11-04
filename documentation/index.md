# aviary-iphone Module

## Description

The Aviary module provides an interface to the [Aviary photo editor](http://www.aviary.com/).

## Accessing the aviary-iphone Module

To access this module from JavaScript, you would do the following:

	var aviary-iphone = require("com.ghkim.aviary_ios");

The aviary-iphone variable is a reference to the Module object.	

## Reference

- setUsingIOS6SDK(boolean)
- setStatusBarBackgroundColor(color)
- setStatusBarStyle(statusbarStyle)
- setStatusBarBackgroundColorWhite()
- setStatusBarBackgroundColorBlack()
- newImageEditor(images, tools)
- displayEditor()

## Usage

var tools = ['kAFEnhance', 'kAFEffects', 'kAFFrames', 'kAFCrop', 'kAFSplash', 'kAFFocus', 'kAFOrientation', 'kAFAdjustments', 'kAFSharpness', 'kAFStickers', 'kAFDraw', 'kAFMeme', 'kAFText', 'kAFRedeye', 'kAFWhiten', 'kAFBlemish'];
aviary.addEventListener('avEditorCancel', function(e) {alert('user cancelled photo editor')});
aviary.addEventListener('avEditorFinished', function(e) {alert('do something with the image available in variable e')});
aviary.setStatusBarBackgroundColor('#0000ff');
aviary.setUsingIOS6SDK(0);
aviary.setStatusBarStyle(Ti.UI.iPhone.StatusBar.LIGHT_CONTENT);
// image is your image to be edited (use Ti.Media.openPhotoGallery or Ti.UI.createImageView for example to get an image)
aviary.newImageEditor(image, tools);
aviary.displayEditor();

## Author

3.3.7 by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)
1.1 by Alex Shive [alexshive](http://alexshive.com)
1.0 by KimGeunHyeong [ghkim](https://github.com/ghkim)

## License

TODO: Enter your license/legal information here.
