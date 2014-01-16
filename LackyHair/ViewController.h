//
//  ViewController.h
//  LackyHair
//
//  Created by Yamamoto Jumpei on 2014/01/12.
//  Copyright (c) 2014年 Yamamoto Jumpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
-(IBAction)loadImage:(id)sender;
- (IBAction)loadPhotoLibrary:(id)sender;

@end
