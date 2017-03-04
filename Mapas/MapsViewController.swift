//
//  ViewController.swift
//  Mapas
//
//  Created by Faculdade Catolica do Tocantins on 04/03/17.
//  Copyright © 2017 FCTecnologia. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    @IBOutlet weak var vrMapa: MKMapView!
    @IBAction func vrSegment(_ sender: UISegmentedControl)
    {
        if(sender.selectedSegmentIndex == 0)
        {
            vrMapa.mapType = .satellite
        
        }
        else if(sender.selectedSegmentIndex == 1)
        {
            vrMapa.mapType = .hybrid
        }
        else
        {
            vrMapa.mapType = .standard
        }
    }
    @IBAction func trataGesto(_ sender: UILongPressGestureRecognizer)
    {
        if (sender.state != .began)
        {
            return
        }
        //ponto onde houve o toque na view
        let ponto = sender.location(in: vrMapa)
        //conversao da coordenada do ponto na view para o vrMapa
        let coordenada = vrMapa.convert(ponto, toCoordinateFrom: vrMapa)
        
        let pino = MKPointAnnotation()
        pino.coordinate = coordenada
        pino.title = "Algum lugar que eu curto?"
        vrMapa.addAnnotation(pino)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let destino = CLLocationCoordinate2D(latitude: -10.270148, longitude: -48.331896)
        let zoom = MKCoordinateSpanMake(0.01, 0.01)
        let regiao = MKCoordinateRegionMake(destino, zoom)
        vrMapa.setRegion(regiao, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

