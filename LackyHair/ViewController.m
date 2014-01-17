//
//  ViewController.m
//  LackyHair
//
//  Created by Yamamoto Jumpei on 2014/01/12.
//  Copyright (c) 2014年 Yamamoto Jumpei. All rights reserved.
//

#import "ViewController.h"
#import "HairView.h"
@interface ViewController ()

@end

@implementation ViewController{
    BOOL _mode;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIGestureRecognizer* gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:gesture];
    _mode = YES;
}

-(void)tap:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint loc =  [sender locationInView:self.imageView];
        CGRect frame = _mode ?CGRectMake(loc.x - 10, loc.y, 100, 100):CGRectMake(loc.x - 10, loc.y, 20, 20);
        HairView* hair = [[HairView alloc]initWithFrame:frame mode:_mode];
        [self.imageView addSubview:hair];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadImage:(id)sender
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
		// カメラかライブラリからの読込指定。カメラを指定。
		[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
		// トリミングなどを行うか否か
		[imagePickerController setAllowsEditing:YES];
		// Delegate
		[imagePickerController setDelegate:self];
		
		// アニメーションをしてカメラUIを起動
		[self presentViewController:imagePickerController animated:YES completion:nil];
	}
    else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
		[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
		[imagePickerController setAllowsEditing:YES];
		[imagePickerController setDelegate:self];
		
		[self presentViewController:imagePickerController animated:YES completion:nil];
	}
	else
    {
    }


}

- (IBAction)loadPhotoLibrary:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController setAllowsEditing:YES];
    [imagePickerController setDelegate:self];
    
    [self presentViewController:imagePickerController animated:YES completion:nil];

}

- (IBAction)modeDidChange:(UISwitch*)sender {
    _mode =  sender.on;
}
#pragma mark UINavigationControllerDelegate



#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    for (UIView* view in self.imageView.subviews) {
        [view removeFromSuperview];
    }
    
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
	// 編集画像
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *saveImage;

	if(editedImage)
	{
		saveImage = editedImage;
	}
	else
	{
		saveImage = originalImage;
	}
	
	// UIImageViewに画像を設定
	self.imageView.image = saveImage;
	
	if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
	{
		// カメラから呼ばれた場合は画像をフォトライブラリに保存してViewControllerを閉じる
		UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
	}
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
