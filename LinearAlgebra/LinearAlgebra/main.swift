//
//  main.swift
//  LinearAlgebra
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation
import simd

let a = Vector([1,3,2])
let b = Vector([1,6,-1])

class Test:MEquation{
    func evaluate(_ x: Vector) -> Vector {
        return Vector([a*x,b*x])
    }
    
    var inAmount: Int=3
    
    var outAmount: Int=2
    
    
}
let solution = MESolver.solve(mEquation: Test(), start: Vector([1,1,1]))
print(solution)
print(solution*a)
print(solution*b)
print(solution.sqrDst)
