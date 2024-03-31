//
//  Box.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//


final class Box<T> {
    var listener: ((T) -> Void)?
    
    var value: T {
        didSet { listener?(value) }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
