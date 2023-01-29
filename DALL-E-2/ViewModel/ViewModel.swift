//
//  ViewModel.swift
//  DALL-E-2
//
//  Created by Kishan Kr Sharma on 1/29/23.
//

import Foundation
import OpenAIKit
import UIKit

final class MyViewModel : ObservableObject{
    private var openAi: OpenAI?
    
    func setup(){
        // initiate the client
        openAi = OpenAI(
            Configuration(
                organization: "Personal",
                apiKey: "YOUR_OPENAI_API_KEY"
            )
        )
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        // make sure we've our client ready
        guard let openAi = openAi else {return nil}
        
        do{
            // create generated image configuration
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            //
            let result =  try await openAi.createImage(parameters: params)
            
            // grab the first image data
            let data = result.data[0].image
            // decode image from base64
            let image = try openAi.decodeBase64Image(data)

            return image
        }
        catch{
            print(String(describing: error))
            return nil
        }
    }
}
