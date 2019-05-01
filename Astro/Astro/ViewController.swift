//
//  ViewController.swift
//  Astro
//
//  Created by misha on 4/22/19.
//  Copyright © 2019 misha. All rights reserved.
//

import UIKit

struct Welcome: Codable {
    var data: [Datum]
    var result: String
}
struct Datum: Codable {
    var description: Description
    var header: String
    var pih:Description
    var img:String
    var pis:Description
    var natalText:[Description]?
}
struct Description: Codable {
    var title, content: String
}
class ViewController: UIViewController {
    
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    let dataPicker = UIDatePicker()
    private var datePicker: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateTextField.inputView = dataPicker
        dataPicker.datePickerMode = .date
        //let localeID = Locale.preferredLanguages.first
        //dataPicker.locale = Locale(identifier: localeID!)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace,doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
    }
  
 
    

   
    @objc func doneAction(){
        getDateFromPicker()
        view.endEditing(true)
        
    }
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = formatter.string(from: dataPicker.date)
    }
    
    
    @IBAction func GetApiAboutMe(_ sender: UIButton) {
        
        let httpdatetext = String(dateTextField.text!)
        let httpurltext = "http://nc-test.stemsc.com/api/about_me/?date_birth=" + httpdatetext
        guard let url = URL(string:httpurltext) else {return}
        
        let session = URLSession.shared
       session.dataTask(with: url){(data, response, error) in
           if let response = response{
               print(response)
           }
           guard let data = data else {return}
           do{
            let jsonText = try JSONDecoder().decode(Welcome.self, from: data)
            
           }catch{
                print(error)
           }
        }.resume()
        
    }
}
