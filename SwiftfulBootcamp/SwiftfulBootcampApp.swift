//
//  SwiftfulBootcampApp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/20/24.
//

import SwiftUI

@main
struct SwiftfulBootcampApp: App {
    
    let isUserSignedIn: Bool
    
    init() {
        var isUserSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn")
        self.isUserSignedIn = isUserSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
            UITestingBootcampView(currentUserIsSignedIn: isUserSignedIn)
        }
    }
}
