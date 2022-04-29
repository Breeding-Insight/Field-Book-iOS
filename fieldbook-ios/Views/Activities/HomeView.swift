//
//  HomeView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/28/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    private let studyDAO = InjectionProvider.getStudyDAO()
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    SwiftUI.Image("fb_icon").padding()
                    Text("Field Book")
                        .font(.largeTitle)
                }.frame(alignment: .top)
                if(appState.currentStudyId != nil) {
                    Text("Current Field: \(self.getCurrentStudy()!.name)")
                } else {
                    Text("No active field")
                }
                Spacer()
                HomeScreenNav()
                Spacer()
                Text("v" + appVersion).frame(maxWidth: .infinity, alignment: .trailing).padding()
            }.frame(maxHeight: .infinity, alignment: .topLeading)
                .navigationBarHidden(true)
                .navigationTitle("Home")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func getCurrentStudy() -> Study? {
        do {
            return try studyDAO.getStudy(appState.currentStudyId!)
        } catch {
            print("error getting current study: \(error.localizedDescription)")
        }
        
        return nil
    }
}
