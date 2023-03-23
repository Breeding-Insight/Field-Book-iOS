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
    let disabled: Bool
    @Binding var selection: String?
    
    private func getColor() -> Color{
        if self.disabled {
            return Color.gray
        }
        
        return Color.black
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: destination, tag: self.label, selection: $selection) { EmptyView() }
            ZStack {
                Circle()
                    .strokeBorder(.clear)
                    .background(Circle().fill(.white))
                    .shadow(radius: 1)
                    .frame(width: 75, height: 75)
                SwiftUI.Image(self.icon)
                    .renderingMode(.template)
                    .foregroundColor(self.getColor())
                    .frame(width: 50, height: 50)
            }
            Text(self.label).foregroundColor(self.getColor())
        }
        .onTapGesture {
            self.selection = self.label
        }
    }
}

struct HomeScreenWidget_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenNavItem(icon: "fields", label: "Fields", destination: AnyView(Text("View Fields")), disabled: false, selection: .constant("Fields"))
        HomeScreenNavItem(icon: "fields", label: "Fields", destination: AnyView(Text("View Fields")), disabled: true, selection: .constant("Fields"))
    }
}
