//
//  HomeScreenWidget.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/5/21.
//

import SwiftUI

struct HomeScreenNav: View {
    @EnvironmentObject private var appState: AppState
    @State private var selection: String? = nil

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                HomeScreenNavItem(icon: "fields", label: "Fields", destination: AnyView(FieldListView()), disabled: false, selection: $selection)
                Spacer()
                HomeScreenNavItem(icon: "traits", label: "Traits", destination: AnyView(TraitListView()), disabled: false, selection: $selection)
                Spacer()
            }.padding(.bottom)
            Spacer()
            HStack {
                Spacer()
                HomeScreenNavItem(icon: "create", label: "Collect", destination: AnyView(CollectView()), disabled: (appState.currentStudyId == nil), selection: $selection).disabled(appState.currentStudyId == nil)
                Spacer()
                HomeScreenNavItem(icon: "save", label: "Export", destination: AnyView(Text("View Fields")), disabled: (appState.currentStudyId == nil), selection: $selection).disabled(appState.currentStudyId == nil)
                Spacer()
            }.padding(.bottom).padding(.top)
            Spacer()
            HStack {
                Spacer()
                HomeScreenNavItem(icon: "settings", label: "Settings", destination: AnyView(SettingsView()), disabled: false, selection: $selection)
                Spacer()
                HomeScreenNavItem(icon: "info", label: "About", destination: AnyView(Text("View About")), disabled: false, selection: $selection)
                Spacer()
            }.padding(.top)
                .frame(maxWidth: .infinity)
            Spacer()
        }.frame(maxHeight: .infinity)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenNav()
    }
}
