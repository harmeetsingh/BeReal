//
//  BeRealApp.swift
//  Shared
//
//  Created by Harmeet Singh on 14/02/2023.
//

import SwiftUI

@main
struct BeRealApp: App {
    
    private let appCoordinator: AppCoordinatoring
    private let loginCoordinator: LoginCoordinatoring
    
    init() {
        appCoordinator = AppCoordinator()
        loginCoordinator = appCoordinator.makeLogin()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                loginCoordinator.rootView()
            }
        }
    }
}
