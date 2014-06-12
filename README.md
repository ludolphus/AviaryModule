#Aviary iphone module for Titanium Mobile

##Requirements

- Titanium Mobile SDK 3.2.0GA.
- iOS SDK 6.0+
- AviarySDK Version 4.1.0

##Installation for iOS
- Download AviaryModule project
- Build your module from Terminal via "./build.py"
- Extract and copy the module in your project under /modules/iphone/ or just copy the zip file and have it auto-uncompress 
- Add the following in your tiapp.xml like below:

```
<modules>
   <module platform="iphone" version="4.1.0">com.ghkim.aviary</module>
</modules>
```

* Make sure you add in the *AviarySDKResources.bundle* (located in the module folder), to your project files or it won't work! 
  * Add it in **/platform/iphone/** and it will compile in during the build. Clean the project just in case.

Author
========

&hearts; Big thanks to KimGeunHyeong for this module! 

(dev.lasneo@gmail.com) : [tumblr](http://www.lasneo.tumblr.com/)

Aviary SDK 3.3.7 update by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)

Aviary SDK 3.3.11 update by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)

Aviary SDK 4.0.1 update by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)

Aviary SDK 4.1.0 update by Steven van Loef [Twitter](https://twitter.com/ludolphus) [App.net](https://app.net/ludolphus)


 License
========
The MIT License (MIT)
Copyright © 2012 <KimGeunHyeong(dev.lasneo@gmail.com)>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
