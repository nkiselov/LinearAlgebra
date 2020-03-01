//
//  main.swift
//  LinearAlgebra
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation
import simd

let a = Matrix(columns: [Vector([1,3,6]),Vector([-3,-5,-6]),Vector([3,3,4])])
print(a[1..<3,0..<2])
//print(getEigen(a))
//let s = Matrix(columns: getEigenvectors(a))
//print(s*l*s.transpose)
