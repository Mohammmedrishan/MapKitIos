//
//  ViewController.swift
//  MapUI
//
//  Created by Mohammed Rishan on 22/07/1941 Saka.
//  Copyright © 1941 Mohammed Rishan. All rights reserved.
//

import UIKit
import MapKit
let cityCoordinate = CLLocationCoordinate2DMake(9.9312, 76.2673)

class cityCenterCoordinate: NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D = cityCoordinate
    var identifier = "City"
    var title: String? = "Kochi"
}
class ViewController: UIViewController,MKMapViewDelegate {
    enum MapType: Int{
        case Map = 0
        case Hybrid
        case Satellite
    }
    @IBOutlet weak var mapCtrl: UISegmentedControl!
    
    @IBOutlet weak var mapV: MKMapView!
    let hosptials = CityLocations().hospital
    let pizzaPin = UIImage(named: "mark")
    let mycity = cityCenterCoordinate();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let region = MKCoordinateRegion(center: cityCoordinate, latitudinalMeters: 50000,longitudinalMeters: 50000)
        mapV.setRegion(region, animated: true)
        mapV.addAnnotation(mycity)
        mapV.addAnnotations(hosptials)
        let circle = MKCircle(center: cityCoordinate, radius: 40000)
        mapV.addOverlay(circle)
        mapV.delegate = self
    }
    
    func polyDirections(){
        var coordinates = [CLLocationCoordinate2D]()
        coordinates += [cityCenterCoordinate().coordinate]
        
        coordinates += [hosptials[0].coordinate]
        coordinates += [hosptials[2].coordinate]
        let path = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        mapV.addOverlay(path)
        
        var coordinates2 = [CLLocationCoordinate2D]()
        coordinates2 += [cityCenterCoordinate().coordinate]
        coordinates2 += [hosptials[2].coordinate]
        coordinates2 += [hosptials[3].coordinate]
        let poly = MKPolygon(coordinates: &coordinates2, count: coordinates.count)
        mapV.addOverlay(poly)
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle{
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? cityCenterCoordinate{
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKPinAnnotationView{
                return view
            }else{
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
                view.image = pizzaPin
                view.isEnabled = true
//                view.pinTintColor = UIColor.black
                view.canShowCallout = true
                view.leftCalloutAccessoryView = UIImageView(image: pizzaPin)
                return view
            }
        }else{
                if let annotation = annotation as? cityCenterCoordinate {
                    if let view = mapView.dequeueReusableAnnotationView(withIdentifier: "center") as? MKPinAnnotationView{
                        return view
                    }else{
                        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "center")
//                        view.isEnabled = true
                        view.pinTintColor = UIColor.black
                        view.canShowCallout = true
                        return view
                    }
                }
            }
        return nil
    }
    @IBAction func mapTypeChanged(_ sender: Any) {
        let mapType = MapType(rawValue: mapCtrl.selectedSegmentIndex)
        switch (mapType!) {
        case .Map:
            mapV.mapType = MKMapType.standard
        case .Hybrid:
            mapV.mapType = MKMapType.hybrid
            print("hybrid")
        case .Satellite:
            mapV.mapType = MKMapType.satellite
        }
    }
    

}

