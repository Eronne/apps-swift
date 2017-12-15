//
//  MasterViewController.swift
//  Le Monde
//
//  Created by LETUE Erwann on 14/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var modelController = ModelController()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "rssLoadedNotifications"), object: nil, queue: nil) {
            (notification) in print("RSS loaded, reloading TableView")
            self.tableView.reloadData()
        }
        modelController.loadRSS()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let article = modelController.articles[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = article
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell

        let article = modelController.articles[indexPath.row]
        cell.titleLabel!.text = article.title
        cell.chapoLabel!.text = article.chapo
        
        if let image = article.image {
            cell.photoView!.image = image
            article.image = nil
        } else {
            loadImage(article.imageAdress, forRowAt: indexPath)
        }
        
        return cell
    }
    
    func loadImage(_ address: String?, forRowAt indexPath: IndexPath) {
        if let link = address {
            if let url = URL(string: link) {
                DispatchQueue.global(qos: .background).async {
                    do {
                        let imageData = try Data(contentsOf: url)
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.modelController.articles[indexPath.row].image = image
                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                    catch {
                        print("Error getting Image")
                    }
                }
            }
        }
    }
}

