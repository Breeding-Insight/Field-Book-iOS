//
//  ContentView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/5/21.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject private var appState: AppState
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(Colors.primaryFB)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .black
        
        let coloredToolbarAppearance = UIToolbarAppearance()
        coloredToolbarAppearance.configureWithOpaqueBackground()
        coloredToolbarAppearance.backgroundColor = UIColor(Colors.primaryFB)
        
        UIToolbar.appearance().standardAppearance = coloredToolbarAppearance
        UIToolbar.appearance().compactAppearance = coloredToolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = coloredToolbarAppearance
        
        UIToolbar.appearance().tintColor = .black
        
        guard let database = Database.instance else {
            fatalError("could not setup database")
        }
        
        do {
            try database.migrateIfNeeded()
        } catch {
            fatalError("failed to migrate database: \(error)")
        }
        
        print(database)
        
    }
    
    var body: some View {
        HomeView()
            .environmentObject(appState)
            .onAppear {
                appState.currentStudyId = SettingsUtilities.getCurrentStudyId()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
