//
//  SDFSwitchGenderViewController.m
//  SwitchGender
//
//  Created by De Fano Salvatore on 08/06/15.
//  Copyright (c) 2015 Yoox. All rights reserved.
//

#import "SDFSwitchGenderViewController.h"

#import "SDFPageOneViewController.h"
#import "SDFPageTwoViewController.h"
#import "SDFPageThreeViewController.h"  
#import "SDFPageFourViewController.h"

#define PAGE_SUFF       @"Page"

@interface SDFSwitchGenderViewController ()

@property (strong, nonatomic) SDFPageOneViewController *onePageViewController;
@property (strong, nonatomic) SDFPageTwoViewController *twoPageViewController;
@property (strong, nonatomic) SDFPageThreeViewController *threePageViewController;
@property (strong, nonatomic) SDFPageFourViewController *fourPageViewController;

@property(strong, nonatomic, readwrite) NSString *genderSelect;
@property (nonatomic, assign) NSInteger pageNumberSelect;

@end

@implementation SDFSwitchGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.genderSelect = @"D";
    self.pageNumberSelect = 1;
    NSLog(@"Il gender di default è: %@ , la pagina è: %@", self.genderSelect, [self makePageName:1]);
    self.onePageViewController = [
                               self.storyboard
                               instantiateViewControllerWithIdentifier:[self makePageName:1]
                               ];
    [self.view insertSubview:self.onePageViewController.view atIndex:0];
}

- (NSString *)makePageName:(NSInteger)param {
    NSString *pageName = nil;
    self.pageNumberSelect = param;
    pageName = [NSString stringWithFormat:@"%@%li%@%@", PAGE_SUFF, (long)param, @"_", self.genderSelect];
    
    NSLog(@"LA pagina selezionata è:%@", pageName );
    
    return pageName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if (!self.onePageViewController.view.superview) {
        self.onePageViewController = nil;
    }
    if (!self.twoPageViewController.view.superview) {
        self.twoPageViewController = nil;
    }
    if (!self.threePageViewController.view.superview) {
        self.threePageViewController = nil;
    }
    if (!self.fourPageViewController.view.superview) {
        self.fourPageViewController = nil;
    }
}

- (IBAction)switchGenderViews:(id)sender{
    
    NSLog(@"IL gender selezionata è :%@", [sender title] );
 
    NSString *titleGender = [sender title];
    NSString *newGender = @"";
    
    if([titleGender isEqualToString:@"Men"]){
        newGender = @"U";
    }
    if([titleGender isEqualToString:@"Women"]){
        newGender = @"D";
    }
    
    if ([newGender isEqualToString: self.genderSelect]) {
        return;
    }
    
    self.genderSelect = newGender;
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [self.onePageViewController.view removeFromSuperview];
    [self.twoPageViewController.view removeFromSuperview];
    [self.threePageViewController.view removeFromSuperview];
    [self.fourPageViewController.view removeFromSuperview];
    
    self.onePageViewController = [self.storyboard
                                  instantiateViewControllerWithIdentifier:[self makePageName:1]
                                  ];
    
    [self.view insertSubview:self.onePageViewController.view atIndex:0];
    
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                           forView:self.view cache:YES];
    
    [UIView commitAnimations];
}

- (IBAction)callPage:(id)sender{
    
    NSInteger newPage = 0;
    
    if([sender isKindOfClass:[UIBarButtonItem class]]){
        NSLog(@"Sender è di tipo %@",NSStringFromClass([sender class]));
        UIBarButtonItem *btn = sender;
        NSString *btnTitle = btn.title;
//        NSString *btnTitle = [sender title];
        
    
        if([btnTitle isEqualToString:@"Page1"]){
            newPage = 1;
        }
        if([btnTitle isEqualToString:@"Page2"]){
            newPage = 2;
        }
        if([btnTitle isEqualToString:@"Page3"]){
            newPage = 3;
        }
        if([btnTitle isEqualToString:@"Page4"]){
            newPage = 4;
        }
    }
    
    if (newPage == self.pageNumberSelect) {
        return;
    }
    
    self.pageNumberSelect = newPage;
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [self.onePageViewController.view removeFromSuperview];
    [self.twoPageViewController.view removeFromSuperview];
    [self.threePageViewController.view removeFromSuperview];
    [self.fourPageViewController.view removeFromSuperview];
    
    switch( self.pageNumberSelect ){
        case 1:
            
            self.onePageViewController = [self.storyboard
                                          instantiateViewControllerWithIdentifier:[self makePageName:self.pageNumberSelect]
                                          ];
            
            [self.view insertSubview:self.onePageViewController.view atIndex:0];
            break;
        case 2:
            self.twoPageViewController = [self.storyboard
                                          instantiateViewControllerWithIdentifier:[self makePageName:self.pageNumberSelect]
                                          ];
            [self.view insertSubview:self.twoPageViewController.view atIndex:0];
            break;
        case 3:
            self.threePageViewController = [self.storyboard
                                          instantiateViewControllerWithIdentifier:[self makePageName:self.pageNumberSelect]
                                          ];
            [self.view insertSubview:self.threePageViewController.view atIndex:0];
            break;
        case 4:
            self.fourPageViewController = [self.storyboard
                                          instantiateViewControllerWithIdentifier:[self makePageName:self.pageNumberSelect]
                                          ];
            [self.view insertSubview:self.fourPageViewController.view atIndex:0];
            break;
    }
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
                           forView:self.view cache:YES];
    
    [UIView commitAnimations];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
