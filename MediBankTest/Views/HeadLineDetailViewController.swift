//
//  HeadLineDetailViewController.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit
import WebKit

class HeadLineDetailViewController: UIViewController {

    var articleData: ArticleEntity?
    var webView : WKWebView?
    var articleURL: String?
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heading Details"
        setupWebContent()
        setupRightBarButtonItem()
    }
    
    func setupRightBarButtonItem() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleClick))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func handleClick() {

        PersistentStorage.shared.persistentContainer.performBackgroundTask { [weak self] context in
            PersistentStorage.shared.saveData(name: self?.articleData?.name ?? "",
                                              description: self?.articleData?.articleDescription ?? "",
                                              isSaved: true,
                                              isSelected: false,
                                              imageURL: self?.articleData?.imageURL ?? "",
                                              articleURL: self?.articleData?.articleURL ?? "",
                                              content: self?.articleData?.content ?? "",
                                              sourceName: self?.articleData?.sourceName ?? "", 
                                              sourceId: self?.articleData?.sourceId ?? "",
                                              author: self?.articleData?.author ?? "",
                                              privateManagedContext: context)
            
            if context.hasChanges {
                try? context.save()
            }
        }
        
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(x: self.view.frame.midX, y: self.view.frame.midY), size: CGSize(width: 20, height: 20)))
        activityIndicator?.style = .medium
        activityIndicator?.hidesWhenStopped = true
        self.view.addSubview(activityIndicator ?? UIActivityIndicatorView())
        activityIndicator?.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicator?.stopAnimating()
    }
    
    func setupWebContent() {
        guard let urlString = articleData?.articleURL else {
            print("No URL Found")
            return
        }
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }

}

extension HeadLineDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.createActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopActivityIndicator()
    }
    
}
