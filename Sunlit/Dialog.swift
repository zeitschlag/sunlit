//
//  Dialogs.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/3/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit
import Snippets

class Dialog {
	
	init (_ viewController : UIViewController) {
		self.viewController = viewController
	}
	
	func information(_ string : String, completion: (()->Void)? = nil) {
		
		self.completion = completion
		
		// Make sure we aren't on a background thread...
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: nil, message: string, preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
				if let completion = self.completion {
					completion()
				}
			}))
			
			self.viewController.present(alertController, animated: true, completion: nil)
		}
	}
	
	func selectBlog(completion: (()->Void)? = nil) {
		
		self.completion = completion
		
		Snippets.shared.fetchCurrentUserConfiguration { (error, configuration) in
			
			// Check for a media endpoint definition...
			if let mediaEndPoint = configuration["media-endpoint"] as? String {
				Settings.saveMediaEndpoint(mediaEndPoint)
				Snippets.shared.setMediaEndPoint(mediaEndPoint)
			}
			
			DispatchQueue.main.async {

				if let destinations = configuration["destination"] as? [[String : Any]] {
					
					if destinations.count > 1 {
						self.selectBlogConfiguration(destinations)
						return
					}
				
					if let destination = destinations.first {
						Settings.saveBlogDictionary(destination)
					}
				}
			}
		}

	}
	
	private func selectBlogConfiguration(_ destinations : [[String : Any]]) {

		let actionSheet = UIAlertController(title: nil, message: "Please select which Micro.blog to use when publishing.", preferredStyle: .actionSheet)

		for destination in destinations {
			if let title = destination["name"] as? String,
				let blogId = destination["uid"] as? String {
				let action = UIAlertAction(title: title, style: .default) { (action) in
					Settings.saveBlogDictionary(destination)
					Snippets.shared.setBlogIdentifier(blogId)
					
					if let completion = self.completion {
						completion()
					}
				}
				
				actionSheet.addAction(action)
			}
		}
		
		self.viewController.present(actionSheet, animated: true) {
		}

	}
	
	private var viewController : UIViewController!
	private var completion : (()->Void)? = nil
}
