//
//  Vector.swift
//  Matrix
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

precedencegroup VectorProduct {
    lowerThan: BitwiseShiftPrecedence
    higherThan: MultiplicationPrecedence
    associativity: left
    assignment: false
}

infix operator *:VectorProduct
func *(lhs: Vector, rhs: Vector) -> Double {
    if(!(lhs.count==rhs.count)){
        fatalError("Can't apply dot product to different sized vectors")
    }
    var product:Double = 0
    for i in 0..<lhs.count{
        product += lhs.components[i]*rhs.components[i]
    }
    return product
}

infix operator **:VectorProduct
func **(lhs: Vector, rhs: Vector) -> Vector {
    if(!(lhs.count==3 && rhs.count==3)){
        fatalError("Can't apply cross product to not 3 sized vectors")
    }
    return Vector([
        lhs.get(1)*rhs.get(2)-lhs.get(2)*rhs.get(1),
        lhs.get(2)*rhs.get(0)-lhs.get(0)*rhs.get(2),
        lhs.get(0)*rhs.get(1)-lhs.get(1)*rhs.get(0)
    ])
}
    
class Vector: CustomStringConvertible{
    var components:[Double]
    public var count:Int{
        return components.count
    }
    public var description: String {
        var description = "Vector "+count.description+":"
        for i in 0..<count{
            description += "\n  "+i.description+": "+components[i].description
        }
        return description
    }
    
    init(_ size:Int){
        components = Array.init(repeating: 0, count: size)
    }
    
    init(_ components:[Double]){
        self.components = components
    }
    
    func get(_ i:Int)->Double{
        return components[i]
    }
    
    func set(_ i:Int, _ v:Double){
        components[i]=v
    }
}
