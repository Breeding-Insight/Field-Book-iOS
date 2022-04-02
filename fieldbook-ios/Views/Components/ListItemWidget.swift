//
//  ListItemWidget.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI

struct ListItemWidget: View {
    let rowIcon: String
    let mainText: String
    var secondaryText: String = ""
    var rightIcon: String = ""
    
    var body: some View {
        HStack {
            SwiftUI.Image(systemName: rowIcon).padding(.trailing)
            VStack(alignment: .leading) {
                Text(mainText).fontWeight(.regular)
                if(!secondaryText.isEmpty) {
                    Text(secondaryText).fontWeight(.thin)
                }
            }
            Spacer()
            if(!rightIcon.isEmpty) {
                SwiftUI.Image(systemName: rightIcon)
            }
        }
    }
}

struct ListItemWidget_Previews: PreviewProvider {
    static var previews: some View {
        ListItemWidget(rowIcon: "square.and.arrow.down", mainText: "Default import source")
        ListItemWidget(rowIcon: "square.and.arrow.down", mainText: "Default import source", secondaryText: "No value", rightIcon: "chevron.right"
        )
    }
}
