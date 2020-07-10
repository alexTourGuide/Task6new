//
//  InfoViewController.m
//  Task06New
//
//  Created by Alexander Porshnev on 7/10/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "InfoViewController.h"
#import "FiguresView.h"
#import "UIView+HexColors.h"
#import "Constants.h"

@interface InfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceVersionLabel;

@property (weak, nonatomic) IBOutlet FiguresView *circleView;
@property (weak, nonatomic) IBOutlet FiguresView *rectangleView;
@property (weak, nonatomic) IBOutlet FiguresView *triangleView;

@property (weak, nonatomic) IBOutlet UIButton *openGitButton;
@property (weak, nonatomic) IBOutlet UIButton *goToStartButton;

@end

@implementation InfoViewController

#pragma mark - Life cycle's methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPhoneInfo];
    [self setupFigures];
    [self setupButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setupNavigationBar];
    [self startFiguresAnimation];
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self subscribeOnBackForegroundNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopFiguresAnimation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self unsubcribeOnBackForegroundNotifications];
}

#pragma mark - Setup Views

- (void)setupFigures {
    self.circleView.figureType = CircleView;
    self.circleView.backgroundColor = [UIColor clearColor];
    self.circleView.figureColor = [UIColor requiredRedColor];
    
    self.rectangleView.figureType = RectangleView;
    self.rectangleView.backgroundColor = [UIColor clearColor];
    self.rectangleView.figureColor = [UIColor requiredBlueColor];
    
    self.triangleView.figureType = TriangleView;
    self.triangleView.backgroundColor = [UIColor clearColor];
    self.triangleView.figureColor = [UIColor requiredGreenColor];
}

- (void)setupButtons {
    self.openGitButton.backgroundColor = [UIColor requiredYellowColor];
    self.openGitButton.titleLabel.textColor = [UIColor requiredBlackColor];
    self.openGitButton.layer.cornerRadius = BUTTON_HEIGHT / 2;
    self.openGitButton.clipsToBounds = YES;
    [self.openGitButton addTarget:self action:@selector(openGitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.goToStartButton.backgroundColor = [UIColor requiredRedColor];
    self.goToStartButton.titleLabel.textColor = [UIColor requiredWhiteColor];
    self.goToStartButton.layer.cornerRadius = BUTTON_HEIGHT / 2;
    self.goToStartButton.clipsToBounds = YES;
    [self.goToStartButton addTarget:self action:@selector(goToStartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupPhoneInfo {
    self.deviceNameLabel.text = [UIDevice currentDevice].name;
    self.deviceNameLabel.numberOfLines = 0;
    
    self.deviceTypeLabel.text = [UIDevice currentDevice].model;
    
    self.deviceVersionLabel.text = [NSString stringWithFormat:@"%@ %@", UIDevice.currentDevice.systemName, UIDevice.currentDevice.systemVersion];
}

- (void)setupNavigationBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if (@available(iOS 13, *)) {
        [self.navigationController navigationBar].standardAppearance = [UINavigationBarAppearance new];
        [[self.navigationController navigationBar].standardAppearance configureWithDefaultBackground];
        
        [self.navigationController navigationBar].standardAppearance.backgroundColor = [UIColor requiredYellowColor];
        [self.navigationController navigationBar].standardAppearance.titleTextAttributes = @{
            NSForegroundColorAttributeName: [UIColor requiredBlackColor],
            NSFontAttributeName:[UIFont systemFontOfSize:18.0 weight:UIFontWeightSemibold]
        };
    }
    else {
        [self.navigationController navigationBar].barTintColor = [UIColor requiredYellowColor];
        [self.navigationController navigationBar].titleTextAttributes = @{
            NSForegroundColorAttributeName: [UIColor requiredBlackColor],
            NSFontAttributeName:[UIFont systemFontOfSize:18.0 weight:UIFontWeightSemibold]
        };
    }
    self.navigationController.topViewController.title = @"RSSchool Task 6";
}

#pragma mark - Handlers

- (IBAction)openGitButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/alexTourGuide/rsschool-cv/blob/master/README.md"] options:@{} completionHandler:nil];
}

- (IBAction)goToStartButtonPressed:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Helpers

- (void)startFiguresAnimation {
    NSLog(@"Start Animation");
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
    [self.circleView startAnimation];
    [self.rectangleView startAnimation];
    [self.triangleView startAnimation];
}

- (void)stopFiguresAnimation {
    NSLog(@"Stop Animation");
    [self.circleView.layer removeAllAnimations];
    [self.rectangleView.layer removeAllAnimations];
    [self.triangleView.layer removeAllAnimations];
}

- (void)restartAnimation {
    NSLog(@"Restart Animation");
    [self stopFiguresAnimation];
    [self startFiguresAnimation];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
}

#pragma mark - Notifications methods

- (void)subscribeOnBackForegroundNotifications {
    NSLog(@"subscribeOnBackForegroundNotifications");
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(stopFiguresAnimation) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(startFiguresAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(restartAnimation) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)unsubcribeOnBackForegroundNotifications {
    NSLog(@"unsubscribeOnBackForegroundNotifications");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
