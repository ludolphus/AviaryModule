var win = Ti.UI.currentWindow;
var aviary = require('com.ghkim.aviary_ios');

// imageEditor Finished
aviary.addEventListener('avEditorFinished', function(ev){
	var iv = Titanium.UI.createImageView({image:ev.image, width: 200, height:100});
	win.add(iv);
});

// imageEditor Cancel
aviary.addEventListener('avEditorCancel', function(ev){
	alert('cancel');
});

// imageResolution Finished
aviary.addEventListener('avResolutionFinished', function(ev){
	var iv = Titanium.UI.createImageView({image:ev.image, width: 200, height:100, top:0});
	win.add(iv);
})

var imageEditorBt1 = Ti.UI.createButton({
	width: 150,
	height: 30,
	title: 'Select Image',
	left: 10,
	bottom: 40
})
imageEditorBt1.addEventListener('click',function(){
	var image = Titanium.UI.createImageView({image:'test.png'});
	var img = image.toImage();
	aviary.newImageEditor(img);
	aviary.displayEditor();
});
win.add(imageEditorBt1);

