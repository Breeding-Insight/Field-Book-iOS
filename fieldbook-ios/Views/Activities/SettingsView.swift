//
//  SettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/11/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        List {
            NavigationLink(destination: GeneralSettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "gearshape")
                    Text("General")
                }
            }
            NavigationLink(destination: ProfileSettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "person.fill")
                    Text("Profile")
                }
            }
            NavigationLink(destination: AppearanceSettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "square.grid.2x2")
                    Text("Appearance")
                }
            }
            NavigationLink(destination: BehaviorSettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                    Text("Behavior")
                }
            }
            NavigationLink(destination: SoundsSettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "speaker.wave.2.fill")
                    Text("Sounds")
                }
            }
            NavigationLink(destination: BrAPISettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "externaldrive.connected.to.line.below.fill")
                    Text("BrAPI")
                }
            }
            NavigationLink(destination: DatabaseSettingsView()) {
                HStack {
                    SwiftUI.Image(systemName: "cylinder.split.1x2.fill")
                    Text("Database")
                }
            }
        }.listStyle(.plain)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
