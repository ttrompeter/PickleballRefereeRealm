//
//  ScreenshotMakerView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/8/22.
//

import SwiftUI
import UIKit

typealias ScreenshotMakerClosure = (ScreenshotMaker) -> Void

struct ScreenshotMakerView: UIViewRepresentable {
    let closure: ScreenshotMakerClosure
    
    init(_ closure: @escaping ScreenshotMakerClosure) {
        self.closure = closure
    }
    
    func makeUIView(context: Context) -> ScreenshotMaker {
        let view = ScreenshotMaker(frame: CGRect.zero)
        return view
    }
    
    func updateUIView(_ uiView: ScreenshotMaker, context: Context) {
        DispatchQueue.main.async {
            closure(uiView)
        }
    }
}
