//
//  ViewController.swift
//  PokemonCharmander
//
//  Created by Deniz Baran SERBEST on 16.04.2023.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    var myImage = UIImageView()
    var myLabel = UILabel()
    let myButton = UIButton()
    let againButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmode()
        faceID()
        viewtools()
    }
    
    func viewmode () {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        if userInterfaceStyle == .dark {
            myButton.setTitleColor(.red, for: .normal)
            againButton.setTitleColor(.white, for: .normal)
            view.backgroundColor = .black
        } else {
            myButton.setTitleColor(.red, for: .normal)
            againButton.setTitleColor(.black, for: .normal)
            view.backgroundColor = .yellow
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        viewmode()
        faceID()
        viewtools()
    }
    
    @objc func faceID() {
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                if success == true {
                    DispatchQueue.main.async { [self] in
                        myLabel.text = "Success!"
                        myButton.isHidden = false
                        againButton.isHidden = true
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        myLabel.text = "Error!"
                        myButton.isHidden = true
                        againButton.isHidden = false
                    }
                }
            }
        }
        
    }
    
    func viewtools() {
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        myImage.image = nil
        myImage.frame = CGRect(x: width * 0.5 - 120, y: height * 0.5 - 250, width: 240, height: 240)
        view.addSubview(myImage)
        
        myLabel.text = ""
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.5, width: width * 0.8, height: 50)
        view.addSubview(myLabel)
        
        myButton.setTitle("Start", for: UIControl.State.normal)
        myButton.frame = CGRect(x: width * 0.5 - 100, y: height * 0.6, width: 200, height: 100)
        view.addSubview(myButton)
        againButton.setTitle("Try Again FaceID", for: UIControl.State.normal)
        againButton.frame = CGRect(x: width * 0.5 - 100, y: height * 0.6, width: 200, height: 100)
        view.addSubview(againButton)
        
        againButton.isHidden = true
        againButton.addTarget(self, action: #selector(faceID), for: .touchUpInside)
        myButton.isHidden = true
        myButton.addTarget(self, action: #selector(myAction), for: .touchUpInside)
    }
    
    @objc func myAction() {
        if let image = myImage.image {
            if image == UIImage(named: "charmander") {
                myImage.image = UIImage(named: "charmeleon")
                myLabel.text = "charmeleon"
                myButton.setTitle("get bigger", for: .normal)
            } else if image == UIImage(named: "charmeleon") {
                myImage.image = UIImage(named: "charizard")
                myLabel.text = "charizard"
                myButton.setTitle("start over", for: .normal)
            } else if image == UIImage(named: "charizard") {
                myImage.image = UIImage(named: "charmander")
                myLabel.text = "charmander"
                myButton.setTitle("get bigger", for: .normal)
            }
        } else {
            myImage.image = UIImage(named: "charmander")
            myLabel.text = "charmander"
            myButton.setTitle("get bigger", for: .normal)
        }
    }
    
}
