// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var win = Titanium.UI.createWindow({
    title:'Tab 1',
    backgroundColor:'#fff'
});

var stickerWindow = Titanium.UI.createWindow({
    title:'Main event',
    backgroundColor:'#fff',
    url: 'sticker.js'
});

win.open();

var button = Ti.UI.createButton({title: 'Click Me'});
win.add(button);

button.addEventListener('click',function() {
    Ti.UI.currentTab.open(stickerWindow);
});