//
//  ModelPersistentStorage.swift
//  tabWeather
//
//  Created by Павел Губарев on 08.04.2021.
//

import Foundation
import CoreData
import UIKit

extension Model {
    
    func initCoreData() {
        managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    }
    
    func cleanForecast() {
        deleteAllData("Forecast")
    }
    
    func readForecast() -> FullForecast? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Forecast")
        
        var forecast = FullForecast()
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData : NSManagedObject = managedObject
                                
                guard let date = managedObjectData.value(forKey: "date") as? Date else { return nil }
                guard let temp = managedObjectData.value(forKey: "temperature") as? Double else {return nil}
                let oneday = ForecastOneDay(date: date, temp: temp)
                forecast.append(oneday)
            }
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
        return forecast
    }
    
    func saveForecast(forecastData: FullForecast) {
        
        cleanForecast()
      
        let entity =
            NSEntityDescription.entity(forEntityName: "Forecast",
                                       in: managedContext)!        
        
        for oneDayForecast in forecastData {
            let oneDayForecastEntity = NSManagedObject(entity: entity, insertInto: managedContext)
            oneDayForecastEntity.setValue(oneDayForecast.date, forKey: "date")
            oneDayForecastEntity.setValue(oneDayForecast.temp, forKey: "temperature")
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do
            {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    managedContext.delete(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
            }
    }
    
}
