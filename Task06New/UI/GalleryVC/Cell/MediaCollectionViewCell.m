//
//  MediaCollectionViewCell.m
//  Task06New
//
//  Created by Alexander Porshnev on 7/10/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "MediaCollectionViewCell.h"
#import <Photos/Photos.h>

@interface MediaCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MediaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithItem:(PHAsset *)mediaItem {
    
    switch (mediaItem.mediaType) {
        case PHAssetMediaTypeImage:
            [self getImageFromAssetMedia:mediaItem];
            break;
        case PHAssetMediaTypeVideo:
             [self getImageFromAssetMedia:mediaItem];
            break;
        case PHAssetMediaTypeAudio:
            self.imageView.image = [UIImage imageNamed:@"audio"];
            break;
        default:
            self.imageView.image = [UIImage imageNamed:@"other"];
            break;
    }
}

-(void)getImageFromAssetMedia:(PHAsset *)mediaItem {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    NSInteger retinaMultiplier = [UIScreen mainScreen].scale;
    CGSize retinaSquare = CGSizeMake(self.imageView.bounds.size.width * retinaMultiplier, self.imageView.bounds.size.height * retinaMultiplier);
    
    [[PHImageManager defaultManager] requestImageForAsset:(PHAsset *)mediaItem
                                               targetSize:retinaSquare
                                              contentMode:PHImageContentModeAspectFill
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
        self.imageView.image =[UIImage imageWithCGImage:result.CGImage scale:retinaMultiplier orientation:result.imageOrientation];
    }];
}

@end
