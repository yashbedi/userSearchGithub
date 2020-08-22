//
//  RecentsViewController.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit


final class RecentsViewController: BaseViewController {
    

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = UISearchBar.Style.prominent
        search.placeholder = " Search offline.."
        search.isTranslucent = false
        search.backgroundImage = UIImage()
        search.delegate = self
        return search
    }()
    
    private lazy var recentsTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CachedCell.self,
                                 forCellReuseIdentifier: kCachedCell)
        table.keyboardDismissMode = .onDrag
        table.tableFooterView = UIView()
        table.contentInset = UIEdgeInsets.zero
        table.separatorStyle = .none
        return table
    }()
    
    private var recentSearchedArray = Array<UserDetailsModel>()
    private var filteredArray = Array<UserDetailsModel>()
    private var isSearchOn : Bool = false
 
    override func viewDidLoad(){
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recentSearchedArray = CoreDataUtility.shared.retireveUsers()
        recentsTableView.reloadWithAnimation()
    }
    
    override func dissmissKeyBoardAndResetData() {
        super.dissmissKeyBoardAndResetData()
        filteredArray.removeAll()
        recentsTableView.reloadData()
    }
}

private extension RecentsViewController {
    
    func setUI(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(50)
        }
        view.addSubview(recentsTableView)
        recentsTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(searchBar.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}


extension RecentsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchOn ? filteredArray.count : recentSearchedArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 50 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCachedCell, for: indexPath) as! CachedCell
        let user = isSearchOn ? filteredArray[indexPath.row] : recentSearchedArray[indexPath.row]
        cell.setData(name: user.login ?? "",
                     location: user.location ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = isSearchOn ? filteredArray[indexPath.row] : recentSearchedArray[indexPath.row]
        guard
            let url = URL(string: user.htmlURL ?? "") else { return }
        UIApplication.shared.openURL(url)
    }
}


extension RecentsViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        super.dissmissKeyBoardAndResetData()
        searchBar.text = ""
        isSearchOn = false
        recentsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchOn = true
        guard searchText.count == 0
            else {
            fileterItUp(searchText)
            return
        }
        isSearchOn = false
        recentsTableView.reloadData()
    }
    
    private func fileterItUp(_ text : String) {
        filteredArray = recentSearchedArray.filter({ (user) -> Bool in
            if((user.login ?? "").lowercased().contains(text.lowercased())) ||
                (user.name ?? "").lowercased().contains(text.lowercased()) ||
                (user.location ?? "").lowercased().contains(text.lowercased()){
                return true
            }
            return false
        })
        recentsTableView.reloadData()
    }
}
