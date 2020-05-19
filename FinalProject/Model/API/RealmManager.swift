//
//  RealmManager.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/11/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    typealias Completion = (RealmResult) -> Void
    
    enum RealmResult {
        case sucessful
        case failture(RealmError)
    }
    
    enum RealmError: Error {
        case errorConfig
        case error(String)
        case errorOutTransaction
    }
    
    static let shared = RealmManager()
    var realm: Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("Realm is no exist")
        }
    }
    
    private init() {}
}

extension RealmManager {
    func fetchObject<T: Object>(type: T.Type, completion: Completion) -> [T] {
        guard let realm = realm else {
            completion(.failture(.error("Realm is not exist")))
            return []
        }
        var objects: [T] = []
        let realmObject = realm.objects(type)
        realmObject.forEach { objects.append($0) }
        completion(.sucessful)
        return objects
    }
    
    func writeObject(action: () -> Void, completion: Completion? = nil) {
        guard let realm = realm else {
            completion?(.failture(.errorConfig))
            return
        }
        do {
            try realm.write {
                if realm.isInWriteTransaction {
                    action()
                    completion?(.sucessful)
                } else {
                    completion?(.failture(.errorOutTransaction))
                }
            }
        } catch let err {
            completion?(.failture(.error(err.localizedDescription)))
        }
    }
    
    func addObject<T: Object>(with object: T, completion: Completion? = nil) {
        writeObject(action: {
            realm?.add(object)
        }, completion: completion)
    }
    
    func deleteAllObject<T: Object>(with objects: [T], completion: Completion? = nil) {
        writeObject(action: {
            realm?.delete(objects)
        }, completion: completion)
    }
    
    func deleteObject<T: Object>(with object: T, completion: Completion? = nil) {
        writeObject(action: {
            realm?.delete(object)
        }, completion: completion)
    }
}
