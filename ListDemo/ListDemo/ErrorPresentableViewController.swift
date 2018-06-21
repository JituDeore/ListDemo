//
//  ErrorPresentableViewController.swift
//  ListDemo
//
//  Created by Jitendra Deore on 21/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit

/**
 ErrorPresentableViewController needs to be implemented by UIViewControllers
 which wants to display error full page, in a view which encapsulates
 ListViewController.
 */
protocol ErrorPresentableViewController {
    /// ErrorView which will be used to render error.
    var errorView: ErrorView    { get }
    
    var errorContainer: UIView { get }
    
    /// Asks the view controller whether fullscreen error can be presented
    var canFullScreenErrorBePresented: Bool      { get }
}

extension ErrorPresentableViewController where Self: UIViewController {
    
    /// Adds a full page error to the caller view
    func handlePageError(_ _error: Error?, isHeadline: Bool = false) {
        guard let error = _error as NSError? else {
            return
        }
        switch error.code {
        case ListErrorCodes.noNetWork:
            showErrorScreenIfRequired(errorContentType: .noNetwork)
        case ListErrorCodes.noContent:
            showErrorScreenIfRequired(errorContentType: .noContent)
        case ListErrorCodes.timeOut:
            showErrorScreenIfRequired(errorContentType: .serverTimeout)
        default:
            showErrorScreenIfRequired(errorContentType: .defaultError)
            //contentListViewController.showInfoMessage(message: "Something Went Wrong", withLoder: false)
            break
        }
    }
    func removeErrorScreen() {
        self.errorView.removeErrorView()
    }
    
    private func showErrorScreenIfRequired(errorContentType: ErrorContentType) {
        if  canFullScreenErrorBePresented  {
            errorView.presentInView(parentView: errorContainer, errorContent: errorContentType)
        }
    }
    
    var errorContainer: UIView { return view }
}

