//
//  ViewController.swift
//  MiniWeb
//
//  Created by LETUE Erwann on 13/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!

    @IBAction func textFieldExited(_ sender: UITextField) {
        if let urlString = searchBar.text {
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            webView.loadRequest(request)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicator.stopAnimating()
        let request = webView.request!
        let url = request.url
        let urlString = url!.absoluteString
        searchBar.text = urlString
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicator.stopAnimating()
    }
}

