//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by mac on 21/03/24.
//

import Foundation
import UIKit


class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(image : UIImage,imageName : String,folderName : String)
    {
        //Create Folder
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url = getURLforImage(imageName: imageName, folderName: folderName) else { return }
        
        //Save Image to Path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving Image, \(error)")
        }
    }
    
    
    //Get image from Folder
    func getImage(imageName : String,folderName : String) -> UIImage?
    {
        guard let url = getURLforImage(imageName:imageName , folderName: folderName),FileManager.default.fileExists(atPath: url.path) else { return nil}
        return UIImage(contentsOfFile: url.path)
    }
    
    //Create Folder if not Exist
    func createFolderIfNeeded(folderName : String)
    {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path)
        {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating Folder, \(error)")
            }
        }
    }
        
    //Get Url of Folder Where Image is Stored
    func getURLForFolder(folderName : String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
//        print(url)
        return url.appendingPathComponent(folderName)
    }
    
    
    //Get url for Image
    func getURLforImage(imageName : String,folderName : String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
