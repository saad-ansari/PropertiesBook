//
//  CollapsableTableViewDelegate.h
//  CollapsableTableView
//
//  Created by Bernhard Häussermann on 2012/12/20.
//
//

#import <Foundation/Foundation.h>

@class CollapsableTableView;

@protocol CollapsableTableViewDelegate <NSObject>

@optional

- (void) collapsableTableView:(CollapsableTableView*) tableView willCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView;
- (void) collapsableTableView:(CollapsableTableView*) tableView didCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView;
- (void) collapsableTableView:(CollapsableTableView*) tableView willExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView;
- (void) collapsableTableView:(CollapsableTableView*) tableView didExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView;

@end
