import UIKit

class MainVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //Empty Array Variable of Entity Task
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        grabData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        grabData()
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        //Good way
        if let name = task.name {
            if task.smiley {
                cell.textLabel?.text = "😃 \(name)"
            }else{
                cell.textLabel?.text = "\(name)"
            }
        }
        //Bad way
//        if task.smiley {
//            cell.textLabel?.text = "😃\(task.name!)"
//        }else{
//            cell.textLabel?.text = "\(task.name!)"
//        }
        
        return cell
    }
    
    
    func grabData(){
        let guest = UIApplication.shared.delegate as! AppDelegate
        
        let context = guest.persistentContainer.viewContext
        
        do{
            tasks = try context.fetch(Task.fetchRequest())
        }catch{
            print("failed to fetch from coredata")
        }
        
    }
    
    
    //Delete Rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let guest = UIApplication.shared.delegate as! AppDelegate
        
        let context = guest.persistentContainer.viewContext
        
        if editingStyle == .delete{
            let task = self.tasks[indexPath.row]
            context.delete(task)
            guest.saveContext()
            
            grabData()
            tableView.reloadData()
        }
    }
}

