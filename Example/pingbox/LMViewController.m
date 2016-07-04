/**
 * Copyright (c) 2016, Air Bank a.s. (www.airbank.cz).
 *
 * All rights reserved. This source code can be used only for purposes specified
 * by the given license contract signed by the rightful deputy of Air Bank a.s.
 * This source code can be used only by the owner of the license.
 *
 * Any disputes arising in respect of this agreement (license) shall be brought
 * before the Municipal Court of Prague.
 *
 */

#import "LMViewController.h"

@interface LMViewController ()

@end

@implementation LMViewController {
    NSArray *_messages;
}

#pragma mark - UIViewController Callbacks and Settings

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // prepare mock messages
        
        LMNotification *notification1 = [[LMNotification alloc] init];
        notification1.title = @"Máme pro vás super zprávy!";
        notification1.message = @"Když vidíme, že vám končí platnost platební karty, automaticky vám s předstihem obvykle tří týdnů posíláme zdarma novou.";
        notification1.approveButtonTitle = @"Zjistit více";
        notification1.cancelButtonTitle = @"Zrušit";
        notification1.icon = [UIImage imageNamed:@"ic_star.png"];
        
        LMNotification *notification2 = [[LMNotification alloc] init];
        notification2.title = @"Změna zůstatku";
        notification2.message = @"Zůstatek účtu Běžný účet se zvýšil o 800,- CZK (příchozí platba). Dostupný zůstatek 15.12.2016 v 11:45 je 26 800,- CZK.";
        notification2.approveButtonTitle = @"Zjistit více";
        notification2.cancelButtonTitle = @"Zrušit";
        notification2.icon = [UIImage imageNamed:@"ic_star.png"];
        
        LMNotification *notification3 = [[LMNotification alloc] init];
        notification3.title = @"Přihlášení do Internet bankingu";
        notification3.message = @"Potvrďte prosím své přihlášení do internetového bankovnictví.";
        notification3.approveButtonTitle = @"Jdu na to";
        notification3.cancelButtonTitle = @"Zrušit";
        notification3.icon = [UIImage imageNamed:@"ic_star.png"];
        
        _messages = @[notification1, notification2, notification3];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the delegate up
    [LMNotificationCenter defaultCenter].delegage = self;
    
    // Show three messages
    [self recurse:3];
}

#pragma mark - Message box delegate callbacks

- (void) didOpenNotification:(LMNotification *)notification
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:notification.title
                                                                        message:notification.message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void) didCloseNotification:(LMNotification *)notification
{
    
}

#pragma mark - Helper class for recursion

- (void) recurse:(int)i
{
    if (i == 0) {
        _messages = nil; // remove the notifications from static array
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LMNotification *notification = [_messages objectAtIndex:i % 3];
        [[LMNotificationCenter defaultCenter] postNotification:notification];
        [self recurse:i - 1];
    });
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


@end
