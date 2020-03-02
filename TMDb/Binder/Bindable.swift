//
//  Bindable.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 19/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

class Bindable<T>{
    typealias Listener = (T)->()
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    /// initialises the Bindable object with value
    /// - Parameter val: value to be set for *value* property  of *Bindable* object
    init(_ val: T) {
        value = val
    }
    /// binds the passed listener to the class  listener property
    /// - Parameter listener: closure  of the type (T)->()
    func bind(_ listener: Listener?){
        self.listener = listener
    }
}
