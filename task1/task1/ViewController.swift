//
//  ViewController.swift
//  task1
//
//  Created by Body Block on 05/02/2020.
//  Copyright © 2020 Body Block. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let cellIdentifier = "ImageCell"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let imageFetcher = ImageFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // MARK: - Data
    private func downloadImage(withURL url: URL, for cell: UITableViewCell) {
        imageFetcher.downloadImage(withURL: url) { (image, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let image = image {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
    }
    
    private func imageURL(forIndexPath indexPath: IndexPath) -> URL? {
        let stringURL = "https://placehold.it/375x150?text=\(indexPath.row + 1)"
        guard let url = URL(string: stringURL) else { return nil }
        return url
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: ViewController.cellIdentifier)
        }
        
        cell?.textLabel?.text = "Index: \(indexPath.row + 1)"
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.image = nil
        guard let imageURL = imageURL(forIndexPath: indexPath) else { return }
        downloadImage(withURL: imageURL, for: cell)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell.imageView?.image == nil, let url = imageURL(forIndexPath: indexPath) else { return }
        imageFetcher.cancelTask(forURL: url)
        
    }
}

