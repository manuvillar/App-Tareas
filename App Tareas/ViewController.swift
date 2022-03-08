//
//  ViewController.swift
//  App Tareas
//
//  Created by Manuel J. Villar on 8/3/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    var tareas = [NSManagedObject]()
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UITableViewCell.self, forCellReuseIdentifier: "Celda")    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "Celda")
        let tarea = tareas[indexPath.row]
        celda!.textLabel!.text=tarea.value(forKey: "NombreTarea")as?String
        return celda!

    }
    @IBAction func AñadeTarea(_ sender: Any) {
        //Crear un UIAlertController
        let alerta = UIAlertController(title: "Nueva Tarea", message: "Añade una nueva tarea", preferredStyle: .alert)
        
        //Creamos el UIAlertAction para guardar la tarea.
        let guardarAction = UIAlertAction(title: "Guardar", style: .default,
                                          handler: {(action:UIAlertAction)-> Void in
            //Guardamos el texto del textField en el array tasks y recargamos la table view
            let CampoTexto = alerta.textFields!.first
            self.guardarTarea(name:CampoTexto!.text!)
            self.TableView.reloadData()
        })
        
        //Creamos el UIAlertAction que nos permitirá cancelar
        let cancelarAction = UIAlertAction(title: "Cancelar",
             style: .default) { (action: UIAlertAction) -> Void in
           }
        
        //Añadimos el TextField al UIAlertController
        alerta.addTextField {
             (textField: UITextField) -> Void in
           }
        
        //Añadimos las dos UIAlertAction que hemos creado al UIAlertController
        alerta.addAction(guardarAction)
        alerta.addAction(cancelarAction)
        
        //Lanzamos el UIAlertController
        present(alerta, animated: true, completion: nil)
    }
    
    func guardarTarea(nombreTarea: String){
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entidad = NSEntityDescription.entity(forEntityName: "Tarea", in: managedContext)
        let tarea = NSManagedObject(entity: entidad!, insertInto: managedContext)
        
        //3
        tarea.setValue(nombreTarea, forKey: "nombreTarea")
        
        //4
        do {
             try managedContext.save()
        //5
             tareas.append(tarea)
           } catch let error as NSError {
             print("No ha sido posible guardar \(error), \(error.userInfo)")
           }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest : NSFetchRequest<Task> = tareas.fetchRequest()

    }

}

