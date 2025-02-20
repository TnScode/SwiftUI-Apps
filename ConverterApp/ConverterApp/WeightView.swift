//
//  WeightView.swift
//  ConverterApp
//
//  Created by Tavin Severino on 2/11/25.
//

import SwiftUI

struct WeightView: View {
    
    @State private var newValue: String = ""
    @State private var outputValue: Double = 0.0
    @State private var userSelection: String = "Pounds"  // Default value
    let userUnits: [String] = ["Milligrams", "Grams", "Kilograms", "Ounces", "Pounds"]
    @State private var conversionSelection: String = "Milligrams" // Default value
    
    // Corrected conversion table with proper units
    let weightConversionTable: [String: Double] = [
        "Kilograms": 1,         // 1 kg = 1 kg (base unit)
        "Grams": 1000,          // 1 kg = 1000 grams
        "Pounds": 2.20462,      // 1 kg = 2.20462 pounds
        "Ounces": 35.274,       // 1 kg = 35.274 ounces
        "Milligrams": 1_000_000 // 1 kg = 1,000,000 milligrams
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Blue Header
                VStack {
                    Text("Weight Converter")
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
                        NavigationLink(destination: LengthView()) {
                            Text("Length")
                        }
                        NavigationLink(destination: TempView()) {
                            Text("Temp")
                        }
                        Button(action: {}) { Text("Time") }
                    }
                }
                .accentColor(.white)
                
                /// Main View
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
                            ForEach(userUnits, id: \.self) { unit in
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
                                weightConversion()
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
    
    func weightConversion() {
        // Guard to ensure valid input and selections
        guard let inputValue = Double(newValue),
              let fromFactor = weightConversionTable[userSelection],
              let toFactor = weightConversionTable[conversionSelection] else {
            return
        }
        
        // Convert input to a common base unit (kilograms)
        let valueInBaseUnit = inputValue / fromFactor
        
        // Convert from the common base unit to the desired target unit
        let convertedValue = valueInBaseUnit * toFactor
        
        outputValue = convertedValue
    }
}

#Preview {
    WeightView()
}


