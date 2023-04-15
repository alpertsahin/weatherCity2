//çok garip gerçekten

import UIKit
import CoreLocation

class HomePageVC: UIViewController, UITextFieldDelegate {

 
    let navBarAppearance = UINavigationBarAppearance()
    let label = UILabel()
    let emptyText = UILabel()
    let locationText = UITextField()
    lazy var myTemperature = UILabel()
    let buttonSelected = UIButton()
    let apiKey = "9d9312c7bc935be67923bbbbe4fe4b31"
    let cityName = UILabel()
    var durum = UILabel()
    var nemlilik = UILabel()
    let turkishCharacters = ["ç": "c", "ğ": "g", "ı": "i", "ö": "o", "ş": "s", "ü": "u"]

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        
     
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    

    func configure () {
        //navigasyon bar
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.backgroundColor = .systemBlue
       
        label.text = "HAVA DURUMU"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .blue
        
  
    
        emptyText.text = "Bir lokasyon seçiniz."
        emptyText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyText)
        
        emptyText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyText.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 250).isActive = true
        emptyText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        emptyText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        emptyText.textColor = .white
        
        locationText.placeholder = "Lokasyon seçiniz..."
        locationText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationText)
        locationText.borderStyle = .roundedRect
        
        locationText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationText.topAnchor.constraint(equalTo: emptyText.bottomAnchor, constant: 30).isActive = true
        locationText.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10).isActive = true
        locationText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        locationText.delegate = self
        
        let backgroundImage = UIImage(named: "acikbulut")
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        buttonSelected.addTarget(self, action: #selector(citySelected), for: .touchUpInside)
        
  
        
        cityName.text = "Şehir"
        cityName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityName)
        
        cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityName.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        
        cityName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        cityName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        cityName.font = UIFont.systemFont(ofSize:50)
        cityName.textColor = .white
        
        myTemperature.translatesAutoresizingMaskIntoConstraints = false
        myTemperature.text = "Sıcaklık"
        myTemperature.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(myTemperature)
        myTemperature.textColor = .black
   
        myTemperature.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        myTemperature.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        myTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTemperature.textColor = .white
        myTemperature.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 16).isActive = true
        
        
        durum.text = "Hissedilen Sıcaklık"
        durum.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(durum)
        durum.font = UIFont.systemFont(ofSize: 24)
        durum.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        durum.topAnchor.constraint(equalTo: myTemperature.bottomAnchor, constant: 5).isActive = true
        durum.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        durum.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        
    
        durum.textColor = .white
        
        nemlilik.text = "Nemlilik"
        nemlilik.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nemlilik)
        
        nemlilik.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nemlilik.topAnchor.constraint(equalTo: durum.bottomAnchor, constant: 5).isActive = true
        nemlilik.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        nemlilik.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        
        nemlilik.font = UIFont.systemFont(ofSize: 24)
        nemlilik.textColor = .white
        
        
        buttonSelected.translatesAutoresizingMaskIntoConstraints = false
        buttonSelected.setTitle("Seç", for: .normal)
        view.addSubview(buttonSelected)
        buttonSelected.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonSelected.topAnchor.constraint(equalTo: locationText.bottomAnchor, constant: 20).isActive = true
        buttonSelected.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        buttonSelected.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        buttonSelected.backgroundColor = .blue
        buttonSelected.tintColor = .white
        buttonSelected.bottomAnchor.constraint(equalTo: locationText.bottomAnchor,constant: 60).isActive = true
        buttonSelected.layer.cornerRadius = 10
        

        
    }
    
 

    
    // UITextFieldDelegate metodu - Klavye açılacak
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    // Klavye kapanacak
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func citySelected () {
        let city = locationText.text ?? ""
        if city.isEmpty {
            let alert = UIAlertController(title: "Hata", message: "Lütfen Lokasyon Seçiniz", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Geri", style: .cancel)
            alert.addAction(cancelButton)
            self.present(alert, animated: true)
        }
        else{
            cityName.text = city
            var cityNameWithoutTurkishCharacters = cityName.text?.lowercased()
            for (turkishCharacter, englishEquivalent) in turkishCharacters {
                cityNameWithoutTurkishCharacters = cityNameWithoutTurkishCharacters?.replacingOccurrences(of: turkishCharacter, with: englishEquivalent)
            }

            if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameWithoutTurkishCharacters ?? "")&appid=\(apiKey)") {
                let request = URLRequest(url:url)
                let task = URLSession.shared.dataTask(with: request) {(data,request,error) in
                    if error == nil {
                        if let incomingData = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                print(json)
                                if let main = json["main"] as? NSDictionary {
                                    if let temp = main["temp"] as? Double {
                                        let state = String("Sıcaklık: \(Int(temp - 273.15)) Derece")
                                        DispatchQueue.main.sync {
                                            self.myTemperature.text = String(state)
                                            
                                        }
                                    }
                                    
                                }
                               
                                
                            }catch{
                                print("Bir Hata Oluştu")
                            }
                        }
                        
                        if let incomingData = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                print(json)
                                if let main = json["main"] as? NSDictionary {
                                    if let feels_like = main["feels_like"] as? Double {
                                        let state = String("Hissedilen Sıcaklık: \(Int(feels_like - 273.15)) Derece")
                                        DispatchQueue.main.sync {
                                            self.durum.text = String(state)
                                          
                                        }
                                    }
                                    
                                }
                               
                                
                            }catch{
                                print("Bir Hata Oluştu")
                            }
                        }
                        
                        if let incomingData = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                print(json)
                                if let main = json["main"] as? NSDictionary {
                                    if let feels_like = main["feels_like"] as? Double {
                                        let state = String("Hissedilen Sıcaklık: \(Int(feels_like - 273.15)) Derece")
                                        DispatchQueue.main.sync {
                                            self.durum.text = String(state)
                                          
                                        }
                                    }
                                    
                                }
                               
                                
                            }catch{
                                print("Bir Hata Oluştu")
                            }
                        }
                        
                        if let incomingData = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                print(json)
                                if let main = json["main"] as? NSDictionary {
                                    if let humidity = main["humidity"] as? Double {
                                        let state = String("Nem: %\(Int(humidity))")
                                        DispatchQueue.main.sync {
                                            self.nemlilik.text = String(state)
                                          
                                        }
                                    }
                                    
                                }
                               
                                
                            }catch{
                                print("Bir Hata Oluştu")
                            }
                        }
                        
                        
                    }
                    
                    
                    
                }
                task.resume()
            }
        }
    }
    
   
    
    
    
}
