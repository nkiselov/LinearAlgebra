//
//  main.swift
//  LinearAlgebra
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation


//let a = Matrix(columns: [Vector([2,-1,-1,0]),Vector([-1,3,-1,-1]),Vector([-1,-1,3,-1]),Vector([0,-1,-1,2])])
let a = [Vector([1,3,8]),Vector([-3,-5,-6]),Vector([-2,-2,3])]
let p = Matrix(columns: a)
print(p)
let m = getPCAMatrix(a, 2)
print(m)
let simplified = m*p
print(simplified)
let back = m.transpose*simplified
print(back)
