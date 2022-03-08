//
//  ViewController.swift
//  App Tareas
//
//  Created by Manuel J. Villar on 8/3/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var tareas = [String]()
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UITableViewCell.self, forCellReuseIdentifier: "Celda")    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "Celda")
           celda!.textLabel!.text = tareas[indexPath.row]
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
            self.tareas.append(CampoTexto!.text!)
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
    
    

}

