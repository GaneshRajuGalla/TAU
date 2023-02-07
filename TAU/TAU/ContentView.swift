//
//  ContentView.swift
//  TAU
//
//  Created by Ganesh Raju Galla on 06/02/23.
//

import SwiftUI
import OpenAISwift

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var text = ""
    @State private var models = [String] ()
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                ScrollView{
                    LazyVStack(alignment: .leading) {
                        ForEach(models,id: \.self){ string in
                            Text(string)
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                        }
                    }
                }
                Spacer()
                HStack{
                    TextField("Ask Your Question..", text: $text)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                    Button {
                        sendQuestion()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .rotationEffect(.degrees(45))
                            .font(.system(size:36))
                    }
                }
            }
            .onAppear{
                withAnimation(.spring()){
                    viewModel.setUp()
                }
            }
            .navigationTitle("TAU")
            .padding(.horizontal)
        }
    }
    
    func sendQuestion(){
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        models.append("Me: \(text)")
        viewModel.send(text: text) { response, messageType in
            DispatchQueue.main.async {
                models.append("ChatGpt:"+response)
                self.text = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
