//
//  ViewController.swift
//  Project21
//
//  Created by Muhammed Burkay Şendoğdu on 30.07.2022.
//

import UIKit
import UserNotifications
class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge,.sound]) { grated, error in
            if grated{
                print("Yes")
            }else{
                print("Fuck")
            }
        }
    }
    @objc func scheduleLocal(){
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() /* bekleyen bildirimleri (yani, tetikleyicileri karşılanmadığı için henüz teslim edilmemiş olan planladığınız bildirimleri) iptal eder. */
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "You have to wake up early every morning!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 06
//        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    func registerCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self /* gönderilen tüm notificationlar işlenmek üzere bize geri dönecek.*/
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground) /* Button oluşturuyor.*/
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String{
            print("Custom data recevied \(customData)")
            
            switch response.actionIdentifier{
            case UNNotificationDefaultActionIdentifier: print("Default Identifier")
            case "show": print("Show more information")
            default: break
            }
        }
        
    }
}

