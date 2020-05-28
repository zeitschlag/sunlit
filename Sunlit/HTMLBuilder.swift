//
//  HTMLBuilder.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/26/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit

class HTMLBuilder {

	static func createHTML(sections : [SunlitComposition], mediaPathDictionary : [SunlitMedia : MediaLocation]) -> String {
		var html = ""
		
		for index in 0 ... sections.count - 1 {
			let section = sections[index]
			html = html + HTMLBuilder.htmlForComposition(section, mediaPathDictionary)
			
			if index < sections.count - 1 {
				html = html + "\n\n"
			}
		}
		
		return html
	}

	static func htmlForComposition(_ section : SunlitComposition, _ mediaDictionary : [SunlitMedia : MediaLocation]) -> String {
		var html = ""
		
		if section.text.count > 0 {
			html = html + section.text
			html = html + "\n\n"
		}
		
		let mediaCount = section.media.count
		for media in section.media {
			let mediaLocation = mediaDictionary[media]!
			
			if media.type == .image {
				let mediaHtml = HTMLBuilder.htmlForImage(media: media, location: mediaLocation, useSmallerImages: (mediaCount > 1))
				html = html + mediaHtml
			}
			else if media.type == .video {
				let mediaHtml = HTMLBuilder.htmlForVideo(media: media, location: mediaLocation)
				html = html + mediaHtml
			}
			
		}
		
		return html
	}
	
	static func htmlForImage(media : SunlitMedia, location : MediaLocation, useSmallerImages : Bool) -> String {
		
		// Right now, for images, imagePath and thumbnailPath are the same, however, for videos the thumbnailPath represents the poster.
		// In theory, we could have the Snippets + server API return a URL for an image thumbnail but it currently doesn't do that.
		let imagePath = location.path
		let thumbnailPath = location.thumbnailPath
		
		let image = media.getImage()
		let imageWidth = "\(image.size.width)"
		let imageHeight = "\(image.size.height)"
		let imageAlt = media.altText
		var imageText = ""
		
		if useSmallerImages {
			imageText = "<a href=\"{{url}}\"><img src=\"{{thumbnail}}\" width=\"{{width}}\" height=\"{{height}}\" alt=\"{{alt}}\" style=\"display: inline-block; max-height: 200px; width: auto; padding: 1px;\" class=\"sunlit_image\" /></a>"
		}
		else {
			imageText = "<img src=\"{{url}}\" width=\"{{width}}\" height=\"{{height}}\" alt=\"{{alt}}\" style=\"height: auto;\" class=\"sunlit_image\" />"
		}
		
		imageText = imageText.replacingOccurrences(of: "{{url}}", with: imagePath)
		imageText = imageText.replacingOccurrences(of: "{{width}}", with: imageWidth)
		imageText = imageText.replacingOccurrences(of: "{{height}}", with: imageHeight)
		imageText = imageText.replacingOccurrences(of: "{{alt}}", with: imageAlt)
		imageText = imageText.replacingOccurrences(of: "{{thumbnail}}", with: thumbnailPath)

		return imageText
	}
	
	static func htmlForVideo(media : SunlitMedia, location : MediaLocation) -> String {
		
		// TODO: Need to make html formatted better for video...
		return HTMLBuilder.htmlForImage(media: media, location: location, useSmallerImages: true)
	}
}
