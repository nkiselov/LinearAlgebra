//
//  MEquation.swift
//  LinearAlgebra
//
//  Created by Nikita on 21.01.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

protocol MEquation {
    func evaluate(_ x:Vector)->Vector
    var inAmount:Int { get }
    var outAmount:Int { get }
}
