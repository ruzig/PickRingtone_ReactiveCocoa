//
//  OAHomeViewController.m
//  RingtonePicker
//
//  Created by Phat, Le Tan on 3/12/14.
//  Copyright (c) 2014 75Lab. All rights reserved.
//

#import "OAHomeViewController.h"
#import "OARingtonePickerViewController.h"

@interface OAHomeViewController ()

@property (strong, nonatomic) OARingtonePickerViewController *ringtoneController;
@property (weak, nonatomic) IBOutlet UIButton *ringtoneBt;

@end

@implementation OAHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    @weakify(self);
    [[self.ringtoneBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:self.ringtoneController animated:YES];
    }];

    [RACObserve(self.ringtoneController, selectedRingtone) subscribeNext:^(NSString  *ringtone) {
        [self.ringtoneBt setTitle:ringtone forState:UIControlStateNormal];
        [self.ringtoneBt setTitle:ringtone forState:UIControlStateHighlighted];
    }];
}

- (OARingtonePickerViewController *)ringtoneController
{
    if (!_ringtoneController) {
        _ringtoneController = [[OARingtonePickerViewController alloc] init];
    }
    return _ringtoneController;
}

@end
