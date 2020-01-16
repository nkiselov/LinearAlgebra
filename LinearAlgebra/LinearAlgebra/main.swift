//
//  main.swift
//  LinearAlgebra
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

let a = Vector([4,4,5])
let b = Vector([1,6,4])
print(Matrix(columns: [a,b])*Matrix(columns: [a,b]))
