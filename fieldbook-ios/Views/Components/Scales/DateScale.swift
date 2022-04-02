//
//  DateScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI

struct DateScale: View {
    @Binding var val: String
    let dateFormatter = DateFormatter()
    
    init(val: Binding<String>) {
        _val = val
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var body: some View {
        VStack (alignment: .center) {
            DatePicker(
                    "",
                    selection: Binding(get: {
                        dateFormatter.date(from:val) ?? Date()
                    }, set: {
                        val = dateFormatter.string(from: $0)
                    }),
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .id(val)
                .datePickerStyle(.compact)
                .padding()
        }
    }
}

struct DateScale_Previews: PreviewProvider {
    static var previews: some View {
        DateScale(val: .constant("2021-01-01"))
    }
}
