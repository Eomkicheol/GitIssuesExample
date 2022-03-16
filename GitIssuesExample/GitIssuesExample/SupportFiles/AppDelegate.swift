	//
	//  AppDelegate.swift
	//  GitIssuesExample
	//
	//  Created by 엄기철 on 2022/03/16.
	//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds).then {
			$0.rootViewController = HomeRouter.home.viewController
			$0.backgroundColor = .white
			$0.makeKeyAndVisible()
		}
		return true
	}
}

