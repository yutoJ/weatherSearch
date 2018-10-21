//
//  TableViewController.swift
//  weatherInfo
//
//  Created by yuto_o on 2018/10/21.
//  Copyright © 2018 yuto_o. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TableViewController: UITableViewController {
    
    var urlString = "https://api.openweathermap.org/data/2.5/forecast?units=metric&q=Tokyo&APPID="
    var cellItems = NSMutableArray()
    let cellNum = 2
    var selectedInfo : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTableData2()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellNum
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        // Configure the cell...
        if self.cellItems.count > 0 {
            cell.textLabel?.text = self.cellItems[indexPath.row] as? String
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        _ = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        self.selectedInfo = self.cellItems[indexPath.row] as? String
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toDetail") {
            let viewController : ViewController = segue.destination as! ViewController
            viewController.info = self.selectedInfo
        }
    }
    
    func makeTableData() {
        let url = URL(string: self.urlString)!
        do {
            let session =  URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                guard let data = data else {
                    print ("data was nil?")
                    return
                }
                let json = try! JSON(data: data)
                for i in 0..<self.cellNum {
                    let dt_txt = json["list"][i]["dt_txt"]
                    let weatherMain = json["list"][i]["weather"][0]["main"]
                    let weatherDescription = json["list"][i]["weather"][0]["description"]
                    let info = "\(dt_txt), \(weatherMain), \(weatherDescription)"
                    print(info)
                    self.cellItems[i] = info
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            print("session")
            session.resume()
            self.tableView.reloadData()
        } catch let error as NSError {
            // error
        }
    }
    
    func makeTableData2() {
        let url = URL(string: self.urlString)!
        Alamofire.request(url, method: .get)
        .responseJSON { response in
            switch response.result {
            case .success:
                print(response)
                print(response.result.value)
                let json = JSON(response.result.value!)
                for i in 0..<self.cellNum {
                    let dt_txt = json["list"][i]["dt_txt"]
                    let weatherMain = json["list"][i]["weather"][0]["main"]
                    let weatherDescription = json["list"][i]["weather"][0]["description"]
                    let info = "\(dt_txt), \(weatherMain), \(weatherDescription)"
                    print(info)
                    self.cellItems[i] = info
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
