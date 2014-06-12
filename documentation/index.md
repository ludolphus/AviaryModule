# aviary-iphone Module

## Description

The Aviary module provides an interface to the [Aviary photo editor](http://www.aviary.com/).

You need an api key and secret before you can use this module. To create an api key and secret go here [Aviary Developer](http://developers.aviary.com/apps) and create one (sign up first if you do not have an account yet)

## Accessing the aviary-iphone Module

* Make sure you add in the *AviarySDKResources.bundle* (located in the module folder), to your project files or it won't work! 
  * Add it in **/platform/iphone/** and it will compile in during the build. Clean the project just in case.

To access this module from JavaScript, you would do the following:

	var aviary-iphone = require("com.ghkim.aviary");

The aviary-iphone variable is a reference to the Module object.	

## Reference

- setStatusBarStyle(statusbarStyle)
- newImageEditor({apikey:'yourAviaryAPIkey', secret:'yourAviarySecret', image: imageBlob, tools: toolsArray})
- displayEditor()

## Usage

var tools = ['kAFEnhance', 'kAFEffects', 'kAFFrames', 'kAFCrop', 'kAFSplash', 'kAFFocus', 'kAFOrientation', 'kAFAdjustments', 'kAFSharpness', 'kAFStickers', 'kAFDraw', 'kAFMeme', 'kAFText', 'kAFRedeye', 'kAFWhiten', 'kAFBlemish'];
aviary.addEventListener('avEditorCancel', function(e) {alert('user cancelled photo editor')});
aviary.addEventListener('avEditorFinished', function(e) {alert('do something with the image available in variable e')});
aviary.setStatusBarStyle(Ti.UI.iPhone.StatusBar.LIGHT_CONTENT);
// image is your image to be edited (use Ti.Media.openPhotoGallery or Ti.UI.createImageView for example to get an image)
aviary.newImageEditor({apikey:'yourAviaryAPIkey', secret: 'yourAviarySecret', image: imageBlob, tools: tools});
aviary.displayEditor();

## Authors

4.1.0 by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)
4.0.1 by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)
3.3.11 by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)
3.3.7 by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)
1.1 by Alex Shive [alexshive](http://alexshive.com)
1.0 by KimGeunHyeong [ghkim](https://github.com/ghkim)

## License

TODO: Enter your license/legal information here.
