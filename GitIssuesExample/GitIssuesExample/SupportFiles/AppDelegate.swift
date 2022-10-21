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
	var mainCoordinator: MainCoordinator?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		self.makeRootViewController()
		return true
	}

	func makeRootViewController() {

		window = UIWindow(frame: UIScreen.main.bounds)
		let navigationController = UINavigationController()
		mainCoordinator = MainCoordinator(with: navigationController)
		mainCoordinator?.configureRootViewController()
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}

