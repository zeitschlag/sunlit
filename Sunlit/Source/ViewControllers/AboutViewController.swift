//
//  AboutViewController.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/22/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

	@IBOutlet var webview : WKWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.title = "Credits"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(back))
		
		if let urlPath = Bundle.main.url(forResource: "credits", withExtension: "html") {
			self.webview.load(URLRequest(url: urlPath))
		}
	}

	@IBAction func back() {
		self.navigationController?.popViewController(animated: true)
	}
	
}
