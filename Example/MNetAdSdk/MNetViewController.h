//
//  MNetViewController.h
//  MNetAdSdk
//
//  Created by kunal5692 on 07/11/2018.
//  Copyright (c) 2018 kunal5692. All rights reserved.
//

@import UIKit;

@interface MNetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *adsTableView;

@end

@interface MNAdViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *separator;
- (void)showSeparator;
- (void)hideSeparator;
@end
