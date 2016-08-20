//
//  CollapsableTableView.h
//  CollapsableTableView
//
//  Created by Bernhard Häussermann on 2011/03/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import "TapDelegate.h"
#import "CollapsableTableViewDelegate.h"

#define COLLAPSED_INDICATOR_LABEL_TAG 36
#define BUSY_INDICATOR_TAG 37


@interface CollapsableTableView : UITableView <UITableViewDelegate,UITableViewDataSource,TapDelegate>
{
    id<UITableViewDelegate> realDelegate;
    id<UITableViewDataSource> realDataSource;
    id<CollapsableTableViewDelegate> collapsableTableViewDelegate;
    
    NSString *collapsedIndicator,*expandedIndicator;
    BOOL showBusyIndicator,sectionsInitiallyCollapsed;
    
    int toggledSection;
    UIView* toggledSectionHeaderView;
    
    NSMutableDictionary *headerTitleToIsCollapsedMap,*headerTitleToSectionIdxMap,*sectionIdxToHeaderTitleMap;
    NSMutableArray *headerHeightArray,*footerHeightArray;
    
    // For the insert-rows optimization.
    int heightOfShortestCellSeen;
    int temporaryRowCountOverride;
    int temporaryRowCountOverrideSectionIdx;
}

@property (nonatomic,assign) id<CollapsableTableViewDelegate> collapsableTableViewDelegate;
@property (nonatomic,retain) NSString* collapsedIndicator;
@property (nonatomic,retain) NSString* expandedIndicator;
@property (nonatomic,assign) BOOL showBusyIndicator;
@property (nonatomic,assign) BOOL sectionsInitiallyCollapsed;
@property (nonatomic,readonly) NSDictionary* headerTitleToIsCollapsedMap;

- (void) setIsCollapsed:(BOOL) isCollapsed forHeaderWithTitle:(NSString*) headerTitle;
- (void) setIsCollapsed:(BOOL) isCollapsed forHeaderWithTitle:(NSString*) headerTitle andView:(UIView*) headerView;
- (void) setIsCollapsed:(BOOL) isCollapsed forHeaderWithTitle:(NSString*) headerTitle withRowAnimation:(UITableViewRowAnimation) rowAnimation;
- (void) setIsCollapsed:(BOOL) isCollapsed forHeaderWithTitle:(NSString*) headerTitle andView:(UIView*) headerView withRowAnimation:(UITableViewRowAnimation) rowAnimation;

@end
