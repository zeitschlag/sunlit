//
//  PhotoEntryCollectionViewCell.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/20/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit

class PhotoEntryCollectionViewCell : UICollectionViewCell {
	@IBOutlet var photo : UIImageView!
	@IBOutlet var date : UILabel!

	static func sizeOf(collectionViewWidth : CGFloat) -> CGSize {
		var sections = Int(collectionViewWidth / 130.0)
		if sections < 2 {
			sections = 2
		}
		
		let width = (collectionViewWidth / CGFloat(sections)) - 8.0
		return CGSize(width: width, height: width + 40.0)
	}
}
