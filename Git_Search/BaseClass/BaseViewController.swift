//
//  BaseViewController.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar

class BaseViewController: UIViewController {

    public var appDelegate : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}


// MARK : Utility Methods


extension BaseViewController{
    
    open func showAlert(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    open func getDate(_ date: String, isTimeRequried : Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        if let finalDate = dateFormatter.date(from: date) {
            let formatter = DateFormatter()
            formatter.dateFormat = isTimeRequried ? "h:mm a 'on' MMM dd, yyyy" : "MMM dd, yyyy"
            return formatter.string(from: finalDate)
        }
        return "<None>"
    }
    
    func showBanner(_ message: String) {
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        snackbar.show()
    }
    
    @objc open func dissmissKeyBoardAndResetData(){
        self.view.endEditing(true)
    }
}


// MARK : MBProgressHUD Methods

extension BaseViewController {
    
    open func showHUD(inView : UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = LOADING_HUD.LOADING.rawValue
        hud.detailsLabel.text = LOADING_HUD.WAIT.rawValue
    }
    
    open func hideHUD(forView:UIView) {
        MBProgressHUD.hide(for: forView, animated: true)
    }
}


extension BaseViewController{
    
    func theBroadCaster(_ tableView : UITableView, message : String){
        let messageView =  UIView(frame: CGRect(x: (view.frame.width * 0.1),
                                                y: (view.frame.height * 0.1),
                                                width: self.view.frame.width,
                                                height: (view.frame.height * 0.4)))
        let label = UILabel(frame: CGRect(x: 0, y: 0,
                                          width: messageView.frame.width,
                                          height: messageView.frame.height))
        label.text = message
        label.textColor = .gray
        label.font = UIFont(name: H_FONT,
                            size: 18.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        messageView.addSubview(label)
        tableView.backgroundView = messageView
        tableView.separatorStyle = .none
    }
}
