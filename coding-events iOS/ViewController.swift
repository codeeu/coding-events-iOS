//
//	ViewController.swift
//	coding-events iOS
//
//	Created by Goran Blažič on 24/09/14.
//	Copyright (c) 2014 goranche.net. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, NSURLConnectionDelegate, MKMapViewDelegate {

	lazy var data = NSMutableData()
	@IBOutlet weak var mapView: MKMapView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		startConnection()
	}

	override func viewDidAppear(animated: Bool) {
		var locMgr = CLLocationManager()
		var auth = CLLocationManager.authorizationStatus()
		if (auth == CLAuthorizationStatus.NotDetermined) {
			locMgr.requestAlwaysAuthorization()
			// TODO: This no worky!!!
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func startConnection() {
		let urlPath: String = "http://events.codeweek.eu/api/event/list/?format=json"
		var url: NSURL = NSURL(string: urlPath)
		var request: NSURLRequest = NSURLRequest(URL: url)
		var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
		connection.start()
	}

	func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
		self.data.appendData(data)
	}

	func connectionDidFinishLoading(connection: NSURLConnection!) {
		var err: NSError?

		var events = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &err) as Array<NSDictionary>

		// TODO: Show the markers from the events array
		// each entry is a NSDictionary, use the "geoposition" field for the markers
	}

	func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
		var region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800)
		self.mapView.setRegion(region, animated: true)
	}

}
