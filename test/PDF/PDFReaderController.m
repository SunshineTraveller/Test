//
//  PDFReaderController.m
//  test
//
//  Created by CBCT_MBP on 2019/9/29.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "PDFReaderController.h"
#import <WebKit/WebKit.h>
#import "CommentNode.h"


@interface PDFReaderController ()
@property(nonatomic,strong)  WKWebView *webview;
@end

@implementation PDFReaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path;
    if (!self.txt) {
        path = [[NSBundle mainBundle] pathForResource:self.title ofType:@"pdf"];
        NSURL *pdfUrl = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:pdfUrl];
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_webview];
        [_webview loadRequest:request];
    }else {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        WKPreferences *preferences = [[WKPreferences alloc]init];
        preferences.minimumFontSize = 15;
        preferences.javaScriptCanOpenWindowsAutomatically = true;
        configuration.preferences = preferences;
        
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        [self.view addSubview:_webview];
        
        path = [[NSBundle mainBundle] pathForResource:self.title ofType:@"txt"];
        
        NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        //如果不是 则进行GBK编码再解码一次
        if (!contents) {
            contents =[NSString stringWithContentsOfFile:path encoding:0x80000632 error:nil];
        }
        //不行用GB18030编码再解码一次
        if (!contents) {
            contents =[NSString stringWithContentsOfFile:path encoding:0x80000631 error:nil];
        }
        if (contents) {
            [_webview loadHTMLString:contents baseURL:nil];
        }
    }
    
//    [self performSelector:@selector(timerAction) withObject:nil afterDelay:1];
}

-(void)timerAction {
    [self performSelector:@selector(timerAction) withObject:nil afterDelay:1];
    
    CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)self.title, NULL, NULL);
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    CFRelease(pdfURL);
    
    NSLog(@"%@",[self getPDFContents:pdfDocument]);
}

#pragma mark 获取pdf文件目录
- (NSArray *)getPDFContents: (CGPDFDocumentRef) myDocument
{
    
    CGPDFDictionaryRef mycatalog= CGPDFDocumentGetCatalog(myDocument);
    CommentNode *rootNode = [[CommentNode alloc] initWithCatalog:mycatalog];
    CommentNode *rootOutlineNode = [rootNode childrenForName:@"/Outlines"];
    CommentNode *pagesNode = [rootNode childrenForName:@"/Pages"];
    NSArray *pagesArray = [self getPagesFromPagesNode:pagesNode];
    CommentNode *destsNode = [rootNode childrenForName:@"/Dests"];
    
    return [self getContentsForOutlineNode:rootOutlineNode pages:pagesArray destsNode:destsNode];
}

- (NSArray *)getContentsForOutlineNode:(CommentNode *)rootOutlineNode pages:(NSArray *)pagesArray destsNode:(CommentNode *)destsNode
{
    NSMutableArray *outlineArray = [[NSMutableArray alloc] init];
    CommentNode *firstOutlineNode = [rootOutlineNode childrenForName:@"/First"];
    CommentNode *outlineNode = firstOutlineNode;
    while (outlineNode) {
        NSString *title = [[outlineNode childrenForName:@"/Title"] value];
        CommentNode *destNode = [outlineNode childrenForName:@"/Dest"];
        NSMutableDictionary *outline = [NSMutableDictionary dictionaryWithDictionary:@{@"Title": title}];
        int index = 0;
        if (destNode) {
            if ([[destNode typeAsString] isEqualToString:@"Array"]) {
                CGPDFObjectRef dest = (__bridge CGPDFObjectRef)[[[destNode children] objectAtIndex:0] object];
                index = [self getIndexInPages:pagesArray forPage:dest];
            } else if ([[destNode typeAsString] isEqualToString:@"Name"]) {
                NSString *destName = [destNode value];
                CGPDFObjectRef dest = (__bridge CGPDFObjectRef)[[[[[destsNode childrenForName:destName] childrenForName:@"/D"] children] objectAtIndex:0] object];
                index = [self getIndexInPages:pagesArray forPage:dest];
            }
        } else {
            CommentNode *aNode = [outlineNode childrenForName:@"/A"];
            if (aNode) {
                CommentNode *dNode = [aNode childrenForName:@"/D"];
                if (dNode) {
                    CommentNode *d0Node = [[dNode children] objectAtIndex:0];
                    if ([[d0Node typeAsString] isEqualToString:@"Dictionary"]) {
                        CGPDFObjectRef dest = (CGPDFObjectRef)[d0Node object];
                        index = [self getIndexInPages:pagesArray forPage:dest];
                    }
                }
            }
        }
        [outline setObject:@(index) forKey:@"Index"];
        NSArray *subOutlines = [self getContentsForOutlineNode:outlineNode pages:pagesArray destsNode:destsNode];
        [outline setObject:subOutlines forKey:@"SubContents"];
        [outlineArray addObject:outline];
        outlineNode = [outlineNode childrenForName:@"/Next"];
    }
    return outlineArray;
}

- (NSArray *)getPagesFromPagesNode:(CommentNode *)pagesNode
{
    NSMutableArray *pages = [NSMutableArray new];
    CommentNode *kidsNode = [pagesNode childrenForName:@"/Kids"];
    for (CommentNode *node in [kidsNode children]) {
        NSString *type = [[node childrenForName:@"/Type"] value];
        if ([type isEqualToString:@"/Pages"]) {
            NSArray *kidsPages = [self getPagesFromPagesNode:node];
            [pages addObjectsFromArray:kidsPages];
        } else {
            [pages addObject:node];
        }
    }
    return pages;
}

- (int)getIndexInPages:(NSArray *)pages forPage:(CGPDFObjectRef)page
{
    for (int k = 0; k < pages.count; k++) {
        CommentNode *node = [pages objectAtIndex:k];
        if ([node object] == page)
            return k+1;
    }
    return 1;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    _webview.frame = CGRectMake(0, 0, size.width, size.height);
}
-(BOOL)shouldAutorotate {
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
