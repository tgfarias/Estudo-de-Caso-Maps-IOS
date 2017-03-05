//
//  ViewController.swift
//  Mapas
//
//  Created by Faculdade Catolica do Tocantins on 04/03/17.
//  Copyright © 2017 FCTecnologia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var gerenteGPS:CLLocationManager!
    var localizacaoAtual: CLLocation!
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
        gerenteGPS.stopUpdatingLocation()
    }

    @IBAction func btnGerarRota(_ sender: UIButton) {
        if let origem = localizacaoAtual
        {
        
            let destino = CLLocationCoordinate2D(latitude:-10.270148, longitude: -48.331896)
            //gera os pontos de marcacoes para
            //origem e destino
            let origemPlaceMark = MKPlacemark(coordinate: origem.coordinate, addressDictionary: nil)
            let destinoPlaceMark = MKPlacemark(coordinate: destino, addressDictionary: nil)
            
            let origemMapItem = MKMapItem(placemark: origemPlaceMark)
            
            let destinoMapItem = MKMapItem(placemark: destinoPlaceMark)
            //configura o objeto q busca as direcoes do caminho
            //para o tipo de transporte desejado
            let direcoes  = MKDirectionsRequest()
            direcoes.source = origemMapItem
            direcoes.destination = destinoMapItem
            direcoes.transportType = .automobile
            
            
            
        }
    }
    
    @IBAction func btnLocAtual(_ sender: UIButton) {
        if (CLLocationManager.locationServicesEnabled())
        {
            //solicita autorizacao do usuario
            gerenteGPS.requestWhenInUseAuthorization()
            //inicializa o procedimento de busca pelas localizacoes
            gerenteGPS.startUpdatingLocation()
        }
        else
        {
            print ("HABILITE SEU GPS")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vrMapa.delegate = self
        
        gerenteGPS = CLLocationManager();
        gerenteGPS.delegate = self
        
        let destino = CLLocationCoordinate2D(latitude: -10.1845667, longitude: -48.3357847)
        let zoom = MKCoordinateSpanMake(0.03, 0.03)
        let regiao = MKCoordinateRegionMake(destino, zoom)
        vrMapa.setRegion(regiao, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinoPerson = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pinoPerson.image = UIImage(named: "images")
        pinoPerson.canShowCallout = true
        
        return pinoPerson
    }*/
 
    //Funcao chamada para buscar as coordenadas
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let posicaoAtual = locations.last
        {
            
            //criacao do pino q indicará o local
            let pino = MKPointAnnotation()
            pino.coordinate = posicaoAtual.coordinate
            pino.title = "Estou aqui"
            vrMapa.addAnnotation(pino)
            
            // criacao da regiao para onde vai a camera
            let zoom = MKCoordinateSpanMake(0.01, 0.01)
            
            //regiao para onde sera enviado a camera
            let regiao = MKCoordinateRegionMake(posicaoAtual.coordinate, zoom)
            //apontando a regiao no mapa
            vrMapa.setRegion(regiao, animated: true)
            
            
            gerenteGPS.stopUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }


}

