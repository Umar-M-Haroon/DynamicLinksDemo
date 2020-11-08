//
//  LinkController.swift
//  FirebaseFrameworkWrapper
//
//  Created by Umar Haroon on 11/8/20.
//

import Combine
import Foundation
import FirebaseDynamicLinks
public class LinkController {
    static var cancellables: Set<AnyCancellable> = []
    
    // just a demo function to use some dynamic link classes
    // if you're to comment out this function, then it builds successfully, otherwise itll throw errors
    
    public static func createLink(link: URL) -> Future<URL, Never> {
        return Future { promise in
            guard let shareLink = DynamicLinkComponents.init(link: link, domainURIPrefix: "https://example.com/link") else {
                print("Error creating dynamic link")
                return
            }
            if let bundleID = Bundle.main.bundleIdentifier {
                shareLink.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleID)
            }
            let navigationParameters = DynamicLinkNavigationInfoParameters()
            navigationParameters.isForcedRedirectEnabled = true
            shareLink.navigationInfoParameters = navigationParameters

            shareLink.shorten { (url, _, error) in
                if let url = url{
                    promise(.success(url))
                }
            }
        }
    }
}
