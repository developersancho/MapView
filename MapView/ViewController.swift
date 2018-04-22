//
//  ViewController.swift
//  MapView
//
//  Created by developersancho on 22.04.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate {
    @IBOutlet weak var harita: MKMapView!
    @IBOutlet weak var goruntuSecici: UISegmentedControl!
    var haritaYoneticisi = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isaretlenmisYer: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.0102645, longitude: 28.9786778)
        
        let aciklama = MKPointAnnotation()
        aciklama.coordinate = isaretlenmisYer
        aciklama.title = "İSTANBUL MERKEZ"
        aciklama.subtitle = "İstanbul,Türkiye"
        self.harita.addAnnotation(aciklama)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func goruntuSec(_ sender: Any) {
        switch goruntuSecici.selectedSegmentIndex {
        case 0:
            harita.mapType = MKMapType.standard
            break
        case 1:
            harita.mapType = MKMapType.satellite
            break
        case 2:
            harita.mapType = MKMapType.hybrid
            break
        default:
            break
        }
    }
    
    @IBAction func yerimiBul(_ sender: Any) {
        haritaYoneticisi.delegate = self
        haritaYoneticisi.desiredAccuracy = kCLLocationAccuracyBest
        haritaYoneticisi.requestWhenInUseAuthorization()
        haritaYoneticisi.startUpdatingLocation()
        harita.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLoc : CLLocation = locations[0] as CLLocation
        haritaYoneticisi.stopUpdatingLocation()
        let alan = CLLocationCoordinate2D(latitude: userLoc.coordinate.latitude, longitude: userLoc.coordinate.longitude)
        let aralik = MKCoordinateSpanMake(0.8, 0.8)
        let bolge = MKCoordinateRegion(center: alan, span: aralik)
        harita.setRegion(bolge, animated: true)
    }
    
    
    @IBAction func isaretliAlanaGotur(_ sender: Any) {
        let baglanti = URL(string: "http://maps.apple.com/maps?daddr=41.0102645,28.9786778")
        UIApplication.shared.openURL(baglanti!)
    }
    
}

