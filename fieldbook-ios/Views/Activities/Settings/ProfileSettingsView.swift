//
//  ProfileSettingsView.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 1/12/22.
//

import SwiftUI
import CoreLocation

struct ProfileSettingsView: View {
    @StateObject var locationManager = LocationManager()
    
    @State private var showingProfileSheet = false;
    @State private var givenName = "";
    @State private var surName = "";
    
    @State private var showingLocSheet = false;
    @State private var latitude = ""
    @State private var longitude = ""
    
    @State private var verifyProfile = true
    
    var body: some View {
        List {
            ListItemWidget(rowIcon: "person.fill", mainText: "Profile", secondaryText: self.givenName + " " + self.surName, rightIcon: "chevron.right"
            ).onTapGesture {self.showingProfileSheet = true}
            .sheet(isPresented: self.$showingProfileSheet) {
                NavigationView {
                    VStack {
                        HStack {
                            Text("Given Name:")
                            TextField("Jane", text: self.$givenName)
                        }
                        HStack {
                            Text("Surname:")
                            TextField("Doe", text: self.$surName)
                        }
                        
                        Button("Done") {
                            UserDefaults.standard.set(self.givenName, forKey: PreferenceConstants.PROFILE_GIVENNAME)
                            UserDefaults.standard.set(self.surName, forKey: PreferenceConstants.PROFILE_SURNAME)
                            UserDefaults.standard.synchronize()
                            self.showingProfileSheet = false
                        }.padding(.top)
                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle(Text("Edit Profile"), displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        givenName = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_GIVENNAME) ?? ""
                        surName = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_SURNAME) ?? ""
                        self.showingProfileSheet = false
                    }) {
                        Text("Cancel").bold()
                    })
                }
            }
            
            ListItemWidget(rowIcon: "location.circle.fill", mainText: "Location", secondaryText: self.latitude == "" ? "" : self.latitude + ";" + self.longitude, rightIcon: "chevron.right"
            ).onTapGesture {self.showingLocSheet = true}
            .sheet(isPresented: self.$showingLocSheet) {
                NavigationView {
                    VStack {
                        HStack {
                            Text("Latitude:")
                            TextField("39.186690", text: self.$latitude)
                        }
                        HStack {
                            Text("Longitude:")
                            TextField("-96.566600", text: self.$longitude)
                        }
                        
                        HStack {
                            Spacer()
                            Button("Get Location") {
                                locationManager.requestLocation()
                            }
                            Spacer()
                            Button("Done") {
                                UserDefaults.standard.set(self.latitude, forKey: PreferenceConstants.PROFILE_LATITUDE)
                                UserDefaults.standard.set(self.longitude, forKey: PreferenceConstants.PROFILE_LONGITUDE)
                                self.showingLocSheet = false
                            }
                            Spacer()
                        }.padding(.top)
                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle(Text("Set Location"), displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        latitude = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_LATITUDE) ?? ""
                        longitude = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_LONGITUDE) ?? ""
                        self.showingLocSheet = false
                    }) {
                        Text("Cancel").bold()
                    })
                }
            }
            ListItemWidget(rowIcon: "person.badge.clock", mainText: "Verify person every 24 hours", rightIcon: self.verifyProfile ? "checkmark.square.fill" : "square").onTapGesture {
                verifyProfile = !verifyProfile
                UserDefaults.standard.set(verifyProfile, forKey: PreferenceConstants.VERIFY_PROFILE)
            }
            ListItemWidget(rowIcon: "trash.fill", mainText: "Reset Profile")
        }
        .listStyle(.plain).navigationTitle("Profile")
        .onAppear {
            givenName = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_GIVENNAME) ?? "";
            surName = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_SURNAME) ?? "";
            
            latitude = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_LATITUDE) ?? ""
            longitude = UserDefaults.standard.string(forKey: PreferenceConstants.PROFILE_LONGITUDE) ?? ""
            
            verifyProfile = UserDefaults.standard.bool(forKey: PreferenceConstants.VERIFY_PROFILE)
        }
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var authStatus = CLAuthorizationStatus.notDetermined
    
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        switch authStatus {
        case .denied:
            manager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted:
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            manager.requestWhenInUseAuthorization()
        }
        
        if(authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse) {
            manager.requestLocation()
        } else {
            print("don't have auth from user")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
