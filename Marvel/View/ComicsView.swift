//
//  ComicsView.swift
//  Marvel
//
//  Created by COBY_PRO on 2023/07/13.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                if homeData.fetchedComics.isEmpty {
                    
                    ProgressView()
                        .padding(.top, 30)
                }
                else {
                    
                    // Displaying Contents...
                    
                    VStack(spacing: 15) {
                        
                        ForEach(homeData.fetchedComics) { comic in
                            
                            ComicRowView(comic: comic)
                        }
                        
                        // Infinity Scroll Using Geomtry Reader...
                        
                        if homeData.offset == homeData.fetchedComics.count {
                            
                            // showing progress and fetching new data...
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    print("fetching new data....")
                                    homeData.fetchComics() 
                                })
                        }
                        else {
                            
                            GeometryReader { reader -> Color in
                                
                                let minY = reader.frame(in: .global).minY
                                
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                // when it goes over the height triggering update...
                                
                                if !homeData.fetchedComics.isEmpty && minY < height {
                                    
                                    DispatchQueue.main.async {
                                        // setting offset to current fetched comics count...
                                        // so 0 will be now fetched from 20...
                                        // and so on...
                                        homeData.offset = homeData.fetchedComics.count
                                    }
                                }
                                
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.vertical)
                }
            })
            .navigationTitle("Marvel's Comics")
        }
        // Loading Data...
        .onAppear(perform: {
            if homeData.fetchedComics.isEmpty {
                homeData.fetchComics()
            }
        })
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
    }
}

struct ComicRowView: View {

    var comic: Comic
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15) {
            
            WebImage(url: extractImage(data: comic.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(comic.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let description = comic.description {
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                
                // Links....
                HStack(spacing: 10) {
                    
                    ForEach(comic.urls, id: \.self) { data in
                        
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data)),
                            label: {
                                Text(extractURLType(data: data))
                            })
                    }
                }
            })
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    func extractImage(data: [String: String]) -> URL  {
        
        // combining both and forming image...
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String: String]) -> URL {
        
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String: String]) -> String {
        
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
}
