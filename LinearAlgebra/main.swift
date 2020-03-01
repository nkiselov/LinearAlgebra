//
//  main.swift
//  LinearAlgebra
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation


//let a = Matrix(columns: [Vector([2,-1,-1,0]),Vector([-1,3,-1,-1]),Vector([-1,-1,3,-1]),Vector([0,-1,-1,2])])
let a = Matrix(columns: [Vector([1,3,6]),Vector([-3,-5,-6]),Vector([3,3,4])])
print(getEigen(a))
