//
//  SoundsSettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI

struct SoundsSettingsView: View {
    @State private var primarySound = false
    @State private var entryNavSound = false
    @State private var cyclTraitsSound = false
    
    var body: some View {
        List {
            ListItemWidget(rowIcon: "1.square.fill", mainText: "Primary order sound", secondaryText: "Notification sound when the primary order changes", rightIcon: primarySound ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                primarySound = !primarySound
                UserDefaults.standard.set(primarySound, forKey: PreferenceConstants.PRIMARY_ORDER_SOUND)
            }
            ListItemWidget(rowIcon: "play.circle", mainText: "Entry navigation sound", secondaryText: "Notification sound when moving between entries", rightIcon: entryNavSound ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                entryNavSound = !entryNavSound
                UserDefaults.standard.set(entryNavSound, forKey: PreferenceConstants.ENTRY_NAV_SOUND)
            }
            ListItemWidget(rowIcon: "arrow.2.squarepath", mainText: "Cycle traits sound", secondaryText: "Notification sound when traits are completely cycled through", rightIcon: cyclTraitsSound ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                cyclTraitsSound = !cyclTraitsSound
                UserDefaults.standard.set(cyclTraitsSound, forKey: PreferenceConstants.CYCLE_TRAIT_SOUND)
            }
        }.listStyle(.plain).navigationTitle("Sounds").onAppear {
            primarySound = UserDefaults.standard.bool(forKey: PreferenceConstants.PRIMARY_ORDER_SOUND)
            entryNavSound = UserDefaults.standard.bool(forKey: PreferenceConstants.ENTRY_NAV_SOUND)
            cyclTraitsSound = UserDefaults.standard.bool(forKey: PreferenceConstants.CYCLE_TRAIT_SOUND)
        }
    }
}

struct SoundsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsSettingsView()
    }
}
