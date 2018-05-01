//
//  AddCookieLocationViewController.swift
//  CookieMeUp
//
//  Created by Sandra Flores on 4/22/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import DateTimePicker
import Parse

class AddCookieLocationViewController: UIViewController, GMSMapViewDelegate, DateTimePickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    var startDatePicker: DateTimePicker?
    var endDatePicker: DateTimePicker?
    var start_picker: DateTimePicker?
    var end_picker: DateTimePicker?
    var selectedLocation: CLLocation?
    var selectedAdress: String?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    

    
    //Search for Place w/ Auto Complete
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    // The current place and default location
    var selectedPlace: GMSPlace?
    let defaultLocation = CLLocation(latitude: 36.651600, longitude: -121.797800)
    
    let cookieLocation = PFObject(className: "CookieLocation")

    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var mapSubView: UIView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var locationPicButton: UIButton!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    
    // ------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cookieLocation["id"] = PFUser.current()
        cookieLocation["user"] = PFUser.current()
        
        //User current location
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        placesClient = GMSPlacesClient.shared()
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: 15)
        mapView = GMSMapView.map(withFrame: mapSubView.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        mapSubView.addSubview(mapView)
        mapView.isHidden = true
        
        // Search Bar ------------
        //Autocomplete for location search
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.backgroundImage = UIImage()
        searchController?.searchBar.placeholder = "Cookie Location"
        searchView.addSubview((searchController?.searchBar)!)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
        
    }
    
    // Date Picker ------------
    
        //Start Date
    @IBAction func onStartDate(_ sender: Any) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        
        picker.timeInterval = DateTimePicker.MinuteInterval.five
        
        picker.highlightColor = UIColor(red: 189/255.0, green: 69/255.0, blue: 255/255.0, alpha: 0.90)
        picker.darkColor = UIColor.black
        picker.doneButtonTitle = "DONE"
        picker.doneBackgroundColor = UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 0.90)
        picker.locale = Locale(identifier: "en_GB")
        
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa MM/dd/YYYY"
        picker.includeMonth = false // if true the month shows at top
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa MM/dd/YYYY"
        }
        picker.delegate = self
        self.start_picker = picker

    }
    
        //End Date
    @IBAction func onEndDate(_ sender: Any) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        
        picker.timeInterval = DateTimePicker.MinuteInterval.five
        
        picker.highlightColor = UIColor(red: 189/255.0, green: 69/255.0, blue: 255/255.0, alpha: 0.90)
        picker.darkColor = UIColor.black
        picker.doneButtonTitle = "DONE"
        picker.doneBackgroundColor = UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 0.90)
        picker.locale = Locale(identifier: "en_GB")
        
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa MM/dd/YYYY"
        picker.includeMonth = false // if true the month shows at top
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa MM/dd/YYYY"
        }
        picker.delegate = self
        self.end_picker = picker
        
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        startDatePicker = start_picker
        endDatePicker = end_picker

        startDateLabel.text = start_picker?.selectedDateString
        endDateLabel.text = end_picker?.selectedDateString
        
    }
    
    //---------
    
    func zoomToSearchedLocation(){
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(selectedAdress!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {return}
            self.selectedLocation = location
            
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: self.zoomLevel)
            let marker = GMSMarker()
            let placeMark = placemarks.first as? CLPlacemark
            marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.cookieLocation["longitude"] = location.coordinate.longitude
            self.cookieLocation["latitude"] = location.coordinate.latitude

            marker.title = placeMark?.name
            marker.snippet = placeMark?.locality
            marker.map = self.mapView
            if self.mapView.isHidden {
                self.mapView.isHidden = false
                self.mapView.camera = camera
            } else {
                self.mapView.animate(to: camera)
            }
        }
    }
    
    //Taking Cookie locaton picture
    @IBAction func addLocationImageButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        var editedImage = originalImage
        editedImage = resize(image: editedImage, newSize: CGSize(width: 300, height: 300))
        
        // Do something with the images
        locationImage.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height:newSize.height)))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // ------- 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    MARK: - Navigation

    In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}

extension AddCookieLocationViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        selectedLocation = location
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)

        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            var formatAddress: String = ""
            formatAddress = formatAddress + placeMark.name! + ","
            formatAddress = formatAddress + placeMark.locality! + ","
            formatAddress = formatAddress + placeMark.administrativeArea! + ","
            formatAddress = formatAddress + placeMark.postalCode! + ","
            formatAddress = formatAddress + placeMark.country!
            
            self.selectedAdress = formatAddress
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            marker.title = placeMark?.name
            marker.snippet = placeMark?.locality
            marker.map = self.mapView
            
            if self.mapView.isHidden {
                self.self.mapView.isHidden = false
                self.mapView.camera = camera
            } else {
                self.mapView.animate(to: camera)
            }
        })
    }
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}



extension AddCookieLocationViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        self.searchController?.searchBar.frame.size.width = self.searchView.frame.size.width
        searchController?.isActive = false
        
        selectedAdress = place.formattedAddress
        searchController?.searchBar.text = selectedAdress
        zoomToSearchedLocation()
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    @IBAction func addCookieLocation(_ sender: Any) {

        cookieLocation["start_time"] = startDateLabel.text!
        cookieLocation["end_time"] = endDateLabel.text!
        print(locationImage.debugDescription)
        cookieLocation["location_photo"] = AddCookieLocationViewController.getPFFileFromImage(image: locationImage.image)! // PFFile column type
        cookieLocation["girl_scount_verified"] = 1
        
            cookieLocation.saveInBackground { (success, error) in
                if success {
                    print("The location was saved!")
//                    self.chatMessageField.text = ""
                } else if let error = error {
                    print("Problem saving location: \(error.localizedDescription)")
                }
            }
//        }
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        } else {
            print ("no profile image chosen")
            let image : UIImage = UIImage(named:"profile_pic_placeholder")!
            
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}


