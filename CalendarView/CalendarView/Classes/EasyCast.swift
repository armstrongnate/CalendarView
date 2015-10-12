// EasyCast.swift
// 
// Copyright (c) 2014 Jameson Quave
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import CoreGraphics

func -(lhs: Int, rhs: Float) -> Float {
    return Float(lhs) - Float(rhs)
}
func +(lhs: Int, rhs: Float) -> Float {
    return Float(lhs) + Float(rhs)
}
func /(lhs: Int, rhs: Float) -> Float {
    return Float(lhs) / Float(rhs)
}
func *(lhs: Int, rhs: Float) -> Float {
    return Float(lhs) * Float(rhs)
}
func -(lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) - CGFloat(rhs)
}
func +(lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) + CGFloat(rhs)
}
func /(lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) / CGFloat(rhs)
}
func *(lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * CGFloat(rhs)
}
func -(lhs: Float, rhs: Int) -> Float {
    return Float(lhs) - Float(rhs)
}
func +(lhs: Float, rhs: Int) -> Float {
    return Float(lhs) + Float(rhs)
}
func /(lhs: Float, rhs: Int) -> Float {
    return Float(lhs) / Float(rhs)
}
func *(lhs: Float, rhs: Int) -> Float {
    return Float(lhs) * Float(rhs)
}
func -(lhs: Float, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) - CGFloat(rhs)
}
func +(lhs: Float, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) + CGFloat(rhs)
}
func /(lhs: Float, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) / CGFloat(rhs)
}
func *(lhs: Float, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * CGFloat(rhs)
}
func -(lhs: CGFloat, rhs: Int) -> CGFloat {
    return CGFloat(lhs) - CGFloat(rhs)
}
func +(lhs: CGFloat, rhs: Int) -> CGFloat {
    return CGFloat(lhs) + CGFloat(rhs)
}
func /(lhs: CGFloat, rhs: Int) -> CGFloat {
    return CGFloat(lhs) / CGFloat(rhs)
}
func *(lhs: CGFloat, rhs: Int) -> CGFloat {
    return CGFloat(lhs) * CGFloat(rhs)
}
func -(lhs: CGFloat, rhs: Float) -> CGFloat {
    return CGFloat(lhs) - CGFloat(rhs)
}
func +(lhs: CGFloat, rhs: Float) -> CGFloat {
    return CGFloat(lhs) + CGFloat(rhs)
}
func /(lhs: CGFloat, rhs: Float) -> CGFloat {
    return CGFloat(lhs) / CGFloat(rhs)
}
func *(lhs: CGFloat, rhs: Float) -> CGFloat {
    return CGFloat(lhs) * CGFloat(rhs)
}
func -(lhs: CGFloat, rhs: Double) -> CGFloat {
    return CGFloat(lhs) - CGFloat(rhs)
}
func +(lhs: CGFloat, rhs: Double) -> CGFloat {
    return CGFloat(lhs) + CGFloat(rhs)
}
func /(lhs: CGFloat, rhs: Double) -> CGFloat {
    return CGFloat(lhs) / CGFloat(rhs)
}
func *(lhs: CGFloat, rhs: Double) -> CGFloat {
    return CGFloat(lhs) * CGFloat(rhs)
}

func %(lhs: Int, rhs: Float) -> Float {
    return Float(lhs) % Float(rhs)
}
func %(lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) % CGFloat(rhs)
}
func %(lhs: Int, rhs: Double) -> Double {
    return Double(lhs) % Double(rhs)
}
func %(lhs: Float, rhs: Int) -> Float {
    return Float(lhs) % Float(rhs)
}
func %(lhs: Float, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) % CGFloat(rhs)
}
func %(lhs: Float, rhs: Double) -> Double {
    return Double(lhs) % Double(rhs)
}
func %(lhs: CGFloat, rhs: Int) -> CGFloat {
    return CGFloat(lhs) % CGFloat(rhs)
}
func %(lhs: CGFloat, rhs: Float) -> CGFloat {
    return CGFloat(lhs) % CGFloat(rhs)
}
func %(lhs: CGFloat, rhs: Double) -> CGFloat {
    return CGFloat(lhs) % CGFloat(rhs)
}
func %(lhs: Double, rhs: Int) -> Double {
    return Double(lhs) % Double(rhs)
}
func %(lhs: Double, rhs: Float) -> Double {
    return Double(lhs) % Double(rhs)
}
func %(lhs: Double, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) % CGFloat(rhs)
}

func min(x: Int, y: Float) -> Float {
    return min(Float(x), Float(y))
}
func max(x: Int, y: Float) -> Float {
    return min(Float(x), Float(y))
}
func min(x: Int, y: CGFloat) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func max(x: Int, y: CGFloat) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func min(x: Int, y: Double) -> Double {
    return min(Double(x), Double(y))
}
func max(x: Int, y: Double) -> Double {
    return min(Double(x), Double(y))
}
func min(x: Float, y: Int) -> Float {
    return min(Float(x), Float(y))
}
func max(x: Float, y: Int) -> Float {
    return min(Float(x), Float(y))
}
func min(x: Float, y: CGFloat) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func max(x: Float, y: CGFloat) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func min(x: Float, y: Double) -> Double {
    return min(Double(x), Double(y))
}
func max(x: Float, y: Double) -> Double {
    return min(Double(x), Double(y))
}
func min(x: CGFloat, y: Int) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func max(x: CGFloat, y: Int) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func min(x: CGFloat, y: Float) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func max(x: CGFloat, y: Float) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func min(x: CGFloat, y: Double) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func max(x: CGFloat, y: Double) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func min(x: Double, y: Int) -> Double {
    return min(Double(x), Double(y))
}
func max(x: Double, y: Int) -> Double {
    return min(Double(x), Double(y))
}
func min(x: Double, y: Float) -> Double {
    return min(Double(x), Double(y))
}
func max(x: Double, y: Float) -> Double {
    return min(Double(x), Double(y))
}
func min(x: Double, y: CGFloat) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}
func max(x: Double, y: CGFloat) -> CGFloat {
    return min(CGFloat(x), CGFloat(y))
}

