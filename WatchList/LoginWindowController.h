//
//  LoginWindowController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 09/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "popoverViewController.h"
#import <Quartz/Quartz.h>
#import "User.h"
#import "LoginWindowDelegate.h"
#import "User+Create.h"





@interface LoginWindowController : NSWindowController<NSApplicationDelegate>

@property (nonatomic, assign) id<LoginWindowDelegate> delegate;

#pragma mark Views
@property (strong) IBOutlet NSView *loginView;
@property (strong) IBOutlet NSView *loginForm;
@property (strong) IBOutlet NSView *signUpForm;

#pragma mark Images
@property (weak) IBOutlet NSButton *profilePictureButton;

#pragma mark Popover
@property (strong) IBOutlet popoverViewController *popoverViewController;



#pragma mark data sources
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong)NSArray *accounts;

#pragma mark Text Fields
@property (weak) IBOutlet NSTextField *loginTextField;
@property (weak) IBOutlet NSSecureTextField *passwordTextField;
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *emailTextField;
@property (weak) IBOutlet NSSecureTextField *createPasswordTextField;

#pragma Actions
- (IBAction)profilePictureClicked:(id)sender;
- (IBAction)loginClicked:(id)sender;
- (IBAction)signUpClicked:(id)sender;
- (IBAction)signupConfirmed:(id)sender;
- (IBAction)signupCancelled:(id)sender;
@end
