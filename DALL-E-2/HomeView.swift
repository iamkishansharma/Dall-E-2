//
//  ContentView.swift
//  DALL-E-2
//
//  Created by Kishan Kr Sharma on 1/27/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "person")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("DALL.E 2\npowered by OpenAI").multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
