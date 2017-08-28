//
//  BaseRequest.m
//  LiaoNiang
//
//  Created by Jacob on 9/21/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "BaseRequest.h"

@interface BaseRequest()<NSXMLParserDelegate>

@property (nonatomic, strong) NSString *soapBody;
@property (nonatomic, strong) NSString *soapAction;

@property (nonatomic, strong) NSString *responseResult;

@end

@implementation BaseRequest

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (id)initWithSoapBody:(NSString *)soapBody soapAction:(NSString *)soapAction {
    if (self = [super init]) {
        self.soapBody = soapBody;
        self.soapAction = soapAction;
        self.responseResult = @"";
    }
    return self;
}

- (void)startWithPost {
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n%@"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n", self.soapBody];
    NSString *address = @"http://42.51.156.53:8080/LoginService.asmx";
    NSURL *url = [NSURL URLWithString:address];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"content-Type"];
    [request addValue:[NSString stringWithFormat:@"%ld", (unsigned long)[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
    [request addValue:self.soapAction forHTTPHeaderField:@"SOAPAction"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    __weak BaseRequest *weakSelf = self;
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.failedWithType) {
                    weakSelf.failedWithType(0);
                }
            });
            
            
        } else {
            NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:data];
            [xmlRead setDelegate:weakSelf];
            [xmlRead parse];
        }
    }];
    [task resume];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"5 %@", string);
    
    self.responseResult = [NSString stringWithFormat:@"%@%@", self.responseResult, string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    NSLog(@"1 %@", elementName);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"2 %@", elementName);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"3 %@", parseError);
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"4 %@", validationError);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    //    NSLog(@"parserDidStartDocument");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //    NSLog(@"parserDidEndDocument");
    
    if (self.responseResult.length > 0) {
        self.responseResult = [self.responseResult stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[self.responseResult dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&err];
        
        __weak BaseRequest *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (err != nil) {
                if (weakSelf.failedWithType) {
                    weakSelf.failedWithType(1);
                }
            } else {
                if (weakSelf.successWithNetwork) {
                    weakSelf.successWithNetwork(dic);
                }
            }
        });
    } else {
        if (self.failedWithType) {
            self.failedWithType(0);
        }
    }
}

@end
