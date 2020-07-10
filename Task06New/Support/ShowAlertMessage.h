//
//  ShowAlertMessage.h
//  Task06New
//
//  Created by Alexander Porshnev on 7/10/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

NS_ASSUME_NONNULL_BEGIN

@interface ShowAlertMessage : NSObject

- (void)showLibraryAccessAlert:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message;


@end

NS_ASSUME_NONNULL_END
