//
//  ContentView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(Color.primaryFB)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .black
        
        let coloredToolbarAppearance = UIToolbarAppearance()
        coloredToolbarAppearance.configureWithOpaqueBackground()
        coloredToolbarAppearance.backgroundColor = UIColor(Color.primaryFB)
        
        UIToolbar.appearance().standardAppearance = coloredToolbarAppearance
        UIToolbar.appearance().compactAppearance = coloredToolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = coloredToolbarAppearance
        
        UIToolbar.appearance().tintColor = .black
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    SwiftUI.Image("fb_icon").padding()
                    Text("Field Book")
                        .font(.largeTitle)
                }.frame(alignment: .top)
                Text("Current Field: Prosser Fall 2021")
                Spacer()
                HomeScreen()
                Spacer()
                Text("v1.0").frame(maxWidth: .infinity, alignment: .trailing).padding()
            }.frame(maxHeight: .infinity, alignment: .topLeading)
                .navigationBarHidden(true)
                .navigationTitle("Home")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
