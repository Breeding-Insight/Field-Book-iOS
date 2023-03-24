//
//  CollectView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 11/11/21.
//

import SwiftUI
import os

struct CollectView: View {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "CollectView")
    
    @EnvironmentObject private var appState: AppState
    @State private var observationUnits: [ObservationUnit] = []
    @State private var totalOus = 0.0
    @State private var traits: [ObservationVariable] = []
    @State private var totalTraits = 0.0
    @State private var study: Study?
    @State private var loadingData = true
    @State private var error = false
    @State private var saveObservationError = false
    
    @State private var infoBar1: String = "Field Name"
    @State private var infoBar2: String = "Plot"
    
    @State private var currentTrait: Int = -1
    @State private var currentObsvUnit: Int = -1
    
    @State private var currentObservation: Observation = Observation()
    @State private var currentVal: String = ""
    
    @State private var currentOuTraitsCompleted = 0.0
    @State private var completedOus = 0.0
    
    private let observationVariableService = InjectionProvider.getObservationVariableService()
    private let studyService = InjectionProvider.getStudyService()
    private let observationService = InjectionProvider.getObservationService()
    
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
                    }.tint(.black)
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
                    }.tint(.black)
                    Text((getAttrVal("Plot") ?? String(observationUnits[currentObsvUnit].internalId!)))
                    Spacer()
                }.padding(.leading)
                HStack {
                    SwiftUI.Image("main_trait_left_arrow_unpressed").resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.leading)
                        .onTapGesture {
                            self.movePreviousTrait()
                        }
                    Spacer()
                    Picker("Choose Trait", selection: $currentTrait) {
                        ForEach(0..<traits.count, id: \.self) {
                            Text(traits[$0].name)
                                .tag($0)
                        }
                    }.tint(.black)
                    Spacer()
                    SwiftUI.Image("main_trait_right_unpressed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.trailing)
                        .onTapGesture {
                            self.moveNextTrait()
                        }
                }.padding()
                HStack {
                    ProgressView(value: Double(self.currentTrait+1), total: self.totalTraits)
                        .progressViewStyle(LinearProgressViewStyle())
                        .labelsHidden()
                        .tint(Colors.primaryFB)
                        .foregroundColor(.gray)
                    Text("[\(Int(self.currentOuTraitsCompleted))/\(Int(self.totalTraits))]")
                }.padding(.leading, 50)
                    .padding(.trailing, 50)
                HStack {
                    SwiftUI.Image("main_entry_left_unpressed").resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .padding(.leading)
                        .onTapGesture {
                            self.movePreviousOu()
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
                            self.moveNextOu()
                        }
                }.padding(.bottom)
                HStack {
                    ProgressView(value: Double(self.currentObsvUnit+1), total: self.totalOus)
                        .progressViewStyle(LinearProgressViewStyle())
                        .labelsHidden()
                        .tint(.black)
                        .foregroundColor(.gray)
                    Text("[\(Int(self.completedOus))/\(Int(self.totalOus))]")
                }.padding(.leading, 50)
                    .padding(.trailing, 50)
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
//                                        case .nominal:
//                                            NominalScale(options: (traits[currentTrait].scale?.validValues?.categories)!, selected: $currentVal)
//                                        case .ordinal:
//                                            OrdinalScale(options: (traits[currentTrait].scale?.validValues?.categories)!, selected: $currentVal)
//                                        case .date:
//                                            DateScale(val:$currentVal)
//                                        case .numerical, .duration:
//                                            NumericalScale(val:$currentVal)
//                                        case .code, .text:
//                                            TextScale(val:$currentVal)
//                                        default:
//                                            TextScale(val:$currentVal)
                    }
                }
                Spacer()
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
            .task {
                self.loadState()
            }
            .alert(isPresented: $error) {
                var errorMsg = "An unknown error occurred"
                if self.saveObservationError {
                    errorMsg = "Unable to save observation for trait \(traits[currentTrait].name)"
                }
                
                return Alert(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
            }
    }
    
    func setCurrentObservationVal() -> Void {
        let currentTraitId = self.traits[currentTrait].internalId
        let currentOU = self.observationUnits[currentObsvUnit]
        
        var trait: Observation = Observation()
        trait.observationUnitId = currentOU.internalId
        
        if(currentOU.observations != nil) {
            for observation in currentOU.observations! {
                if(observation.observationVariableId == currentTraitId) {
                    trait = observation
                    logger.debug("found existing val: \"\(trait.value ?? "<no val>")\")")
                    break
                }
            }
        }
        
        currentVal = trait.value ?? ""
    }
    
    func saveCurrentVal() throws -> Void {
        self.saveObservationError = false
        
        let currentTraitId = self.traits[currentTrait].internalId
        let currentOU = self.observationUnits[currentObsvUnit]
        
        var hasTrait = false;
        if(currentOU.observations != nil) {
            for obsvIdx in 0..<currentOU.observations!.count {
                if(currentOU.observations![obsvIdx].observationVariableId == currentTraitId) {
                    if(self.currentVal == self.observationUnits[currentObsvUnit].observations![obsvIdx].value) {
                        logger.debug("no change to the value, skipping save")
                        return
                    }
                    
                    self.observationUnits[currentObsvUnit].observations![obsvIdx].value = self.currentVal
                    self.observationUnits[currentObsvUnit].observations![obsvIdx].observationTimeStamp = Date.now
                    self.observationUnits[currentObsvUnit].observations![obsvIdx].collector = "admin" //todo fix this
                    hasTrait = true
                    logger.debug("updated observation val: \(self.currentVal)")
                    
                    do {
                        _ = try observationService.saveObservation(observation: self.observationUnits[currentObsvUnit].observations![obsvIdx])
                    } catch {
                        self.saveObservationError = true
                        throw error
                    }
                    
                    break
                }
            }
        }
        
        if(!hasTrait && self.currentVal.trimmingCharacters(in: .whitespacesAndNewlines).count > 0) {
            logger.debug("saving new observation val: \(self.currentVal)")
            let observation = Observation(observationUnitId: currentOU.internalId!, studyId: study!.internalId!, observationVariableId: currentTraitId!)
            observation.value = self.currentVal
            observation.observationTimeStamp = Date.now
            observation.collector = "admin" //todo fix this
            
            do {
                let savedObservation = try observationService.saveObservation(observation: observation)
                
                self.observationUnits[currentObsvUnit].observations!.append(savedObservation!)
                
                if(self.currentOuTraitsCompleted < self.totalTraits) {
                    self.currentOuTraitsCompleted += 1
                    if self.currentOuTraitsCompleted == self.totalTraits {
                        self.completedOus += 1
                    }
                }
                
                logger.debug("\(currentOU.observations!)")
                logger.debug("\(self.observationUnits[currentObsvUnit].observations!)")
            } catch {
                self.saveObservationError = true
                throw error
            }
        }
    }
    
    func getAttrVal(_ key: String) -> String? {
        return observationUnits[currentObsvUnit].attributes?[ObservationUnitAttribute(attributeName: key)]?.value
    }
    
    func getTraitCategories() -> [BrAPIScaleCategories] {
        let trait: ObservationVariable = self.traits[self.currentTrait]
        
        let attrVal: ObservationVariableAttributeValue = trait.attributes![ObservationVariableAttribute(attributeName: "category")]!
        
        let decoder = JSONDecoder()
        let data = attrVal.value.data(using: .utf8)!

        let catVals = try? decoder.decode([[String:String]].self, from: data)
        
        var categories: [BrAPIScaleCategories] = []
        
        for cat in catVals! {
            let value = cat["value"]!
            
            var label = value
            if cat["label"] != nil {
                label = cat["label"]!
            }
            
            categories.append(BrAPIScaleCategories(label: label, value: value))
        }
        
        
        return categories
    }
    
    func movePreviousTrait() {
        do {
            try saveCurrentVal()
            if (currentTrait == 0) {
                currentTrait = traits.count - 1
                if (currentObsvUnit == 0) {
                    currentObsvUnit = observationUnits.count - 1
                } else {
                    currentObsvUnit -= 1
                }
                setProgress()
            } else {
                currentTrait -= 1
            }
            UserDefaults.standard.set(currentTrait, forKey: AppConstants.CURRENT_TRAIT_IDX)
            setCurrentObservationVal()
        } catch let FieldBookError.serviceError(message) {
            logger.error("error saving observation: \(String(describing: message))")
            self.error = true
        } catch {
            logger.error("error saving observation: \(error.localizedDescription))")
            self.error = true
        }
    }
    
    func moveNextTrait() {
        do {
            try saveCurrentVal()
            if ((currentTrait + 1) == traits.count) {
                currentTrait = 0
                if ((currentObsvUnit + 1) == observationUnits.count) {
                    currentObsvUnit = 0
                } else {
                    currentObsvUnit += 1
                }
                setProgress()
            } else {
                currentTrait += 1
            }
            UserDefaults.standard.set(currentTrait, forKey: AppConstants.CURRENT_TRAIT_IDX)
            setCurrentObservationVal()
        } catch let FieldBookError.serviceError(message) {
            logger.error("error saving observation: \(String(describing: message))")
            self.error = true
        } catch {
            logger.error("error saving observation: \(error.localizedDescription))")
            self.error = true
        }
    }
    
    func movePreviousOu() {
        do {
            try saveCurrentVal()
            if (currentObsvUnit == 0) {
                currentObsvUnit = observationUnits.count - 1
            } else {
                currentObsvUnit -= 1
            }
            UserDefaults.standard.set(currentObsvUnit, forKey: AppConstants.CURRENT_OU_IDX)
            setCurrentObservationVal()
            setProgress()
        } catch let FieldBookError.serviceError(message) {
            logger.error("error saving observation: \(String(describing: message))")
            self.error = true
        } catch {
            logger.error("error saving observation: \(error.localizedDescription))")
            self.error = true
        }
    }
    
    func moveNextOu() {
        do {
            try saveCurrentVal()
            if ((currentObsvUnit + 1) == observationUnits.count) {
                currentObsvUnit = 0
            } else {
                currentObsvUnit += 1
            }
            UserDefaults.standard.set(currentObsvUnit, forKey: AppConstants.CURRENT_OU_IDX)
            setCurrentObservationVal()
            setProgress()
        } catch let FieldBookError.serviceError(message) {
            logger.error("error saving observation: \(String(describing: message))")
            self.error = true
        } catch {
            logger.error("error saving observation: \(error.localizedDescription))")
            self.error = true
        }
    }
    
    func setProgress() {
        currentOuTraitsCompleted = Double(self.observationUnits[currentObsvUnit].observations?.count ?? 0)
    }
    
    func loadState() {
        do {
            self.traits = try observationVariableService.getAllObservationVariables()
            self.totalTraits = Double(traits.count)
            let study = try studyService.getStudy(appState.currentStudyId!)
            if(study?.observationUnits != nil) {
                self.study = study
                self.observationUnits = study!.observationUnits
                self.totalOus = Double(self.observationUnits.count)
                self.currentTrait = Int(UserDefaults.standard.string(forKey:AppConstants.CURRENT_TRAIT_IDX) ?? "0")!
                self.currentObsvUnit = Int(UserDefaults.standard.string(forKey:AppConstants.CURRENT_OU_IDX) ?? "0")!
                self.setCurrentObservationVal()
                self.setProgress()
                self.currentOuTraitsCompleted = Double(self.observationUnits[self.currentObsvUnit].observations?.count ?? 0)
            }
        } catch let FieldBookError.serviceError(message){
            logger.error("error fetching data from db \(String(describing: message))")
        } catch {
            logger.error("unknown error: \(error.localizedDescription)")
        }
        
        self.loadingData = false
    }
    
}
