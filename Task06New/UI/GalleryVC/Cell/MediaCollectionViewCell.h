//
//  MediaCollectionViewCell.h
//  Task06New
//
//  Created by Alexander Porshnev on 7/10/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;

NS_ASSUME_NONNULL_BEGIN

@interface MediaCollectionViewCell : UICollectionViewCell

- (void)configureWithItem:(PHAsset *)item;

@end

NS_ASSUME_NONNULL_END
