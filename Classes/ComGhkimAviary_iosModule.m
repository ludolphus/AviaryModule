/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComGhkimAviary_iosModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"

@implementation ComGhkimAviary_iosModule

#pragma mark Internal
// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"8bd717f2-1ed4-4875-a9e4-4f858766a03a";
}
// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.ghkim.aviary_ios";
}
#pragma mark Lifecycle
-(void)startup
{
	[super startup];
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	[super shutdown:sender];
}
#pragma mark Internal Memory Management
-(void)dealloc
{
    NSLog(@"DEALLOC TIME",self);
	[super dealloc];
}
-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
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
        [tools addObject:realKey];
    }
    return tools;
}

-(void)newEditorController:(UIImage *)source 
{
    
    editorController = [[AFPhotoEditorController alloc] initWithImage:source];
    [editorController setDelegate:self];
    
    [[TiApp app] showModalController: editorController animated: YES];
}


-(void)newEditorController:(UIImage *)source withTools:(NSArray *)toolKey
{
    
    NSArray *tools = [self convertToRealToolsKey:toolKey];
    NSDictionary *options = [NSDictionary 
                             dictionaryWithObject:tools 
                             forKey:kAFPhotoEditorControllerToolsKey];
    editorController = [[AFPhotoEditorController alloc] 
                        initWithImage:source 
                        options:options];
    [editorController setDelegate:self];
    
}



#pragma mark Public APIs

// Init and Allocation editcontroller.
// params example1 = [targetImage](Blob), example2 = [targetImage(Blob), tools(Array)]
-(void)newImageEditor:(id)params
{
    UIImage *source = [self convertToUIImage:[params objectAtIndex:0]];
    if ([params count] == 1){
        [self newEditorController:source];
    }else if ([params count] == 2){
        NSArray *tools = [NSArray arrayWithArray:(NSArray *)[params objectAtIndex:1]];
        [self newEditorController:source withTools:tools];
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
        context = [session createContext];
    }else if ([params count] == 2){
        context = [session createContextWithSize:[self convertToCGSize:(NSDictionary *)[params objectAtIndex:1]]];
    }
    
    [context renderInputImage:source completion:^(UIImage *result) {
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
    if (editorController){
        ENSURE_UI_THREAD(modalEditorController, nil);
    }
}

-(void)setUsingIOS6SDK:(id)arg
{
	if ([TiUtils intValue:arg]) {
		[AFPhotoEditorCustomization setUsingIOS6SDK:YES];
	} else {
		[AFPhotoEditorCustomization setUsingIOS6SDK:NO];
	}
}

-(void)setStatusBarBackgroundColor:(id)color
{
	UIColor *backgroundColor = [[TiUtils colorValue:color] _color];
	[AFPhotoEditorCustomization setStatusBarBackgroundColor:backgroundColor];
}

-(void) setStatusBarBackgroundColorWhite:(id)foo
{
	[AFPhotoEditorCustomization setStatusBarBackgroundColor:[UIColor whiteColor]];
}

-(void) setStatusBarBackgroundColorBlack:(id)foo
{
	[AFPhotoEditorCustomization setStatusBarBackgroundColor:[UIColor blackColor]];
}

-(void)setStatusBarStyle:(id)style
{
	[AFPhotoEditorCustomization setStatusBarStyle:[TiUtils intValue:style]];
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
