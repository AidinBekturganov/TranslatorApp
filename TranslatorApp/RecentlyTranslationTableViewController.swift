//
//  RecentlyTranslationTableViewController.swift
//  TranslatorApp
//
//  Created by User on 8/10/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import UIKit
import RealmSwift

class RecentlyTranslationTableViewController: UITableViewController {
    
    var model = Model()
    
    @IBOutlet weak var cleanBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        model.arrayOfTranslatedWords = realm.objects(Words.self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.arrayOfTranslatedWords?.count ?? 0
    }
    
    @IBAction func cleanBarButtonPressed(_ sender: Any) {
        let realm = RealmService.shared.realm
        try! realm.write {
            realm.deleteAll()
            tableView.reloadData()
        }
    }
    
    @IBAction func cancelBarButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForTranslation", for: indexPath) as! TranslatedWordsTableViewCell
        if model.arrayOfTranslatedWords!.isEmpty {
            
        } else {
            cell.words = model.arrayOfTranslatedWords?[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
