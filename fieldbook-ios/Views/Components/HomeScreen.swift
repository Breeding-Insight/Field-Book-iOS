//
//  HomeScreenWidget.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/5/21.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selection: String? = nil

    var body: some View {
        VStack {
            HStack {
                Spacer()
                HomeScreenWidget(icon: "fields", label: "Fields", destination: AnyView(FieldListView()), selection: $selection)
                Spacer()
                HomeScreenWidget(icon: "traits", label: "Traits", destination: AnyView(TraitListView()), selection: $selection)
                Spacer()
            }.padding(.bottom).padding(.top)
            HStack {
                Spacer()
                HomeScreenWidget(icon: "create", label: "Collect", destination: AnyView(Text("View Fields")), selection: $selection)
                Spacer()
                HomeScreenWidget(icon: "save", label: "Export", destination: AnyView(Text("View Fields")), selection: $selection)
                Spacer()
            }.padding(.bottom).padding(.top)
            HStack {
                Spacer()
                HomeScreenWidget(icon: "settings", label: "Settings", destination: AnyView(Text("View Fields")), selection: $selection)
                Spacer()
                HomeScreenWidget(icon: "info", label: "About", destination: AnyView(Text("View About")), selection: $selection)
                Spacer()
            }.padding(.bottom).padding(.top)
                .frame(maxWidth: .infinity)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
