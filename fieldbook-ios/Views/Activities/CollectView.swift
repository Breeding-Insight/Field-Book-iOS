//
//  CollectView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/11/21.
//

import SwiftUI

struct CollectView: View {
    @State private var observationUnits: [BrAPIObservationUnit] = [
        BrAPIObservationUnit(observationUnitDbId: "1", observationUnitName: "PLOT-1", observationUnitPosition: BrAPIObservationUnitPosition( positionCoordinateX: "1", positionCoordinateXType:.gridCol, positionCoordinateY: "1", positionCoordinateYType:.gridRow)),
        BrAPIObservationUnit(observationUnitDbId: "2", observationUnitName: "PLOT-2", observationUnitPosition: BrAPIObservationUnitPosition( positionCoordinateX: "1", positionCoordinateXType:.gridCol, positionCoordinateY: "2", positionCoordinateYType:.gridRow)),
        BrAPIObservationUnit(observationUnitDbId: "3", observationUnitName: "PLOT-3", observationUnitPosition: BrAPIObservationUnitPosition( positionCoordinateX: "1", positionCoordinateXType:.gridCol, positionCoordinateY: "3", positionCoordinateYType:.gridRow))
    ]
    @State private var traits: [BrAPIObservationVariable] = [
        BrAPIObservationVariable(observationVariableDbId:"1", observationVariableName: "Plant Height", scale: BrAPIScale(dataType:.numerical)),
        BrAPIObservationVariable(observationVariableDbId:"2", observationVariableName: "Leaf Width", scale: BrAPIScale(dataType:.numerical)),
        BrAPIObservationVariable(observationVariableDbId:"3", observationVariableName: "Leaf Color", scale: BrAPIScale(dataType:.nominal, validValues: BrAPIScaleValidValues(categories:[BrAPIScaleCategories(value: "orange"),BrAPIScaleCategories(value: "yellow"),BrAPIScaleCategories(value: "green")]))),
        BrAPIObservationVariable(observationVariableDbId:"4", observationVariableName: "Flowering Date", scale: BrAPIScale(dataType:.date)),
        BrAPIObservationVariable(observationVariableDbId:"5", observationVariableName: "Notes", scale: BrAPIScale(dataType:.text))
    ]
    
    @State private var infoBar1: String = "Field Name"
    @State private var infoBar2: String = "Plot"
    
    
    @State private var currentTrait: Int = 0
    @State private var currentObsvUnit: Int = 0
    
    @State private var currentObservation: BrAPIObservation = BrAPIObservation()
    @State private var currentVal: String = ""
    
    var body: some View {
        return VStack {
            HStack {
                Picker("Choose field to display", selection: $infoBar1) {
                    Text("Plot").tag("Plot")
                    Text("Plant").tag("Plant")
                    Text("Row").tag("Row")
                    Text("Column").tag("Column")
                    Text("Field Name").tag("Field Name")
                    Text("Germplasm ID").tag("Germplasm ID")
                }
                Text("Phenotyping Fall 2021")
                Spacer()
            }.padding(.leading).padding(.top)
            HStack {
                Picker("Choose field to display", selection: $infoBar2) {
                    Text("Plot").tag("Plot")
                    Text("Plant").tag("Plant")
                    Text("Row").tag("Row")
                    Text("Column").tag("Column")
                    Text("Field Name").tag("Field Name")
                    Text("Germplasm ID").tag("Germplasm ID")
                }
                Text(observationUnits[currentObsvUnit].observationUnitName!)
                Spacer()
            }.padding(.leading)
            HStack {
                SwiftUI.Image("main_trait_left_arrow_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.leading)
                    .onTapGesture {
                        saveCurrentVal()
                        if (currentTrait == 0) {
                            currentTrait = traits.count - 1
                            if (currentObsvUnit == 0) {
                                currentObsvUnit = observationUnits.count - 1
                            } else {
                                currentObsvUnit -= 1
                            }
                        } else {
                            currentTrait -= 1
                        }
                        setCurrentObservationVal()
                    }
                Spacer()
                Picker("Choose Trait", selection: $currentTrait) {
                    ForEach(0..<traits.count) {
                        Text(traits[$0].observationVariableName)
                            .tag($0)
                    }
                }
                Spacer()
                SwiftUI.Image("main_trait_right_unpressed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing)
                    .onTapGesture {
                        saveCurrentVal()
                        if ((currentTrait + 1) == traits.count) {
                            currentTrait = 0
                            if ((currentObsvUnit + 1) == observationUnits.count) {
                                currentObsvUnit = 0
                            } else {
                                currentObsvUnit += 1
                            }
                        } else {
                            currentTrait += 1
                        }
                        setCurrentObservationVal()
                    }
            }.padding()
            HStack {
                SwiftUI.Image("main_entry_left_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(.leading)
                    .onTapGesture {
                        saveCurrentVal()
                        if (currentObsvUnit == 0) {
                            currentObsvUnit = observationUnits.count - 1
                        } else {
                            currentObsvUnit -= 1
                        }
                        setCurrentObservationVal()
                    }
                Spacer()
                VStack {
                    Text(("Row: " + (observationUnits[currentObsvUnit].observationUnitPosition?.positionCoordinateXType == .gridRow ? observationUnits[currentObsvUnit].observationUnitPosition?.positionCoordinateX : observationUnits[currentObsvUnit].observationUnitPosition?.positionCoordinateY)!))
                    Text(("Column: " + (observationUnits[currentObsvUnit].observationUnitPosition?.positionCoordinateXType == .gridCol ? observationUnits[currentObsvUnit].observationUnitPosition?.positionCoordinateX : observationUnits[currentObsvUnit].observationUnitPosition?.positionCoordinateY)!))
                }
                Spacer()
                SwiftUI.Image("main_entry_right_unpressed").resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(.trailing)
                    .onTapGesture {
                        saveCurrentVal()
                        if ((currentObsvUnit + 1) == observationUnits.count) {
                            currentObsvUnit = 0
                        } else {
                            currentObsvUnit += 1
                        }
                        
                        setCurrentObservationVal()
                    }
            }.padding(.bottom)
            VStack {
                //                Text(currentVal).padding()
                switch traits[currentTrait].scale?.dataType {
                case .nominal:
                    NominalScale(options: (traits[currentTrait].scale?.validValues?.categories)!, selected: $currentVal)
                case .ordinal:
                    OrdinalScale(options: (traits[currentTrait].scale?.validValues?.categories)!, selected: $currentVal)
                case .date:
                    DateScale(val:$currentVal)
                case .numerical, .duration:
                    NumericalScale(val:$currentVal)
                case .code, .text:
                    TextScale(val:$currentVal)
                default:
                    TextScale(val:$currentVal)
                }
            }
        }.frame(maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Collect")
            .navigationBarItems(trailing: Button(action: {
            }) {
                SwiftUI.Image(systemName: "ellipsis.circle.fill").foregroundColor(.black)
            })
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        SwiftUI.Image(systemName: "barcode.viewfinder")
                    }.foregroundColor(.black)
                    Spacer()
                    Button(action: {}) {
                        SwiftUI.Image(systemName: "questionmark.square.fill")
                    }.foregroundColor(.black)
                    Spacer()
                    Button(action: {}) {
                        SwiftUI.Image(systemName: "trash.fill")
                    }.foregroundColor(.black)
                }
            }
    }
    
    func setCurrentObservationVal() -> Void {
        let currentTraitId = self.traits[currentTrait].observationVariableDbId
        let currentOU = self.observationUnits[currentObsvUnit]
        
        var trait: BrAPIObservation = BrAPIObservation(observationUnitDbId:currentTraitId)
        
        if(currentOU.observations != nil) {
            for observation in currentOU.observations! {
                if(observation.observationUnitDbId == currentTraitId) {
                    trait = observation
                    print("found existing val: " + (trait.value ?? "<no val>"))
                }
            }
        }
        
        currentVal = trait.value ?? ""
    }
    
    func saveCurrentVal() -> Void {
        let currentTraitId = self.traits[currentTrait].observationVariableDbId
        let currentOU = self.observationUnits[currentObsvUnit]
        
        var hasTrait = false;
        if(currentOU.observations != nil) {
            for obsvIdx in 0..<currentOU.observations!.count {
                if(currentOU.observations![obsvIdx].observationUnitDbId == currentTraitId) {
                    self.observationUnits[currentObsvUnit].observations![obsvIdx].value = self.currentVal
                    hasTrait = true
                    print("updated observation val: " + self.currentVal)
                }
            }
        }
        
        if(!hasTrait && self.currentVal.trimmingCharacters(in: .whitespacesAndNewlines).count > 0) {
            print("saving new observation val: " + self.currentVal)
            self.observationUnits[currentObsvUnit].observations!.append(BrAPIObservation(observationUnitDbId:currentTraitId, value: self.currentVal))
            print(currentOU.observations!)
            print(self.observationUnits[currentObsvUnit].observations!)
        }
        
        
    }
    
}

struct CollectView_Previews: PreviewProvider {
    static var previews: some View {
        CollectView()
    }
}
