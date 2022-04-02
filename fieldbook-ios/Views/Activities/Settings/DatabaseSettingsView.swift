//
//  DatabaseSettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI

struct DatabaseSettingsView: View {
    var body: some View {
        List {
            ListItemWidget(rowIcon: "square.and.arrow.down", mainText: "Import database"
            )
            ListItemWidget(rowIcon: "square.and.arrow.up", mainText: "Export database"
            )
            ListItemWidget(rowIcon: "trash.fill", mainText: "Delete database"
            )
        }.listStyle(.plain).navigationTitle("Database")
    }
}

struct DatabaseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseSettingsView()
    }
}
