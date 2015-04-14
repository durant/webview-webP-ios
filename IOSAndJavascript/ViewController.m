//
//  ViewController.m
//  IOSAndJavascript
//
//  Created by kevin on 15/4/8.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configBar];

    [self.webView loadHTMLString:@"<img src=\"https://www.gstatic.com/webp/gallery3/2_webp_ll.webp\">" baseURL:nil];

    
//    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
//    UITabBarItem *rightItem = [[UITabBarItem alloc] ]
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"点我一下" style:UIBarButtonItemStylePlain target:self action:@selector(clickAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickAction {
    NSString *js = @"window.click();";
    [_webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)configBar {
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    UITextField *tfSearch = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    tfSearch.delegate = self;
    tfSearch.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = tfSearch;
    tfSearch.layer.cornerRadius = 1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSLog(@"==== return  =====");
    NSString *text = textField.text;
    NSString *js_str = [NSString stringWithFormat:@"document.getElementsByName('q')[0].innerHTML='%@';",text];
    NSString *elements = [_webView stringByEvaluatingJavaScriptFromString:js_str];
    NSString *js_result2 = [_webView stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit();"];
    [self.view endEditing:YES];
    return true;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"javascript.js" ofType:nil];
    NSString *jsContent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:jsContent];

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *resultUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"result === >%@",resultUrl);
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title === >%@",title);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
