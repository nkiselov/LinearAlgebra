//
//  Vector.swift
//  Matrix
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation


public class Vector: CustomStringConvertible{
    
    var elements:[Double]
    
    public var count:Int{
        return elements.count
    }
    
    public var sqrNorm:Double{
        var sqrNorm:Double=0
        for i in 0..<count{
            sqrNorm+=elements[i]*elements[i]
        }
        return sqrNorm
    }
    
    public var norm:Double{
        return sqrt(sqrNorm)
    }
    
    public var mat:Matrix{
        return Matrix(columns: [self])
    }
    
    public var transpose:Matrix{
        return mat.transpose
    }
    
    public var description: String {
        var description = "Vector "+count.description+":"
        for i in 0..<count{
            description.append("\n  "+i.description+": "+elements[i].description)
        }
        return description
    }
    
    public init(_ size:Int){
        elements = Array.init(repeating: 0, count: size)
    }
    
    public init(_ elements:[Double]){
        self.elements = elements
    }
    
    subscript(i:Int)->Double{
        get{
            return elements[i]
        }
        set(v){
            elements[i]=v
        }
    }
    
    public func copy()->Vector{
        return Vector(elements)
    }
    
    public func getElements()->[Double]{
        return elements
    }
}
