//
//  ContentView.swift
//  DALL-E-2
//
//  Created by Kishan Kr Sharma on 1/27/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = MyViewModel()
    @State var searchText: String = ""
    @State var message: String = "Type to generate an image!"
    @State var image: UIImage?
    @State var isLoading = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                
                if isLoading{
                    Text("Loading...")
                        .font(.body)
                        .fontWeight(.semibold)
        
                }else{
                    if let image = image{
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/1.8)
                            .padding(10)
                            .background(Color.white)
                        
                    }else{
                        Text(message)
                    }
                }
                Spacer()
                
                HStack(alignment: .center, spacing: 2){
                                Button{
                                    print("regenerate")
                                }label: {
                                    Image(systemName: "camera")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color("icon"))
                                }
                                .padding(5)
                                .cornerRadius(100)
                                TextField("Type here ...", text: $searchText)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .background(Color("textBox"))
                                    .cornerRadius(100)
                                    .background(RoundedRectangle(cornerRadius: 100, style: .continuous)
                                        .stroke(.gray.opacity(0.6), lineWidth: 1.5))
                                
                                Button{
                                    
                                    self.isLoading = true
                                    if !searchText.trimmingCharacters(in: .whitespaces).isEmpty{
                                        Task{
                                            let result = await viewModel.generateImage(prompt: searchText)
                                            
                                            self.isLoading = false
                                            
                                            if result == nil {
                                                print("Failed to get an Image")
                                                self.message = "Failed to generate an image!"
                                            }
                                            
                                            self.image = result
                                            
                                        }
                                    }
                                }label: {
                                    Image(systemName: "paperplane")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color("icon"))
                                }
                                .padding(5)
                                .cornerRadius(100)
                }
            }
                .onAppear{
                    viewModel.setup()
                }
            .navigationTitle("Dall-E 2")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarHidden(true)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
