//
//  BrAPISettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI
import RadioGroup

struct BrAPISettingsView: View {
    private let brapiVersionSources = ["v1", "v2"]
    private let oidcFlowSources = ["OIDC Implicit Flow", "Original Field Book Custom"]
    private let valueLabelSources = ["Value", "Label"]
    
    @State private var showingBrapiUrlSheet = false
    @State private var brapiUrl = ""
    func setBrapiUrl() -> Void {
        brapiUrl = UserDefaults.standard.string(forKey: PreferenceConstants.BRAPI_URL) ?? "https://test-server.brapi.org"
    }
    
    @State private var showingBrapiVersionSheet = false
    @State private var brapiVersion = 1 //0 based index
    func setBrapiVersion() -> Void {
        let storedBrapiVersion = UserDefaults.standard.integer(forKey:PreferenceConstants.BRAPI_VERSION)
        
        brapiVersion = storedBrapiVersion == 0 ? 1 : storedBrapiVersion - 1
    }
    
    @State private var showingPageSizeSheet = false
    @State private var pageSize = "1000"
    func setPageSize() -> Void {
        pageSize = UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_PAGE_SIZE) ?? "1000"
    }
    
    @State private var showingTimeoutSheet = false
    @State private var timeout = "120"
    func setTimeout() -> Void {
        timeout = UserDefaults.standard.string(forKey:PreferenceConstants.BRAPI_TIMEOUT) ?? "120"
    }
    
    @State private var showingOidcFlowSheet = false
    @State private var oidcFlow = 0
    func setOidcFlow() -> Void {
        oidcFlow = UserDefaults.standard.integer(forKey:PreferenceConstants.BRAPI_OIDC_FLOW)
    }
    
    @State private var showingOidcUrlSheet = false
    @State private var oidcUrl = "https://test-server.brapi.org/.well-known/openid-configuration"
    func setOidcUrl() -> Void {
        oidcUrl = UserDefaults.standard.string(forKey: PreferenceConstants.BRAPI_OIDC_URL) ?? "https://test-server.brapi.org/.well-known/openid-configuration"
    }
    
    @State private var showingValueLabelSheet = false
    @State private var valueLabelDisplay = 0
    func setValueLabelDisplay() -> Void {
        valueLabelDisplay = UserDefaults.standard.integer(forKey:PreferenceConstants.BRAPI_LABEL_DISPLAY)
    }
    
    var body: some View {
        List {
            Section(header: Text("Configuration")) {
                ListItemWidget(rowIcon: "link", mainText: "Base URL", secondaryText: brapiUrl, rightIcon: "chevron.right"
                ).onTapGesture {showingBrapiUrlSheet = true}
                .sheet(isPresented: $showingBrapiUrlSheet) {
                    NavigationView {
                        VStack {
                            TextField("BrAPI URL", text: $brapiUrl).disableAutocorrection(true)
                            
                            Button("Done") {
                                UserDefaults.standard.set(brapiUrl, forKey: PreferenceConstants.BRAPI_URL)
                                showingBrapiUrlSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Set BrAPI URL"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setBrapiUrl()
                                showingBrapiUrlSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
                ListItemWidget(rowIcon: "globe", mainText: "Authorize"
                )
                ListItemWidget(rowIcon: "v.square", mainText: "BrAPI Version", secondaryText: "V\(brapiVersion + 1)", rightIcon: "chevron.right"
                ).onTapGesture {showingBrapiVersionSheet = true}
                .sheet(isPresented: $showingBrapiVersionSheet) {
                    NavigationView {
                        VStack {
                            RadioGroupPicker(selectedIndex: $brapiVersion, titles: brapiVersionSources)
                                .selectedColor(.black)
                                .itemSpacing(15)
                                .titleColor(.black)
                                .titleAlignment(.right)
                                .fixedSize()
                                .padding(8)
                                .accentColor(.black)
                            
                            Button("Done") {
                                UserDefaults.standard.set(brapiVersion + 1, forKey: PreferenceConstants.BRAPI_VERSION)
                                showingBrapiVersionSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Set BrAPI Version"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setBrapiVersion()
                                showingBrapiVersionSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
                ListItemWidget(rowIcon: "square.stack.3d.up.fill", mainText: "Page Size", secondaryText: pageSize, rightIcon: "chevron.right"
                ).onTapGesture {showingPageSizeSheet = true}
                .sheet(isPresented: $showingPageSizeSheet) {
                    NavigationView {
                        VStack {
                            TextField("Page Size", text: $pageSize).keyboardType(.decimalPad).disableAutocorrection(true)
                            
                            Button("Done") {
                                UserDefaults.standard.set(pageSize, forKey: PreferenceConstants.BRAPI_PAGE_SIZE)
                                showingPageSizeSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Set Page Size"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setPageSize()
                                showingPageSizeSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
                ListItemWidget(rowIcon: "stopwatch", mainText: "Server Timeout", secondaryText: "\(timeout)s", rightIcon: "chevron.right"
                ).onTapGesture {showingTimeoutSheet = true}
                .sheet(isPresented: $showingTimeoutSheet) {
                    NavigationView {
                        VStack {
                            TextField("Timeout", text: $timeout).keyboardType(.decimalPad).disableAutocorrection(true)
                            
                            Button("Done") {
                                UserDefaults.standard.set(timeout, forKey: PreferenceConstants.BRAPI_TIMEOUT)
                                showingTimeoutSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Set Request Timeout"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setTimeout()
                                showingTimeoutSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
            }
            Section(header: Text("Advanced Auth Settings")) {
                ListItemWidget(rowIcon: "v.square", mainText: "OIDC Flow", secondaryText: oidcFlowSources[oidcFlow], rightIcon: "chevron.right"
                ).onTapGesture {showingOidcFlowSheet = true}
                .sheet(isPresented: $showingOidcFlowSheet) {
                    NavigationView {
                        VStack {
                            RadioGroupPicker(selectedIndex: $oidcFlow, titles: oidcFlowSources)
                                .selectedColor(.black)
                                .itemSpacing(15)
                                .titleColor(.black)
                                .titleAlignment(.right)
                                .fixedSize()
                                .padding(8)
                                .accentColor(.black)
                            
                            Button("Done") {
                                UserDefaults.standard.set(oidcFlow, forKey: PreferenceConstants.BRAPI_OIDC_FLOW)
                                showingOidcFlowSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Set OIDC Flow"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setOidcFlow()
                                showingOidcFlowSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
                ListItemWidget(rowIcon: "link", mainText: "OIDC Discovery URL", secondaryText: "The location of the OIDC Discovery JSON document", rightIcon: "chevron.right"
                ).onTapGesture {showingOidcUrlSheet = true}
                .sheet(isPresented: $showingOidcUrlSheet) {
                    NavigationView {
                        VStack {
                            TextField("OIDC URL", text: $oidcUrl).disableAutocorrection(true)
                            
                            Button("Done") {
                                UserDefaults.standard.set(oidcUrl, forKey: PreferenceConstants.BRAPI_OIDC_URL)
                                showingOidcUrlSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Set OIDC URL"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setOidcUrl()
                                showingOidcUrlSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
            }
            Section(header: Text("BrAPI Variables")) {
                ListItemWidget(rowIcon: "rectangle.split.3x3", mainText: "Value vs Label Display", secondaryText: "Display values or labels on the collect screen", rightIcon: "chevron.right"
                ).onTapGesture {showingValueLabelSheet = true}
                .sheet(isPresented: $showingValueLabelSheet) {
                    NavigationView {
                        VStack {
                            RadioGroupPicker(selectedIndex: $valueLabelDisplay, titles: valueLabelSources)
                                .selectedColor(.black)
                                .itemSpacing(15)
                                .titleColor(.black)
                                .titleAlignment(.right)
                                .fixedSize()
                                .padding(8)
                                .accentColor(.black)
                            
                            Button("Done") {
                                UserDefaults.standard.set(valueLabelDisplay, forKey: PreferenceConstants.BRAPI_LABEL_DISPLAY)
                                showingValueLabelSheet = false
                            }.padding(.top)
                            Spacer()
                        }.padding()
                            .navigationBarTitle(Text("Value vs Label Display"), displayMode: .inline)
                            .navigationBarItems(leading: Button(action: {
                                setValueLabelDisplay()
                                showingValueLabelSheet = false
                            }) {
                                Text("Cancel").bold()
                            })
                    }
                }
            }
            Section(header: Text("Community Servers")) {
                ListItemWidget(rowIcon: "barcode.viewfinder", mainText: "Scan a server barcode"
                )
            }
        }.listStyle(.plain).navigationTitle("Breeding API").onAppear {
            setBrapiUrl()
            setBrapiVersion()
            setPageSize()
            setTimeout()
            setOidcFlow()
            setOidcUrl()
            setValueLabelDisplay()
        }
    }
}

struct BrAPISettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BrAPISettingsView()
    }
}
