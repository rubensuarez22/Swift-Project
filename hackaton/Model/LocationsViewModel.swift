//
//  LocationsViewModel.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 05/03/24.
//

import Foundation
import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject{
    //All loaded locations
    @Published var selectedLocationForDetail: Location? = nil
    @Published var locations: [Location]
    //Current location on map
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show list of locations
    
    @Published var showLocationsList: Bool = false
    
    
    // Show location detail via sheet
    
    @Published var sheetLocation: Location? = nil
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            print("Cambiando a la siguiente ubicación: \(location.name)")
            mapLocation = location
            showLocationsList = false
        }
    }

    
    func nextButtonPressed(){
        //Get the current index

        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        //Next index is valid?
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Next index is not valid
            //restart from 0
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
}
