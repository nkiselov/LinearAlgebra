//
//  Vector.swift
//  Matrix
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

func *(lhs: Vector, rhs: Vector) -> Double {
    if(!(lhs.count==rhs.count)){
        fatalError("Can't apply dot product to different sized vectors")
    }
    var product:Double = 0
    for i in 0..<lhs.count{
        product += lhs.elements[i]*rhs.elements[i]
    }
    return product
}

infix operator **:MultiplicationPrecedence
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

func +(lhs: Vector, rhs:Vector)->Vector{
    if(!(lhs.count==rhs.count)){
        fatalError("Can't add different sized vectors")
    }
    let res = Vector(lhs.count)
    for i in 0..<lhs.count{
        res.set(i, lhs.get(i)+rhs.get(i))
    }
    return res
}

func -(lhs: Vector, rhs:Vector)->Vector{
    if(!(lhs.count==rhs.count)){
        fatalError("Can't subtract different sized vectors")
    }
    let res = Vector(lhs.count)
    for i in 0..<lhs.count{
        res.set(i, lhs.get(i)-rhs.get(i))
    }
    return res
}

func *(lhs: Vector, rhs: Double) -> Vector {
    let product:Vector = Vector(lhs.count)
    for i in 0..<lhs.count{
        product.set(i,lhs.elements[i]*rhs)
    }
    return product
}

func *(lhs: Double, rhs: Vector) -> Vector {
    let product:Vector = Vector(rhs.count)
    for i in 0..<rhs.count{
        product.set(i,rhs.elements[i]*lhs)
    }
    return product
}

func /(lhs: Vector, rhs: Double) -> Vector {
    let product:Vector = Vector(lhs.count)
    for i in 0..<lhs.count{
        product.set(i,lhs.elements[i]/rhs)
    }
    return product
}
    
class Vector: CustomStringConvertible{
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
    
    init(_ size:Int){
        elements = Array.init(repeating: 0, count: size)
    }
    
    init(_ elements:[Double]){
        self.elements = elements
    }
    
    public func get(_ i:Int)->Double{
        return elements[i]
    }
    
    public func set(_ i:Int, _ v:Double){
        elements[i]=v
    }
    
    public func copy()->Vector{
        return Vector(elements)
    }
}
