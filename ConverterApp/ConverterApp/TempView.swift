//
//  TempView.swift
//  ConverterApp
//
//  Created by Tavin Severino on 2/4/25.
//

import SwiftUI

struct TempView: View {
    
    @State private var newValue: String = ""
    @State private var outputValue: Double = 0.0
    @State private var userSelection: String = "Celsius"
    let userUnits: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var conversionSelection: String = "Fahrenheit"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Blue Header
                VStack {
                    Text("Temperature Converter")
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
                        Text("\(outputValue, specifier: "%.2f")")
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
                                tempConversion()
                            }, label: {
                                Text("Submit")
                                    .frame(width: 150, height: 30)
                                    .foregroundColor(.white)
                            })
                        }
                        
                        Spacer()
                            Button(action: {
                                newValue = ""
                                outputValue = 0.00
                            }, label: {
                                Text("Reset")
                                    .frame(width: 150, height: 30)
                                    .foregroundColor(.blue)
                            })

                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Temperature Conversion Function
    func tempConversion() {
        guard let inputTemp = Double(newValue) else { return }
        
        switch (userSelection, conversionSelection) {
        case ("Celsius", "Fahrenheit"):
            outputValue = (inputTemp * 9/5) + 32
        case ("Celsius", "Kelvin"):
            outputValue = inputTemp + 273.15
        case ("Fahrenheit", "Celsius"):
            outputValue = (inputTemp - 32) * 5/9
        case ("Fahrenheit", "Kelvin"):
            outputValue = (inputTemp - 32) * 5/9 + 273.15
        case ("Kelvin", "Celsius"):
            outputValue = inputTemp - 273.15
        case ("Kelvin", "Fahrenheit"):
            outputValue = (inputTemp - 273.15) * 9/5 + 32
        default:
            outputValue = inputTemp // No conversion needed if same unit
        }
    }
}

#Preview {
    TempView()
}

