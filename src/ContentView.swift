//
//  ContentView.swift
//  NasaPhoto
//
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = PhotoInfoViewModel()
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
                case .success(let photoInfo):
                    
                VStack {
                    Text("Astronomy Picture of the Day")
                        .font(.title)
                        .padding()
                    
                    AsyncImage(url: photoInfo.url) {
                        image in
                        
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15.0)
                            .frame(width: 300, height: 200)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(photoInfo.title)
                        .bold()
                        .padding()
                    
                    ScrollView {
                        Text(photoInfo.explanation)
                            .padding()
                    }
                    
                    Text(photoInfo.copyright ?? "No copyright")
                        .padding()
                   
                }
                
                case .loading:
                    ProgressView()
            
                default:
                    EmptyView()
                
            }
        }
        .task {
            await viewModel.getPhotoInfo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
