//
//  Dynamic.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import Foundation

class Boxing<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
