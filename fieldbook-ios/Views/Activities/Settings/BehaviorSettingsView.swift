//
//  BehaviorSettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI
import RadioGroup

struct BehaviorSettingsView: View {
    private let returnSignalSources = ["Next Plot", "Next Trait", "Do Nothing"]
    private let disableEntrySources = ["Neither", "Left", "Right", "Both"]
    private let skipEntriesSources = ["Disabled", "Skip entries across active trait", "Skip entries across all traits"]
    
    @State private var cycleTraits = false
    @State private var mapVolume = false
    @State private var showingReturnKeySheet = false
    @State private var returnKey = 0
    @State private var showingDisableEntrySheet = false
    @State private var disableEntry = 0
    @State private var disableShare = false
    @State private var dayOfYear = false
    @State private var showingSkipEntriesSheet = false
    @State private var skipEntries = 0
    @State private var flipArrows = false;
    
    var body: some View {
        List {
            ListItemWidget(rowIcon: "arrow.2.squarepath", mainText: "Cycling traits advances entry", secondaryText: "After going through all traits, Field Book goes to the next entry", rightIcon: cycleTraits ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                cycleTraits = !cycleTraits
                UserDefaults.standard.set(cycleTraits, forKey: PreferenceConstants.CYCLE_ADVANCE_ENTRY)
            }
            ListItemWidget(rowIcon: "plus.forwardslash.minus", mainText: "Map volume keys to entry nav", secondaryText: "Volume keys go to next or previous entry", rightIcon: mapVolume ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                mapVolume = !mapVolume
                UserDefaults.standard.set(mapVolume, forKey: PreferenceConstants.VOLUME_ENTRY_NAV)
            }
            ListItemWidget(rowIcon: "arrow.turn.down.left", mainText: "Return key signal", secondaryText: returnSignalSources[returnKey], rightIcon: "chevron.right"
            ).onTapGesture {showingReturnKeySheet = true}
            .sheet(isPresented: $showingReturnKeySheet) {
                NavigationView {
                    VStack {
                        RadioGroupPicker(selectedIndex: $returnKey, titles: returnSignalSources)
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        
                        Button("Done") {
                            UserDefaults.standard.set(returnKey, forKey: PreferenceConstants.RETURN_KEY_NAV)
                            showingReturnKeySheet = false
                        }.padding(.top)
                        Spacer()
                    }.padding()
                        .navigationBarTitle(Text("Set Return Key Signal"), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            returnKey = UserDefaults.standard.integer(forKey:PreferenceConstants.RETURN_KEY_NAV)
                            showingReturnKeySheet = false
                        }) {
                            Text("Cancel").bold()
                        })
                }
            }
            ListItemWidget(rowIcon: "arrow.left.and.right", mainText: "Disable entry navigation if no data", secondaryText: disableEntrySources[disableEntry], rightIcon: "chevron.right"
            ).onTapGesture {showingDisableEntrySheet = true}
            .sheet(isPresented: $showingDisableEntrySheet) {
                NavigationView {
                    VStack {
                        RadioGroupPicker(selectedIndex: $disableEntry, titles: disableEntrySources)
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        
                        Button("Done") {
                            UserDefaults.standard.set(disableEntry, forKey: PreferenceConstants.DISABLE_ENTRY_NO_DATA)
                            showingDisableEntrySheet = false
                        }.padding(.top)
                        Spacer()
                    }.padding()
                        .navigationBarTitle(Text("Disable Entry Navigation If No Data"), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            disableEntry = UserDefaults.standard.integer(forKey:PreferenceConstants.DISABLE_ENTRY_NO_DATA)
                            showingDisableEntrySheet = false
                        }) {
                            Text("Cancel").bold()
                        })
                }
            }
            ListItemWidget(rowIcon: "icloud.slash", mainText: "Disabled file sharing", secondaryText: "When files are exported, the share dialog will not be displayed", rightIcon: disableShare ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                disableShare = !disableShare
                UserDefaults.standard.set(disableShare, forKey: PreferenceConstants.DISABLE_FILE_SHARE)
            }
            ListItemWidget(rowIcon: "calendar", mainText: "Use day of year", secondaryText: "Use day of year when collecting data instead of the date", rightIcon: dayOfYear ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                dayOfYear = !dayOfYear
                UserDefaults.standard.set(dayOfYear, forKey: PreferenceConstants.DAY_OF_YEAR)
            }
            ListItemWidget(rowIcon: "eye.slash.fill", mainText: "Skip entries across active trait", secondaryText: skipEntriesSources[skipEntries], rightIcon: "chevron.right"
            ).onTapGesture {showingSkipEntriesSheet = true}
            .sheet(isPresented: $showingSkipEntriesSheet) {
                NavigationView {
                    VStack {
                        RadioGroupPicker(selectedIndex: $skipEntries, titles: skipEntriesSources)
                            .selectedColor(.black)
                            .itemSpacing(15)
                            .titleColor(.black)
                            .titleAlignment(.right)
                            .fixedSize()
                            .padding(8)
                            .accentColor(.black)
                        
                        Button("Done") {
                            UserDefaults.standard.set(skipEntries, forKey: PreferenceConstants.SKIP_ENTRIES)
                            showingSkipEntriesSheet = false
                        }.padding(.top)
                        Spacer()
                    }.padding()
                        .navigationBarTitle(Text("Skip entries across active trait"), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            skipEntries = UserDefaults.standard.integer(forKey:PreferenceConstants.SKIP_ENTRIES)
                            showingSkipEntriesSheet = false
                        }) {
                            Text("Cancel").bold()
                        })
                }
            }
            ListItemWidget(rowIcon: "hand.tap", mainText: "Flip Flop Arrows", secondaryText: "Swap the trait and plot arrow functions", rightIcon: flipArrows ? "checkmark.square.fill" : "square"
            ).onTapGesture {
                flipArrows = !flipArrows
                UserDefaults.standard.set(flipArrows, forKey: PreferenceConstants.FLIP_ARROWS)
            }
        }.listStyle(.plain).navigationTitle("Behavior").onAppear {
            setCheckboxes()
            setReturnKey()
            setDisableSources()
            setSkipEntries()
        }
    }
    
    func setCheckboxes() -> Void {
        cycleTraits = UserDefaults.standard.bool(forKey: PreferenceConstants.CYCLE_ADVANCE_ENTRY)
        mapVolume = UserDefaults.standard.bool(forKey: PreferenceConstants.VOLUME_ENTRY_NAV)
        disableShare = UserDefaults.standard.bool(forKey: PreferenceConstants.DISABLE_FILE_SHARE)
        dayOfYear = UserDefaults.standard.bool(forKey: PreferenceConstants.DAY_OF_YEAR)
        flipArrows = UserDefaults.standard.bool(forKey: PreferenceConstants.FLIP_ARROWS);
    }
    func setReturnKey() -> Void {
        returnKey = UserDefaults.standard.integer(forKey: PreferenceConstants.RETURN_KEY_NAV)
    }
    func setDisableSources() -> Void {
        disableEntry = UserDefaults.standard.integer(forKey: PreferenceConstants.DISABLE_ENTRY_NO_DATA)
    }
    func setSkipEntries() -> Void {
        skipEntries = UserDefaults.standard.integer(forKey: PreferenceConstants.SKIP_ENTRIES)
    }
}

struct BehaviorSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BehaviorSettingsView()
    }
}
