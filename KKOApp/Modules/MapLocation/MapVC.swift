//
//  MapVC.swift
//  KKOApp
//
//  Created by VironIT on 25.08.22.
//
import MapKit
import UIKit

class MapVC: UIViewController {
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var rectView: UIView!
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    private var coffeeshops = CoffeeshopStorage.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKit.delegate = self
        configureLocationService()
        coffeeshopLocations()
        config()
    }
    
    private func config() {
        // rect view
        rectView.layer.cornerRadius = rectView.frame.height/2
        rectView.alpha = 0.6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        self.view.addGestureRecognizer(swipeDown)
    }
    
    private func configureLocationService() {
        locationManager.delegate = self
        let status = locationManager.authorizationStatus
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        mapKit.setRegion(region, animated: true)
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        mapKit.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func coffeeshopLocations() {
        var coffeeshopsLocations = [MKPointAnnotation()]
        for shopNumber in 0..<coffeeshops.elements.count {
            let singlecoffeeshop = MKPointAnnotation()
            singlecoffeeshop.coordinate = CLLocationCoordinate2D(latitude: coffeeshops.elements[shopNumber].latitude, longitude: coffeeshops.elements[shopNumber].longitude)
            singlecoffeeshop.title = coffeeshops.elements[shopNumber].name
            coffeeshopsLocations.append(singlecoffeeshop)
        }
        mapKit.addAnnotations(coffeeshopsLocations)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            self.navigationController?.popViewController(animated: true)
       }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            return
        }
        
        if currentLocation == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        
        currentLocation = latestLocation.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myMarker")
        
            switch annotation.title!! {
            case "KKO Movie":
                annotationView.markerTintColor = UIColor.orange
                annotationView.glyphImage = UIImage(named: "movie")
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            case "KKO Series":
                annotationView.markerTintColor = UIColor.green
                annotationView.glyphImage = UIImage(named: "series")
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            case "KKO Main":
                annotationView.markerTintColor = UIColor.magenta
                annotationView.glyphImage = UIImage(named: "main")
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            default:
                annotationView.markerTintColor = UIColor.blue
            }
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let coordinate = view.annotation?.coordinate else {
            return
        }

        mapKit.removeOverlays(mapView.overlays)
        
        let user = (locationManager.location?.coordinate)!
        let startPoint = MKPlacemark(coordinate: user)
        let endPoint = MKPlacemark(coordinate: coordinate)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: endPoint)
        request.transportType = .any
        
        let direction = MKDirections(request: request)
        direction.calculate { (responce, _) in
            guard let responce = responce else {
                return
            }
            guard let route = responce.routes.first else { return }
            self.mapKit.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var render = MKPolylineRenderer(overlay: overlay)
        if let mapPolyline = overlay as? MKPolyline {
            render = MKPolylineRenderer(polyline: mapPolyline)
            render.strokeColor = .blue
            render.lineWidth = 4.0
        }
        return render
    }
}
