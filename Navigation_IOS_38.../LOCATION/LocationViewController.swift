//
//  LocationViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 08.02.2024.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    
    private let cancelButton = UIButton()
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    // MARK: - Subviews
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsScale = true
        
        mapView.showsUserLocation = true
        
        let pointsOfInterestFilter = MKPointOfInterestFilter()
        mapView.pointOfInterestFilter = pointsOfInterestFilter
        
        // Москва
        let initialLocation = CLLocationCoordinate2D(
            latitude: 55.75222,
            longitude: 37.61556
        )
        mapView.setCenter(
            initialLocation,
            animated: false
        )
        
        let region = MKCoordinateRegion(
            center: initialLocation,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )
        mapView.setRegion(
            region,
            animated: false
        )
        
        mapView.addAnnotations(CapitalAnnotation.make())
        
        return mapView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Работа с картой"
        view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupConstraints()
        
        findUserLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestLocation()
    }
    
    // MARK: - Private
    @objc private func mapDidTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let locationInView = gestureRecognizer.location(in: mapView)
            let pointCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = pointCoordinate
            
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc private func cancelButtonDidTapped() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    private func setupSubviews() {
        setupMapView()
        setupButton()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapDidTapped))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupButton() {
        view.addSubview(cancelButton)
        cancelButton.tintColor = .white
        cancelButton.translatesAutoresizingMaskIntoConstraints = false 
        cancelButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor
            ),
            mapView.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor
            ),
            mapView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor
            ),
            mapView.bottomAnchor.constraint(
                equalTo: safeAreaGuide.bottomAnchor
            ),
            
            cancelButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 5),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func findUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    private func createRoute(to destinationCoordinate: CLLocationCoordinate2D) {
        guard let userLocation = mapView.userLocation.location?.coordinate else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let route = response?.routes.first else {
                return
            }
            
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else { return }
        
        createRoute(to: coordinate)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.lineWidth = 3
            renderer.strokeColor = .systemBlue
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            mapView.setCenter(
                location.coordinate,
                animated: true
            )
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
}

