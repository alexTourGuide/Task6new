//
//  StartViewController.m
//  Task06New
//
//  Created by Alexander Porshnev on 7/9/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "StartViewController.h"
#import "UIView+HexColors.h"
#import "Constants.h"
#import "FiguresView.h"
#import "InfoViewController.h"

@interface StartViewController ()

@property (weak, nonatomic) IBOutlet UILabel *readyLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet FiguresView *circleView;
@property (weak, nonatomic) IBOutlet FiguresView *rectrangleView;
@property (weak, nonatomic) IBOutlet FiguresView *triangleView;

@end

@implementation StartViewController

#pragma mark - Life cycle's methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFigures];
    [self setupButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribeOnBackForegroundNotifications];
    [self.navigationController setNavigationBarHidden:YES];
    [self startFiguresAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopFiguresAnimation];
}

#pragma mark - Setup Views

- (void)setupFigures {
    self.circleView.figureType = CircleView;
    self.circleView.backgroundColor = [UIColor clearColor];
    self.circleView.figureColor = [UIColor requiredRedColor];
    
    self.rectrangleView.figureType = RectangleView;
    self.rectrangleView.backgroundColor = [UIColor clearColor];
    self.rectrangleView.figureColor = [UIColor requiredBlueColor];
    
    self.triangleView.figureType = TriangleView;
    self.triangleView.backgroundColor = [UIColor clearColor];
    self.triangleView.figureColor = [UIColor requiredGreenColor];
}

- (void)setupButton {
    self.startButton.backgroundColor = [UIColor requiredYellowColor];
    self.startButton.layer.cornerRadius = BUTTON_HEIGHT / 2;
    self.startButton.clipsToBounds = YES;
    [self.startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Handlers

- (void)startFiguresAnimation {
    [self.circleView startAnimation];
    [self.rectrangleView startAnimation];
    [self.triangleView startAnimation];
}

- (void)stopFiguresAnimation {
    [self.circleView.layer removeAllAnimations];
    [self.rectrangleView.layer removeAllAnimations];
    [self.triangleView.layer removeAllAnimations];
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    UITabBarController *tabBarCo = [UITabBarController new];

//    FirstViewController *firstTab = [FirstViewController new];
//    firstTab.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"info_unselected"] selectedImage:[UIImage imageNamed:@"info_selected"]];
//
//    SecondTabViewController *secTab = [SecondTabViewController new];
//    secTab.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"gallery_unselected"] selectedImage:[UIImage imageNamed:@"gallery_selected"]];
//    secTab.navigationItem.title = @"Gallery";

    InfoViewController *thirdTab = [InfoViewController new];
    thirdTab.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"home_unselected"] selectedImage:[UIImage imageNamed:@"home_selected"]];
    thirdTab.navigationItem.title = @"RSShool Task 6";

    [UIView appearance].tintColor = [UIColor requiredBlackColor];
    tabBarCo.viewControllers = @[thirdTab]; // add firstTab,secTab before
    tabBarCo.selectedViewController = tabBarCo.viewControllers[0]; // change to 1
    tabBarCo.navigationItem.hidesBackButton = YES;

    [self.navigationController pushViewController:tabBarCo animated:YES];
}

#pragma mark - Notif

- (void)subscribeOnBackForegroundNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(stopFiguresAnimation) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(startFiguresAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
}

@end
