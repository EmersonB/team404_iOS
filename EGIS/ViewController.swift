//
//  ViewController.swift
//  EGIS
//
//  Created by Emery Berlik on 7/21/17.
//  Copyright © 2017 Berlik. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController, AGSGeoViewTouchDelegate {

    @IBOutlet var mapView: AGSMapView!
    
    private let itemURL1 = "https://emerson-berlik.maps.arcgis.com/home/item.html?id=d972ab1dac7945ee833ad8e3e7852206"
    
    private var featureTable:AGSServiceFeatureTable!
    private var featureLayer:AGSFeatureLayer!
    private var lastQuery:AGSCancelable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add the source code button item to the right of navigation bar
        
        //instantiate map with a basemap
        let map = AGSMap(url: URL(string: itemURL1)!)!
        //set initial viewpoint
        map.initialViewpoint = AGSViewpoint(center: AGSPoint(x: 544871.19, y: 6806138.66, spatialReference: AGSSpatialReference.webMercator()), scale: 2e6)
        
        //assign the map to the map view
        self.mapView.map = map
        //set touch delegate on map view as self
        self.mapView.touchDelegate = self
        
        //instantiate service feature table using the url to the service
        self.featureTable = AGSServiceFeatureTable(url: URL(string: "https://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0")!)
        //create a feature layer using the service feature table
        self.featureLayer = AGSFeatureLayer(featureTable: self.featureTable)
        
        //add the feature layer to the operational layers on map
        map.operationalLayers.add(featureLayer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFeature(at mappoint:AGSPoint) {
        //disable interaction with map view
        self.mapView.isUserInteractionEnabled = false
        
        //normalize geometry
        let normalizedGeometry = AGSGeometryEngine.normalizeCentralMeridian(of: mappoint)!
        
        //attributes for the new feature
        let featureAttributes = ["typdamage" : "Major", "primcause" : "Earthquake"]
        //create a new feature
        let feature = self.featureTable.createFeature(attributes: featureAttributes, geometry: normalizedGeometry)
        
        //add the feature to the feature table
        self.featureTable.add(feature) { [weak self] (error: Error?) -> Void in
            if let error = error {
                print("Error while adding feature :: \(error)")
            }
            else {
                //applied edits on success
                self?.applyEdits()
            }
            //enable interaction with map view
            self?.mapView.isUserInteractionEnabled = true
        }
    }
    
    func applyEdits() {
        self.featureTable.applyEdits { (featureEditResults: [AGSFeatureEditResult]?, error: Error?) -> Void in
            if let error = error {
            }
            else {
                if let featureEditResults = featureEditResults , featureEditResults.count > 0 && featureEditResults[0].completedWithErrors == false {
                }
            }
        }
    }
    
    //MARK: - AGSGeoViewTouchDelegate
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        //add a feature at the tapped location
        self.addFeature(at: mapPoint)
    }
}

