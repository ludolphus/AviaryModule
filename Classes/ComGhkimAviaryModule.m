/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComGhkimAviaryModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"

@implementation ComGhkimAviaryModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"8bd717f2-1ed4-4875-a9e4-4f858766a03a";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.ghkim.aviary";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Private APIs
-(void)modalEditorController:(id)param
{
    [[TiApp app] showModalController: editorController animated: YES];
}

// rgba = [red,green,blue,alpha]
-(UIColor *)convertToUIColor:(id)rgba
{
    ENSURE_ARG_COUNT(rgba, 4);
    CGFloat red = [TiUtils floatValue:[rgba objectAtIndex:0]];
    CGFloat green = [TiUtils floatValue:[rgba objectAtIndex:1]];
    CGFloat blue = [TiUtils floatValue:[rgba objectAtIndex:2]];
    CGFloat alpha = [TiUtils floatValue:[rgba objectAtIndex:3]];
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

-(UIImage *)convertToUIImage:(id)param
{
    UIImage *source = nil;
    if ([param isKindOfClass:[TiBlob class]]){
        source = [param image];
    }else if ([param isKindOfClass:[UIImage class]]){
        source = param;
    }
    return source;
}

-(CGSize)convertToCGSize:(NSDictionary *)param
{
    CGFloat width = [TiUtils floatValue:[param objectForKey:@"width"]];
    CGFloat height = [TiUtils floatValue:[param objectForKey:@"height"]];
    CGSize size = CGSizeMake(width, height);
    return size;
}

-(NSDictionary *)convertResultDic:(UIImage *)result
{
    TiBlob *blob = [[[TiBlob alloc]initWithImage:result]autorelease];
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:blob,@"image",nil];
    return obj;
}

-(NSMutableArray *)convertToRealToolsKey:(NSArray *)toolsKey
{
    NSMutableArray *tools = [[[NSMutableArray alloc]initWithCapacity:[toolsKey count]]autorelease];
    for (NSString *key in toolsKey){
        NSString *lowcase = [key lowercaseString];
        NSString *realKey = [lowcase substringFromIndex:3];
    	if ([realKey isEqualToString: @"adjustments"]) {
    		realKey = @"adjust";
    	}
        [tools addObject:realKey];
    }
    return tools;
}

-(void)newEditorController:(UIImage *)source 
{
    
    editorController = [[AFPhotoEditorController alloc] initWithImage:source];
    [editorController setDelegate:self];
    
//    [[TiApp app] showModalController: editorController animated: YES];
}


-(void)newEditorController:(UIImage *)source withTools:(NSArray *)toolKey
{

    NSArray *tools = [self convertToRealToolsKey:toolKey];
    [AFPhotoEditorCustomization setToolOrder:tools];
	[self newEditorController:source];
}

-(void)newEditorController:(UIImage *)source withTools:(NSArray *)toolKey withCrops:(NSArray *)crops
{
	
    NSArray *tools = [self convertToRealToolsKey:toolKey];
    [AFPhotoEditorCustomization setToolOrder:tools];

	NSMutableArray *croptools = [[[NSMutableArray alloc]initWithCapacity:[crops count] / 3]autorelease];
	for (int i = 0; i < [crops count]; i += 3) {
		[croptools addObject: @{kAFCropPresetName: crops[i],kAFCropPresetHeight : crops[i + 1], kAFCropPresetWidth: crops[i + 2]}];
	}
	[AFPhotoEditorCustomization setCropToolOriginalEnabled:YES];
	[AFPhotoEditorCustomization setCropToolCustomEnabled:YES];
	[AFPhotoEditorCustomization setCropToolInvertEnabled: YES];
	[AFPhotoEditorCustomization setCropToolPresets:croptools];
	
	[self newEditorController:source];
}

#pragma Public APIs

// Set the API key and secret
-(void)setAPIkey:(id)params
{
	ENSURE_UI_THREAD_1_ARG(params);
	ENSURE_SINGLE_ARG(params, NSDictionary);

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[AFPhotoEditorController setAPIKey:[params objectForKey:@"apikey"] secret:[params objectForKey:@"secret"]];
	});
}

// Init and Allocation editcontroller.
// params example1 = [targetImage](Blob), example2 = [targetImage(Blob), tools(Array)]
-(void)newImageEditor:(id)params
{
    ENSURE_UI_THREAD_1_ARG(params);
    ENSURE_SINGLE_ARG(params, NSDictionary);

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        [AFPhotoEditorController setAPIKey:[params objectForKey:@"apikey"] secret:[params objectForKey:@"secret"]];
    });

    // Set Supported Orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray * supportedOrientations = @[@(UIInterfaceOrientationPortrait), @(UIInterfaceOrientationPortraitUpsideDown), @(UIInterfaceOrientationLandscapeLeft), @(UIInterfaceOrientationLandscapeRight)];
        [AFPhotoEditorCustomization setSupportedIpadOrientations:supportedOrientations];
    }

    UIImage *source = [self convertToUIImage:[params objectForKey:@"image"]];
	NSArray *tools = [NSArray arrayWithArray:(NSArray *)[params objectForKey:@"tools"]];
	NSArray *crops = [NSArray arrayWithArray:(NSArray *)[params objectForKey:@"crops"]];

	if ([crops count] != 0) {
		[self newEditorController:source withTools:tools withCrops:crops];
	} else {
		NSArray *crops = @[@"Square", @1.0f, @1.0f, @"3:4", @3.0f, @4.0f, @"4:6", @4.0f, @6.0f, @"5:7", @5.0f, @7.0f, @"8:10", @8.0f, @10.0f, @"9:16", @9.0f, @16.0f];
		[self newEditorController:source withTools:tools withCrops:crops];
	}
}

// Image Processing to High-Resolution.
// params example1 = [targetImage](Blob), example2 = [targetImage(Blob), context size(Hash)]
-(void)newImageResolutionEditor:(id)params
{
    UIImage *source = [self convertToUIImage:[params objectAtIndex:0]];
    [self newEditorController:source];
    __block AFPhotoEditorSession *session = [editorController session];
      
    AFPhotoEditorContext *context;
    if ([params count] == 1){
        context = [session createContextWithImage:source];
    }else if ([params count] == 2){
        context = [session createContextWithImage:source maxSize:[self convertToCGSize:(NSDictionary *)[params objectAtIndex:1]]];
    }

    [context render: ^(UIImage *result) {
        // `result` will be nil if the session is canceled, or non-nil if the session was closed successfully and rendering completed
        [self fireEvent:@"avResolutionFinished" withObject:[self convertResultDic:result]];
        [editorController dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(id)getAviarySDKVersion:(id)param
{
    return [AFPhotoEditorController versionString];
}

// Public method to editcontroller modal.
-(void)displayEditor:(id)params
{
//    ENSURE_UI_THREAD_1_ARG(params);
//    ENSURE_SINGLE_ARG(params, NSDictionary);

    if (editorController){
        ENSURE_UI_THREAD(modalEditorController, nil);
    }
}

-(void)setStatusBarStyle:(id)style
{
	[AFPhotoEditorCustomization setStatusBarStyle:[TiUtils intValue:style]];
}

-(void)setCancelApplyButtons:(id)params
{
	NSArray *cancel = @[kAFLeftNavigationTitlePresetCancel, kAFLeftNavigationTitlePresetBack, kAFLeftNavigationTitlePresetExit];
	NSArray *apply = @[kAFRightNavigationTitlePresetDone, kAFRightNavigationTitlePresetNext, kAFRightNavigationTitlePresetSave,kAFRightNavigationTitlePresetSend];
	
	[AFPhotoEditorCustomization setLeftNavigationBarButtonTitle:cancel[[[params objectForKey:@"cancel"] integerValue]]];
	[AFPhotoEditorCustomization setRightNavigationBarButtonTitle:apply[[[params objectForKey:@"save"] integerValue]]];
}

#pragma mark Delegates

#define view_parentViewController(_view_) (([_view_ parentViewController] != nil || ![_view_ respondsToSelector:@selector(presentingViewController)]) ? [_view_ parentViewController] : [_view_ presentingViewController])


// This is called when editcontroller done. 
// Post edited image by notification.
-(void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    [self fireEvent:@"avEditorFinished" withObject:[self convertResultDic:image]];
    
    if([view_parentViewController(editor) respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        [editor.presentingViewController dismissViewControllerAnimated:(YES) completion:nil];
    else if([view_parentViewController(editor) respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
        [view_parentViewController(editor) dismissModalViewControllerAnimated:YES];
    else
        NSLog(@"Oooops, what system is this ?!!! - should never see this !");
     
    [editor release];
}

// This is called when editcontroller cancel.
-(void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    
    [self fireEvent:@"avEditorCancel" withObject:nil];
    
    if([view_parentViewController(editor) respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        [editor.presentingViewController dismissViewControllerAnimated:(YES) completion:nil];
    else if([view_parentViewController(editor) respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
        [view_parentViewController(editor) dismissModalViewControllerAnimated:YES];
    else
        NSLog(@"Oooops, what system is this ?!!! - should never see this !");
    
    [editor release];
}

@end
