//
//  Settings.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/3/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import Foundation

class Settings {
	
	static func savePermanentToken(_ token : String)
	{
		//UUKeychain.saveString(key: "SunlitToken", acceessLevel: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, string: token)
		UserDefaults.standard.setValue(token, forKey: "SunlitToken")
	}

	static func permanentToken() -> String?
	{
		//return UUKeychain.getString(key: "SunlitToken")
		return UserDefaults.standard.string(forKey: "SunlitToken")
	}
}