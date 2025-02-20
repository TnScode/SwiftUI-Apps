//
//  ContentView.swift
//  Calculator
//
//  Created by Tavin Severino on 7/23/24.
//

import SwiftUI

struct ContentView: View {

    @State private var isNegative: Bool = false
    @State private var num1: Double = 0
    @State private var num2: Double = 0
    @State private var input: Int = 0
    @State private var result: String = ""
    @State private var storedResult: String = ""
    @State private var operation: String = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 380, height: 250)
            Text(result)
                .frame(width: 360, height: 220, alignment: .trailing)
                .foregroundColor(.white)
                .font(.custom("helvetica", size: 80))
            Text(storedResult)
                .frame(width: 365, height: 235, alignment: .topLeading)
                .foregroundColor(.white)
        }
        Spacer()
        VStack {
            HStack {
                ZStack {
                    Circle()
                    Text("C")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.clear()
                })
                ZStack {
                    Circle()
                    Text("+/-")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    //add positive/negative logic
                    self.toggleNegative()
                })
                ZStack {
                    Circle()
                    Text("%")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    //add percent logic
                    
                })
                ZStack {
                    Circle()
                    Text("/")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.performOperation("/")
                    result = "0"
                })
            }
            HStack {
                ZStack {
                    Circle()
                    Text("7")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("7")
                })
                ZStack {
                    Circle()
                    Text("8")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("8")
                })
                ZStack {
                    Circle()
                    Text("9")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("9")
                })
                ZStack {
                    Circle()
                    Text("X")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.performOperation("X")
                    result = "0"
                })
            }
            HStack {
                ZStack {
                    Circle()
                    Text("4")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("4")
                })
                ZStack {
                    Circle()
                    Text("5")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("5")
                })
                ZStack {
                    Circle()
                    Text("6")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("6")
                })
                ZStack {
                    Circle()
                    Text("-")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.performOperation("-")
                    result = "0"
                })
            }
            HStack {
                ZStack {
                    Circle()
                    Text("1")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("1")
                })
                ZStack {
                    Circle()
                    Text("2")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("2")
                })
                ZStack {
                    Circle()
                    Text("3")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("3")
                })
                ZStack {
                    Circle()
                    Text("+")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.performOperation("+")
                    result = "0"
                })
            }
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                    Text("0")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit("0")
                })
                ZStack {
                    Circle()
                    Text(".")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.appendDigit(".")
                })
                ZStack {
                    Circle()
                    Text("=")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .onTapGesture(perform: {
                    self.calculateResult()
                    result = "0"
                })
            }
            .frame(width: 370)
        }
    }
    
    private func appendDigit(_ digit: String) {
        if digit == "." {
            if !result.contains(".") {
                result.append(digit)
            }
        } else {
            if result == "0" && digit != "." {
                result = digit
            } else {
                result.append(digit)
            }
        }
    }
    
    private func performOperation(_ op: String) {
        if result.isEmpty { return }
        
        if num1 == 0 {
            num1 = Double(result) ?? 0
        } else {
            num2 = Double(result) ?? 0
            calculateResult()
        }
        
        operation = op
        storedResult = "\(result) \(op) "
        result = ""
    }
    
    private func calculateResult() {
        if operation.isEmpty || result.isEmpty { return }
        
        num2 = Double(result) ?? 0
        
        switch operation {
        case "+":
            num1 += num2
        case "-":
            num1 -= num2
        case "X":
            num1 *= num2
        case "/":
            if num2 != 0 {
                num1 /= num2
            } else {
                // handle division by zero error
                result = "Error"
                num1 = 0
                num2 = 0
                storedResult = ""
                return
            }
        default:
            return
        }
        
        // Determine how to display the result based on whether it has a decimal
        if result.contains(".") {
            result = "\(num1)"
        } else {
            result = "\(Int(num1))"
        }
        
        storedResult += "\(num2) = \(num1)"
    }
    
    private func toggleNegative() {
            if result.isEmpty { return }
            
            isNegative.toggle()
            
            if isNegative {
                result = "-\(result)"
            } else {
                result.removeFirst()
            }
        }
    
    private func clear() {
        result = "0"
        storedResult = ""
        input = 0
        num1 = 0
        num2 = 0
        operation = ""
    }
}


#Preview {
    ContentView()
}
