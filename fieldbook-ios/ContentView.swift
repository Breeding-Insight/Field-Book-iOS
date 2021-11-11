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
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Image("fb_icon").padding()
                    Text("Field Book")
                        .font(.largeTitle)
                }.frame(alignment: .top)
                Spacer()
                HomeScreen()
                Spacer()
                Text("v5.1").frame(maxWidth: .infinity, alignment: .trailing).padding()
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
