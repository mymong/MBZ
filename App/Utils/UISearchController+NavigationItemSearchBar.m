//
//  UISearchController+NavigationItemSearchBar.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-10-10.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "UISearchController+NavigationItemSearchBar.h"

@implementation UISearchBar (NavigationItemSearchBar)

+ (instancetype)searchBarAsTitleViewOfNavigationItem:(UINavigationItem *)navigationItem {
    UISearchBar *searchBar = [UISearchBar new];
    [searchBar setAsTitleViewOfNavigationItem:navigationItem];
    return searchBar;
}

- (void)setAsTitleViewOfNavigationItem:(UINavigationItem *)navigationItem {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundImage = [UIImage new];
    [self sizeToFit];
    
    // add to NavigationBar.
    [navigationItem setTitleView:self];
    
    // set rounded-rect border of SearchBar.
    self.placeholder = @"Search";
    [self setTextFieldRoundedRectBorderWithCornerRadius:6.0f borderWidth:1.0f borderColor:UIColor.lightGrayColor];
    self.placeholder = nil;
    
    // set default style of keyboard.
    [self setTextFieldKeyboardStyleDefault];
}

- (void)setTextFieldRoundedRectBorderWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UITextField *searchField = [self textField];
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    searchField.layer.cornerRadius = (cornerRadius > 0.0) ? cornerRadius : 6.0f;
    searchField.layer.borderWidth = (borderWidth > 0.0) ? borderWidth : 1.0f;
    searchField.layer.borderColor = (borderColor ?: [UIColor lightGrayColor]).CGColor;
}

- (void)setTextFieldKeyboardStyleDefault {
    UITextField *searchField = [self textField];
    searchField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchField.autocorrectionType = UITextAutocorrectionTypeNo;
    searchField.keyboardType = UIKeyboardTypeDefault;
}

- (UITextField *)textField {
    return [self firstTextFieldInView:self];
}

- (UITextField *)firstTextFieldInView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:UITextField.class]) {
            return (id)subview;
        }
    }
    for (UIView *subview in view.subviews) {
        UITextField *textField = [self firstTextFieldInView:subview];
        if (textField) {
            return textField;
        }
    }
    return nil;
}

@end

@implementation UISearchController (NavigationItemSearchBar)

+ (instancetype)searchControllerWithSearchBarAsTitleViewOfNavigationItem:(UINavigationItem *)navigationItem withSearchResultsController:(UIViewController *)searchResultsController {
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    searchController.hidesNavigationBarDuringPresentation = NO;
    [searchController.searchBar setAsTitleViewOfNavigationItem:navigationItem];
    return searchController;
}

@end
