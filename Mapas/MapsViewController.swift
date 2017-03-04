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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

