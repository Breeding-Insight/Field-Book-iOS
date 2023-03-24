//
//  DateScale.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/16/21.
//

import SwiftUI

struct DateScale: View {
    @Binding var val: String
    
    init(val: Binding<String>) {
        _val = val
    }
    
    var body: some View {
        HStack (alignment: .top) {
            DatePickerPopover(dateVal: $val)
        }
    }
}

struct DatePickerPopover: View {
    @State var showingPicker = false
    @State var oldDate: Date = Date()
    @Binding var dateVal: String
    private let dateFormatter = DateFormatter()
    
    init(showingPicker: Bool = false, oldDate: Date = Date(), dateVal: Binding<String>) {
        _dateVal = dateVal
        self.showingPicker = showingPicker
        self.oldDate = oldDate
        
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var body: some View {
        Text(dateVal == "" ? "Select Date" : dateVal)
            .foregroundColor(.accentColor)
            .onTapGesture {
                showingPicker.toggle()
            }
            .popover(isPresented: $showingPicker, attachmentAnchor: .point(.center)) {
                NavigationView {
                    VStack {
                        DatePicker(selection: Binding(get: {
                            dateFormatter.date(from:dateVal) ?? Date()
                        }, set: {
                            dateVal = dateFormatter.string(from: $0)
                        }), displayedComponents: [.date]){
                            
                        }
                                   .datePickerStyle(.graphical)
                                   .toolbar {
                                       ToolbarItem(placement: .cancellationAction) {
                                           Button("Cancel") {
                                               dateVal = dateFormatter.string(from: oldDate)
                                               showingPicker = false
                                           }
                                       }
                                       ToolbarItem(placement: .confirmationAction) {
                                           Button("Done") {
                                               dateVal = dateFormatter.string(from: (dateFormatter.date(from:dateVal) ?? Date()))
                                               showingPicker = false
                                           }
                                       }
                                   }
                        Spacer()
                    }
                }
            }
            .onAppear {
                oldDate = dateFormatter.date(from:dateVal) ?? Date()
            }
    }
}

struct DateScale_Previews: PreviewProvider {
    static var previews: some View {
        DateScale(val: .constant("2021-01-01"))
    }
}
