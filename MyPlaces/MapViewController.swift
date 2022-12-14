//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Ekaterina on 30.09.22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    var place = Place()
    let annotationIdentifier = "annotationIdentifier"
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10_000.00
    var incomeSegueIdentifier = ""
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapPinImage: UIImageView!
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMapView()
        checkLocationServices()
    }
    
    @IBAction func centerViewInUserLocation() {
      showUserLocation()
    }
    
    
    @IBAction func doneButtonPressed() {
    }
    
    @IBAction func closeVC() {
        dismiss(animated: true) // закроет вьюконтроллер и выгрузит из памяти
    }
    
    private func setupMapView() {
        if incomeSegueIdentifier == "showPlace" {
            setupPlacemark()
            mapPinImage.isHidden = true
            addressLabel.isHidden = true
            doneButton.isHidden = true
        }
    }
    private func setupPlacemark() {
        guard let location = place.location else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print (error)
                return
            }
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // set uo settings for further work
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // show alert controller how to add location settings
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert (
                title: "Location services are disabled",
                message: "To enable it go please go to Settings -> Privacy -> Location Services and turn ON"
            )
            }
        }
    }
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization () {
        let authorizationStatus: CLAuthorizationStatus

        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            if incomeSegueIdentifier == "getAddress" { showUserLocation() }
            break
        case .denied:
            // show alert controller
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert (
                title: "Your location is not availiable",
                message: "To give permissions please go to Settings -> MyPlaces -> Location"
            )
            }
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alert controller
            break
        case .authorizedAlways:
            break
        @unknown default:
            print ("new case is availiable")
        }
    }
    
    private func showUserLocation() {
        
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(
                center: location,
                latitudinalMeters: regionInMeters,
                longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present (alert, animated: true )
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true // отобразить аннотацию в виду банера
        }
        if let imageData = place.imageData {
            
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0 , width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
            
        }
        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


