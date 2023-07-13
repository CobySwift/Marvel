//
//  WebView.swift
//  Marvel
//
//  Created by COBY_PRO on 2023/07/13.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
