//
//  SettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/11/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "gearshape")
                    Text("General")
                }
            }
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            }
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "square.grid.2x2")
                    Text("Appearance")
                }
            }
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                    Text("Behavior")
                }
            }
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "speaker.wave.2.fill")
                    Text("Sounds")
                }
            }
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "externaldrive.connected.to.line.below.fill")
                    Text("BrAPI")
                }
            }
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image(systemName: "server.rack")
                    Text("Database")
                }
            }
        }.listStyle(.plain)
            .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
