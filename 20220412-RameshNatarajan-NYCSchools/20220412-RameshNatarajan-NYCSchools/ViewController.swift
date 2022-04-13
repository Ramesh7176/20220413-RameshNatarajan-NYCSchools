//
//  ViewController.swift
//  20220412-RameshNatarajan-NYCSchools
//
//  Created by RAMESH NATARAJAN on 4/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let schoolName: [String] = ["NYC1", "NYC2", "NYC3"]
    let scoreDeatils = [ScoreData(reading: "10", writing: "20", math: "30"),
                        ScoreData(reading: "50", writing: "50", math: "50"),
                        ScoreData(reading: "150", writing: "250", math: "350")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "School Name"
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolName.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = schoolName[indexPath.row]
           return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = ScoreViewController(scoreDetail: scoreDeatils[indexPath.row])
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func jsonResult() {
        do {
            guard let url = Bundle.main.url(forResource: "SchoolResponse", withExtension: "json") else {
                return }
            
            let data = try Data(contentsOf: url)
            if let result = try? JSONDecoder().decode(SchoolResults.self, from: data) {
                print(result)
            }
        }
        catch {
            print(error)
        }
    }
    
}

class ScoreViewController: UIViewController {
    var scoreDetail: ScoreData?
    
    var readingLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var writingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mathLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(scoreDetail: ScoreData) {
        self.scoreDetail = scoreDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Score Details"
        guard let detailsData = scoreDetail else { return }
        readingLbl.text =  "Reading Score: " + detailsData.reading
        writingLabel.text = "Writing Score: "  + detailsData.writing
        mathLabel.text = "Math Score: "  + detailsData.math
        
        self.view.addSubview(readingLbl)
        self.view.addSubview(writingLabel)
        self.view.addSubview(mathLabel)

        
        readingLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  100).isActive = true
        readingLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        readingLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        writingLabel.topAnchor.constraint(equalTo: readingLbl.bottomAnchor, constant:  20).isActive = true
        writingLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        writingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        mathLabel.topAnchor.constraint(equalTo: writingLabel.bottomAnchor, constant:  20).isActive = true
        mathLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        mathLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
