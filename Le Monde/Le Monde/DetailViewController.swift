//
//  DetailViewController.swift
//  Le Monde
//
//  Created by LETUE Erwann on 14/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    func configureView() {
        if let detail = detailItem {
            if let article = detailItem {
                title = article.title
                if let link = article.permalink {
                    if let url = URL(string: link) {
                        let request = URLRequest(url: url)
                        webView.loadRequest(request)
                    }
                }
            }
        }
    }

    var detailItem: Article?
}

