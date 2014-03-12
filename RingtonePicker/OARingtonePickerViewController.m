//
//  OARingtonePickerViewController.m
//  RingtonePicker
//
//  Created by Phat, Le Tan on 3/12/14.
//  Copyright (c) 2014 75Lab. All rights reserved.
//

#import "OARingtonePickerViewController.h"

NSString *const ringtoneCellIdentifier = @"OARingtonePickerViewControllerIdentifier";

@interface OARingtonePickerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ringtoneTableView;
@property (strong, nonatomic) NSArray *ringtones;

@end

@implementation OARingtonePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ringtones = @[@"Opening (Default)", @"Apex", @"Beacon", @"Bulentin", @"By The Seaside", @"Chimes", @"Circuit", @"Consetellation", @"Cosmic"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ringtoneTableView.delegate = self;
    self.ringtoneTableView.dataSource = self;
}

- (NSString *)selectedRingtone
{
    if (!_selectedRingtone) {
        _selectedRingtone = @"Opening (Default)";
    }
    return _selectedRingtone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ringtones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ringtoneCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ringtoneCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //Ugly way
        RAC(cell, accessoryType) = [RACSignal combineLatest:@[RACObserve(self, selectedRingtone), RACObserve(cell.textLabel, text)] reduce:^id(NSString *ringtone, NSString *cellRingtone){
            if ([ringtone isEqualToString:cellRingtone]) {
                return @(UITableViewCellAccessoryCheckmark);
            }
            return @(UITableViewCellAccessoryNone);
        }];
    }
    cell.textLabel.text = self.ringtones[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRingtone = self.ringtones[indexPath.row];
}

@end
