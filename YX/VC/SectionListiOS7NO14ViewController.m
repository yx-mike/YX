//
//  SectionListiOS7NO14ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "SectionListiOS7NO14ViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface SectionListiOS7NO14ViewController ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSArray *vcNames;
@property (strong, nonatomic) NSURLConnection *connection;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";
static OSStatus RNSecTrustEvaluateAsX509(SecTrustRef trust, SecTrustResultType *result)
{
    OSStatus status = errSecSuccess;
    
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef newTrust;
    CFIndex numberOfCerts = SecTrustGetCertificateCount(trust);
    NSMutableArray *certs = [NSMutableArray new];
    for (NSUInteger index = 0; index < numberOfCerts; ++index) {
        SecCertificateRef cert;
        cert = SecTrustGetCertificateAtIndex(trust, index);
        [certs addObject:(__bridge id)cert];
    }
    
    status = SecTrustCreateWithCertificates((__bridge CFArrayRef)certs, policy, &newTrust);
    if (status == errSecSuccess) {
        status = SecTrustEvaluate(newTrust, result);
    }
    
    CFRelease(policy);
    CFRelease(newTrust);
    
    return status;
}

//私有方法
CFAbsoluteTime SecCertificateNotValidBefore(SecCertificateRef certificate);
CFAbsoluteTime SecCertificateNotValidAfter(SecCertificateRef certificate);

@implementation SectionListiOS7NO14ViewController

#pragma mark - View lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = @[@"1.证书有效性验证"];
        _vcNames = @[@""];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"集合视图";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[YXNoMarginTableViewCell class] forCellReuseIdentifier:cellId];
    
    // IP Address for encrypted.google.com
    //  NSURL *url = [NSURL URLWithString:@"https://72.14.204.113"];
    NSURL *url = [NSURL URLWithString:@"https://encrypted.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - <NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLProtectionSpace *protSpace = challenge.protectionSpace;
    SecTrustRef trust = protSpace.serverTrust;
    SecTrustResultType result = kSecTrustResultFatalTrustFailure;
    
    OSStatus status = SecTrustEvaluate(trust, &result);
    if (status == errSecSuccess && result == kSecTrustResultRecoverableTrustFailure) {
        SecCertificateRef cert = SecTrustGetCertificateAtIndex(trust, 0);
        CFStringRef subject = SecCertificateCopySubjectSummary(cert);
        
        CFAbsoluteTime start = SecCertificateNotValidBefore(cert);
        CFAbsoluteTime end = SecCertificateNotValidAfter(cert);
        
        NSLog(@"Begin Date: %@", [NSDate dateWithTimeIntervalSinceReferenceDate:start]);
        NSLog(@"End Date: %@", [NSDate dateWithTimeIntervalSinceReferenceDate:end]);
        
        NSLog(@"Trying to access %@. Got %@.", protSpace.host, subject);
        CFRange range = CFStringFind(subject, CFSTR(".google.com"), kCFCompareAnchored|kCFCompareBackwards);
        if (range.location != kCFNotFound) {
            status = RNSecTrustEvaluateAsX509(trust, &result);
        }
        CFRelease(subject);
    }
    
    
    if (status == errSecSuccess) {
        switch (result) {
            case kSecTrustResultInvalid:
            case kSecTrustResultDeny:
            case kSecTrustResultFatalTrustFailure:
            case kSecTrustResultOtherError:
                // We've tried everything:
            case kSecTrustResultRecoverableTrustFailure:
                NSLog(@"Failing due to result: %u", result);
                [challenge.sender cancelAuthenticationChallenge:challenge];
                break;
                
            case kSecTrustResultProceed:
            case kSecTrustResultUnspecified: {
                NSLog(@"Success with result: %u", result);
                NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
                [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
            }
                break;
                
            default:
                NSAssert(NO, @"Unexpected result from trust evaluation:%u", result);
                break;
        }
    }
    else {
        // Something was broken
        NSLog(@"Complete failure with code: %d", (int)status);
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}

#pragma mark - <NSURLConnectionDataDelegate>

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError:%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"didFinishLoading");
    self.connection = nil;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell bindValuesForTitle:self.sections[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcClassName = self.vcNames[indexPath.row];
    Class vcClass = NSClassFromString(vcClassName);
    id vcObject = [[vcClass alloc] init];
    
    [self.navigationController pushViewController:vcObject animated:YES];
}

@end
