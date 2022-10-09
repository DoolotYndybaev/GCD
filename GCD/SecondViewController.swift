//
//  SecondViewController.swift
//  GCD
//
//  Created by Doolot on 9/10/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        // get - это блок кода когда хотим получить значение image
        get {
            return imageView.image
        }
        // set - это блок кода для устонавки нового значения для свойства
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, clouser: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: clouser)
    }
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        present(ac, animated: true)
    }
    fileprivate func fetchImage() {
       imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        // когда у нас начнется загрузка данных должен начать работать наш
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            //        второй болле короткий метод
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        
        // первый метод
        // если такой адресс существует
//        if let url = imageURL {
//            let imageData = try? Data(contentsOf: url)
//            if imageData != nil {
//                self.image = UIImage(data: imageData!)
//            } else {
//                self.image = nil
//            }
//        }
    }
}
