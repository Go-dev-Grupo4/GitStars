//
//  WebViewController.swift
//  GitStars
//
//  Created by Matheus Lenke on 04/04/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Variables
    
    var destinationUrl: String?
    
    // MARK: - UI Components
    
    lazy var webView: WKWebView = {
        let webViewConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.translatesAutoresizingMaskIntoConstraints = false

        return webView
    }()
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: - Private methods
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        setupNavbar()
        configWebView()
        loadWebView()
    }
    
    private func setupNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let forwardBarItem = UIBarButtonItem(image: UIImage.init(systemName: "chevron.right"), style: .plain, target: self, action: #selector(forwardAction))
        
        let backBarItem = UIBarButtonItem(image: UIImage.init(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backAction))
        
        let reloadBarItem = UIBarButtonItem(image: UIImage.init(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reloadWebView))
        
        let exitBarItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(exitWebView))
        
        navigationItem.rightBarButtonItems = [forwardBarItem, backBarItem]
        navigationItem.leftBarButtonItems = [exitBarItem, reloadBarItem]
    }
    
    private func configWebView() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadWebView() {
        
        if let url = destinationUrl {

            // IF APPS ARE NOT INTALLED, OPENS WEBVIEW NAVIGATION
            let prefix = String("www")
            if url.lowercased().hasPrefix(prefix) {
                let newUrl = "https:/\(url)"
                if verifyUrl(urlString: newUrl) {
                    goToUrl(urlString: newUrl)
                    return
                }
            }
             else if url.lowercased().hasPrefix("https:/") {
                 if verifyUrl(urlString: url) {
                     goToUrl(urlString: "\(url)")
                 }
                return
            }
        }
    }
    
    private func goToUrl(urlString: String) {
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }

}

// MARK: - WebViewcontroller actions from buttons implementation
extension WebViewController {
    
    @objc
    private func reloadWebView() {
        webView.reload()
    }
    
    @objc
    private func exitWebView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func forwardAction() {
        
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc
    private func backAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}
