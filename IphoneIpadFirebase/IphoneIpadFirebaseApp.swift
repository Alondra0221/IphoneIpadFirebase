//
//  IphoneIpadFirebaseApp.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 01/11/23.
//

import SwiftUI

@main
struct IphoneIpadFirebaseApp: App {
    
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        let login = FirebaseViewModel()
        
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
