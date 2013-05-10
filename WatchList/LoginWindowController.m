//
//  LoginWindowController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 09/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "LoginWindowController.h"

@interface LoginWindowController ()

@property (nonatomic, strong) User *user;

- (BOOL)loginFormIsValid;
- (BOOL)signUpFormIsValid;

@end



@implementation LoginWindowController


- (void)windowDidLoad{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"woodBackground.png"]]];
    self.profilePictureButton.image = [NSImage imageNamed:@"constanza.jpg"];
    [self.loginView setWantsLayer:YES];
    [self.loginView addSubview:self.loginForm];
    [self reloadAccounts];
}


- (void)reloadAccounts{
    NSFetchRequest *usersFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    self.accounts = [self.managedObjectContext executeFetchRequest:usersFetchRequest error:nil];
}

- (IBAction)profilePictureClicked:(id)sender {
    IKPictureTaker *pictureTaker = [IKPictureTaker pictureTaker];
    [pictureTaker setInputImage:[NSImage imageNamed:@"constanza.jpg"]];
    [pictureTaker setValue:[NSNumber numberWithBool:YES] forKey:IKPictureTakerShowEffectsKey];
    [pictureTaker setValue:@"Drop an Image Here" forKey:IKPictureTakerInformationalTextKey];
    [pictureTaker beginPictureTakerSheetForWindow:self.window withDelegate:self didEndSelector:@selector(pictureTakerValidated:code:contextInfo:) contextInfo:nil];
}


- (void) pictureTakerValidated:(IKPictureTaker*) pictureTaker code:(int) returnCode contextInfo:(void*) ctxInf
{
    if(returnCode == NSOKButton){
        NSImage *outputImage = [pictureTaker outputImage];
        [self.profilePictureButton setImage:outputImage];
    }
}

- (IBAction)loginClicked:(id)sender{
    if (self.loginFormIsValid) {
        [self.delegate loggedInUser:self.user];
    }
}

- (IBAction)signUpClicked:(id)sender{
    [[self.loginView animator] replaceSubview:self.loginForm with:self.signUpForm];
}

- (IBAction)signupConfirmed:(id)sender{
    if (self.signUpFormIsValid) {
        //Create new profile!
        User *newUser;
        newUser = [User userWithLogin:self.nameTextField.stringValue password:self.createPasswordTextField.stringValue profilePicture:self.profilePictureButton.image inManagedObjectContext:self.managedObjectContext];
        [self reloadAccounts];
        [self.delegate loggedInUser:newUser];

    }
}

- (IBAction)signupCancelled:(id)sender{
    [[self.loginView animator] replaceSubview:self.signUpForm with:self.loginForm];
}


- (BOOL)loginFormIsValid{
    
    NSUInteger indexOfProfile = [self.accounts indexOfObjectPassingTest:^BOOL (id object, NSUInteger index, BOOL *stop){
        if ([[object valueForKey:@"login"] isEqualToString: self.loginTextField.stringValue]){
            *stop = YES;
            return YES;
        } else
        return NO;
    }];
    
    if (indexOfProfile == NSNotFound){
        NSLog(@"user not found!");
        [self.popoverViewController showRelativeToRect:self.loginTextField.bounds ofView:self.loginTextField preferredEdge:NSMinXEdge title:@"Unknown user name" text:@"Please enter valid user name"];
        return NO;
    }
    
    if ([[[self.accounts objectAtIndex:indexOfProfile] valueForKey:@"password"] isEqualToString:self.passwordTextField.stringValue]) {
        NSLog(@"success!");
        
        self.user = [self.accounts objectAtIndex:indexOfProfile];
        
        
        return YES;
    } else {
        NSLog(@"wrong password!");
        [self.popoverViewController showRelativeToView:self.passwordTextField preferredEdge:NSMaxXEdge title:@"Incorrect password" text:@"Please enter valid password"];
        return NO;
    }
}

- (BOOL)signUpFormIsValid{
    if ([self.nameTextField.stringValue isEqualToString:@""]) {
        [self.popoverViewController showRelativeToView:self.nameTextField preferredEdge:NSMaxXEdge title:@"Invalid user name" text:@"Please enter valid user name"];
        //show popover relative to name text field with message "Please fill this field"
        NSLog(@"no name");
        return NO;
    }
    
    
    NSUInteger indexOfAccount =  [self.accounts indexOfObjectPassingTest:^BOOL (id object, NSUInteger index, BOOL *stop){
        if ([[object valueForKey:@"login"] isEqualToString: self.nameTextField.stringValue]){
            *stop = YES;
            return YES;
        } else
            return NO;
    }];

    if (indexOfAccount != NSNotFound) {
        [self.popoverViewController showRelativeToView:self.nameTextField preferredEdge:NSMaxXEdge title:@"Duplicate user name" text:@"Account with such user name already exists"];
        //show popover relative to name text field with message "Account already exists"
        NSLog(@"duplicate account");
        return NO;
    }
    
    
    if ([self.emailTextField.stringValue isEqualToString:@""]) {
        [self.popoverViewController showRelativeToView:self.emailTextField preferredEdge:NSMaxXEdge title:@"Invalid email" text:@"Please enter valid email address"];
        //show popover relative to name text field with message "Please fill this field"
        NSLog(@"no email");
        return NO;
    }
    
    if ([self.createPasswordTextField.stringValue isEqualToString:@""]) {
        //show popover relative to password text field with message "Please fill this field"
        [self.popoverViewController showRelativeToView:self.createPasswordTextField preferredEdge:NSMaxXEdge title:@"Incorrect password" text:@"Please enter valid password"];
        NSLog(@"no password");
        return NO;
    } else if (self.createPasswordTextField.stringValue.length < 6){
        //show popover relative to name text field with message "password must contain at least 6 characters"
        [self.popoverViewController showRelativeToView:self.createPasswordTextField preferredEdge:NSMaxXEdge title:@"Invalid password" text:@"Password must contain at least six characters"];
        NSLog(@"short password");
        return NO;
    } else{
        NSLog(@"success!");
        return YES;
    }
}




@end
