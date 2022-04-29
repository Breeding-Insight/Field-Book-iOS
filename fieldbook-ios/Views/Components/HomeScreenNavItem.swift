//
//  HomeScreenWidget.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/9/21.
//

import SwiftUI

struct HomeScreenNavItem: View {
    let icon: String
    let label: String
    let destination: AnyView
    @Binding var selection: String?
    
    var body: some View {
        VStack {
            NavigationLink(destination: destination, tag: self.label, selection: $selection) { EmptyView() }
            ZStack {
                Circle()
//                    .fill(Color.primaryFB)
                    .fill(Color.white)
                    .shadow(radius: 1)
                    .frame(width: 75, height: 75)
                SwiftUI.Image(self.icon)
                    .frame(width: 50, height: 50)
            }
            Text(self.label)
        }
        .onTapGesture {
            self.selection = self.label
        }
    }
}

struct HomeScreenWidget_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenNavItem(icon: "fields", label: "Fields", destination: AnyView(Text("View Fields")), selection: .constant("Fields"))
    }
}
