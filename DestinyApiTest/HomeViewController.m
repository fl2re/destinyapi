//
//  HomeViewController.m
//  DestinyApiTest
//
//  Created by Alexander (Dohrn) Dohrn on 1/12/16.
//  Copyright © 2016 Alexander (Dohrn) Dohrn. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "Util.h"

static NSString * const BaseURLString = @"http://www.bungie.net/Platform/Destiny/";
static NSString * const GenericSearchUrl = @"http://www.bungie.net/Platform/User/SearchUsers/?q=";
static NSString * const CannotFindUserString = @"Unable to find user.";

BOOL hasSearchedOnce;
NSString* memberId;

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextView *apiTextView;

- (IBAction)callAPI:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set has searched once to false
    hasSearchedOnce = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//http://www.bungie.net/Platform/Destiny/Manifest/InventoryItem/2007186000/

- (IBAction)callAPI:(id)sender {
    
    [self getUserInfo: self.usernameTextField.text];

}

- (void) getUserInfo:(NSString *)username {
    
    NSCharacterSet *allowedSet = [NSCharacterSet URLFragmentAllowedCharacterSet];

    username = [username stringByReplacingOccurrencesOfString:@" " withString:@"%%20"];
    
    //Test username is "Loud Avocado"
    NSString *membershipIdEndpoint = [NSString stringWithFormat:@"%@1/Stats/GetMembershipIdByDisplayName/%@/", BaseURLString, username];
    
    NSLog(membershipIdEndpoint);
    
    [Util apiCall:membershipIdEndpoint withParams:nil andCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"STILL GOOD");
        NSDictionary *responseDict = (NSDictionary *) responseObject;
        
        //If username is not found (Response = 0), it might not be in the right format
        //Use a more generalized search to get exact format needed
        if ([[responseDict objectForKey:@"Response"] isEqualToString:@"0"]) {
            if(!hasSearchedOnce) {
                [self getFormattedUsername:username];
                return;
            } else {
                self.apiTextView.text = CannotFindUserString;
                return;
            }
            
        }
        
        memberId = [responseDict objectForKey:@"Response"];
        
        //[self getAccountInfo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //failed(operation, error);
        self.apiTextView.text = [error localizedDescription];
    }];

}

- (void) getFormattedUsername:(NSString *)username {
    hasSearchedOnce = true;
    
    NSString *searchEndpoint = [NSString stringWithFormat:@"%@%@", GenericSearchUrl, username];
    
    [Util apiCall:searchEndpoint withParams:nil andCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDict = (NSDictionary *) responseObject;
        
        id possibleNull = [responseDict objectForKey:@"Response"];
        
        //If username is not found (Response = 0), it might not be in the right format
        //Use a more generalized search to get exact format needed
        if (possibleNull == [NSNull null]) {
            self.apiTextView.text = CannotFindUserString;
            return;
        }
        
        self.apiTextView.text = [responseDict description];
        
        NSString *memId = [responseDict objectForKey:@"Response"];
        
        NSString *accountEndpoint = [NSString stringWithFormat:@"%@1/Account/%@/", BaseURLString, memId];
        
        [Util apiCall:accountEndpoint withParams:nil andCompletion:^(AFHTTPRequestOperation *operation, id responseObject2) {
            
            self.apiTextView.text = [(NSDictionary *)responseObject2 description];
            
            //completion(operation, responseObject);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //failed(operation, error);
            self.apiTextView.text = [error localizedDescription];
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //failed(operation, error);
        self.apiTextView.text = [error localizedDescription];
    }];
    
}

- (void) getAccountInfo {
    
    if( memberId != (id)[NSNull null] ) {
        NSString *accountEndpoint = [NSString stringWithFormat:@"%@1/Account/%@/", BaseURLString, memberId];
        
        [Util apiCall:accountEndpoint withParams:nil andCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.apiTextView.text = [(NSDictionary *)responseObject description];
            
            //completion(operation, responseObject);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //failed(operation, error);
            self.apiTextView.text = [error localizedDescription];
        }];
    }
}

@end
