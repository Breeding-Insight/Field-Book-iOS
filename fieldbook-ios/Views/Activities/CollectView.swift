//
//  CollectView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/11/21.
//

import SwiftUI

struct CollectView: View {
    @EnvironmentObject private var appState: AppState
    @State private var observationUnits: [ObservationUnit] = []
    @State private var traits: [ObservationVariable] = []
    @State private var study: Study?
    @State private var loadingData = true
    
    @State private var infoBar1: String = "Field Name"
    @State private var infoBar2: String = "Plot"
    
    
    @State private var currentTrait: Int = 0
    @State private var currentObsvUnit: Int = 0
    
    @State private var currentObservation: Observation = Observation()
    @State private var currentVal: String = ""
    
    private let observationVariableService = InjectionProvider.getObservationVariableService()
    private let studyService = InjectionProvider.getStudyService()
    
    var body: some View {
        return VStack {
            if(!loadingData) {
                HStack {
                    Picker("Choose field to display", selection: $infoBar1) {
                        Text("Plot").tag("Plot")
                        Text("Plant").tag("Plant")
                        Text("Row").tag("Row")
                        Text("Column").tag("Column")
                        Text("Field Name").tag("Field Name")
                        Text("Germplasm ID").tag("Germplasm ID")
                    }
                    Text(self.study?.name ?? "")
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
                    Text((getAttrVal("Plot") ?? String(observationUnits[currentObsvUnit].internalId!)))
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
                        ForEach(0..<traits.count, id: \.self) {
                            Text(traits[$0].name)
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
                        Text("Row: " + (self.getAttrVal("Row") ?? ""))
                        Text("Column: " + (self.getAttrVal("Column") ?? ""))
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
                    switch traits[currentTrait].fieldBookFormat {
                    case .categorical:
                        NominalScale(options: self.getTraitCategories(), selected: $currentVal)
                    case .date:
                        DateScale(val:$currentVal)
                    case .numeric, .percentage, .counter, .diseaseRating:
                        NumericalScale(val:$currentVal)
                    case .text, .boolean, .audio, .multicat, .location, .none:
                        TextScale(val:$currentVal)
                        //                case .nominal:
                        //                    NominalScale(options: (traits[currentTrait].scale?.validValues?.categories)!, selected: $currentVal)
                        //                case .ordinal:
                        //                    OrdinalScale(options: (traits[currentTrait].scale?.validValues?.categories)!, selected: $currentVal)
                        //                case .date:
                        //                    DateScale(val:$currentVal)
                        //                case .numerical, .duration:
                        //                    NumericalScale(val:$currentVal)
                        //                case .code, .text:
                        //                    TextScale(val:$currentVal)
                        //                default:
                        //                    TextScale(val:$currentVal)
                    }
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
            .onAppear() {
                loadState()
            }
    }
    
    func setCurrentObservationVal() -> Void {
        let currentTraitId = self.traits[currentTrait].internalId
        let currentOU = self.observationUnits[currentObsvUnit]
        
        var trait: Observation = Observation()
        trait.observationUnitId = currentOU.internalId
        
        if(currentOU.observations != nil) {
            for observation in currentOU.observations! {
                if(observation.internalId == currentTraitId) {
                    trait = observation
                    print("found existing val: " + (trait.value ?? "<no val>"))
                }
            }
        }
        
        currentVal = trait.value ?? ""
    }
    
    func saveCurrentVal() -> Void {
        let currentTraitId = self.traits[currentTrait].internalId
        let currentOU = self.observationUnits[currentObsvUnit]
        
        var hasTrait = false;
        if(currentOU.observations != nil) {
            for obsvIdx in 0..<currentOU.observations!.count {
                if(currentOU.observations![obsvIdx].internalId == currentTraitId) {
                    self.observationUnits[currentObsvUnit].observations![obsvIdx].value = self.currentVal
                    hasTrait = true
                    print("updated observation val: " + self.currentVal)
                }
            }
        }
        
        if(!hasTrait && self.currentVal.trimmingCharacters(in: .whitespacesAndNewlines).count > 0) {
            print("saving new observation val: " + self.currentVal)
            let observation = Observation()
            observation.internalId = currentTraitId
            observation.value = self.currentVal
            self.observationUnits[currentObsvUnit].observations!.append(observation)
            print(currentOU.observations!)
            print(self.observationUnits[currentObsvUnit].observations!)
        }
    }
    
    func getAttrVal(_ key: String) -> String? {
        return observationUnits[currentObsvUnit].attributes?[ObservationUnitAttribute(attributeName: key)]?.value
    }
    
    func getTraitCategories() -> [BrAPIScaleCategories] {
        //TODO
        
        return [
            BrAPIScaleCategories(label: "white", value: "white"),
            BrAPIScaleCategories(label: "brown", value: "brown"),
            BrAPIScaleCategories(label: "green", value: "green")
        ]
    }
    
    func loadState() {
        do {
            self.traits = try observationVariableService.getAllObservationVariables()
            let study = try studyService.getStudy(appState.currentStudyId!)
            if(study?.observationUnits != nil) {
                self.study = study
                self.observationUnits = study!.observationUnits
            }
        } catch let FieldBookError.serviceError(message){
            print("error fetching data from db \(String(describing: message))")
        } catch {
            print("unknown error")
        }
        
        self.loadingData = false
    }
    
}

//struct CollectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectView()
//    }
//}
