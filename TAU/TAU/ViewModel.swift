//
//  ViewModel.swift
//  TAU
//
//  Created by Ganesh Raju Galla on 06/02/23.
//

import Foundation
import SwiftUI
import OpenAISwift

class ViewModel:ObservableObject{
    init() {}
    
    var openAI: OpenAISwift?
    
    enum MessageType{
        case Text,Error
    }
    
    func setUp(){
        openAI = OpenAISwift(authToken: "Your Api Key Here")
    }
    
    func send(text:String,completion:@escaping((String,MessageType) -> Void)){
        openAI?.sendCompletion(with: text,maxTokens: 500, completionHandler: { result in
            switch result{
            case .success(let modal):
                let output = modal.choices.first?.text ?? ""
                let messageType:MessageType = .Text
                completion(output,messageType)
            case .failure(let error):
                let output = error.localizedDescription
                let messageType:MessageType = .Error
                completion(output,messageType)
            }
        })
    }
    
}
