//
//  HomeViewController.h
//  DestinyApiTest
//
//  Created by Alexander (Dohrn) Dohrn on 1/12/16.
//  Copyright © 2016 Alexander (Dohrn) Dohrn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

- (void)getUserInfo:(NSString *) username;
- (void)getFormattedUsername:(NSString *) username;
- (void)getAccountInfo;

@end
