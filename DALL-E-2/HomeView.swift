//
//  HomeView.swift
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
        VStack {
            Text("AI Image Generator")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text("(Dall-E 2)")
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            if isLoading{
                ProgressView("Generating an image")
                    .tint(Color("icon"))
                    .controlSize(.large)
                    .font(.body)
                    .padding()
                    .background(Color("bg"))
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .foregroundColor(Color("text"))
                
            }else{
                if let image = image{
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/1.8)
                        .padding(10)
                        .background(Color("bg"))
                    
                    Button{
                        print("Downloading...")
                    }label: {
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 25))
                            .aspectRatio( contentMode: .fit)
                            .foregroundColor(Color("icon"))
                            .frame(width: 25, height: 25)
                            .padding(10)
                        
                    }
                    .background(Color("textBox"))
                    .cornerRadius(100)
                    
                    Text("Save to device")
                        .foregroundColor(Color("text"))
                    
                    
                }else{
                    Text(message).foregroundColor(Color("text"))
                }
            }
            
            Spacer()
            
            // Search box and send button
            HStack(alignment: .center, spacing: 10){
                TextField("Type here ...", text: $searchText)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color("textBox"))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100, style: .continuous)
                        .stroke(.gray.opacity(0.6), lineWidth: 1.5))
                
                Button{
                    let grab = searchText
                    if !grab.trimmingCharacters(in: .whitespaces).isEmpty{
                        self.isLoading = true
                        Task{
                            let result = await viewModel.generateImage(prompt: grab)
                            
                            self.isLoading = false
                            
                            if result == nil {
                                print("Failed to get an Image")
                                self.message = "Failed to generate an image!"
                            }
                            self.image = result
                        }
                        self.searchText = ""
                    }else{
                        self.message = "Type something to generate an image."
                    }
                }label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                        .foregroundColor(Color("textBox"))
                        .padding(5)
                        .background(Color("icon"))
                        .cornerRadius(100)
                }
            }.padding(.horizontal, 16)
        }
        .background(Color("bg"))
        .onAppear{
            viewModel.setup()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
