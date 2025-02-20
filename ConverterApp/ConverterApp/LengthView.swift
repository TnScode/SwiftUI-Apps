//
//  length.swift
//  ConverterApp
//
//  Created by Tavin Severino on 2/4/25.
//

import SwiftUI

struct LengthView: View {
    
    @State private var newValue: String = ""
    @State private var outputValue: Double = 0.0
    @State private var userSelection: String = "Inches"
    let userUnits: [String] = [
        "Inches", "Feet", "Yards", "Miles",
        "Millimeters", "Centimeters", "Meters", "Kilometers"
    ]
    @State private var conversionSelection: String = "Feet"
    let conversionUnits: [String] = [
        "Inches", "Feet", "Yards", "Miles",
        "Millimeters", "Centimeters", "Meters", "Kilometers"
    ]
    
    // Conversion factors (all values in inches)
    let lengthConversionTable: [String: Double] = [
        "Inches": 1.0,
        "Feet": 12.0,
        "Yards": 36.0,
        "Miles": 63360.0,
        "Millimeters": 0.0393701,
        "Centimeters": 0.393701,
        "Meters": 39.3701,
        "Kilometers": 39370.1
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Blue Header
                VStack {
                    Text("Length Converter")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.top, 60)
                        .padding(.bottom, 30)
                        .background(Color.blue)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                
                // Gray Section with Buttons
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 40)
                    HStack(spacing: 40) {
                        NavigationLink(destination: ContentView()) {
                            Text("Home")
                        }
                        NavigationLink(destination: TempView()) {
                            Text("Temp")
                        }
                        NavigationLink(destination: WeightView()) {
                            Text("Weight")
                        }
                        Button(action: {}) { Text("Time") }
                    }
                }
                .accentColor(.white)
                
                // Main Content
                VStack {
                    HStack {
                        TextField("Input your value here", text: $newValue)
                            .frame(width: 200, height: 30, alignment: .top)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                            .foregroundColor(.black)
                        
                        Picker("Units Input", selection: $userSelection) {
                            ForEach(userUnits, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    HStack {
                        Text("\(outputValue, specifier: "%.4f")") // Fixed decimal places
                            .frame(width: 200, height: 30, alignment: .top)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                            .padding(.vertical)
                            .foregroundColor(.black)
                        
                        Picker("Units Output", selection: $conversionSelection) {
                            ForEach(conversionUnits, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.blue)
                                .cornerRadius(15)
                            Button(action: {
                                lengthConversion()
                            }, label: {
                                Text("Submit")
                                    .frame(width: 150, height: 30)
                                    .foregroundColor(.white)
                            })
                        }
                        
                        Spacer()
                            Button(action: {
                                newValue = ""
                                outputValue = 0.0000
                            }, label: {
                                Text("Reset")
                                    .frame(width: 150, height: 30)
                                    .foregroundColor(.blue)
                            })

                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Length Conversion Function
    func lengthConversion() {
        guard let inputValue = Double(newValue),
              let fromFactor = lengthConversionTable[userSelection],
              let toFactor = lengthConversionTable[conversionSelection] else {
            return
        }
        
        let valueInInches = inputValue * fromFactor
        let convertedValue = valueInInches / toFactor
        
        outputValue = convertedValue
    }
}

#Preview {
    LengthView()
}

