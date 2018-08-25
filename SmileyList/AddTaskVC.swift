import UIKit

class AddTaskVC: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var needSmiley: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveTapped(_ sender: Any) {
        
        let guest = UIApplication.shared.delegate as! AppDelegate

        let context = guest.persistentContainer.viewContext

        //NSManagedObjectContext
        let task = Task(context: context)
        
        if let name = textField.text {
            task.name = name
            task.smiley = needSmiley.isOn
        }
        
        
        //register the values in database
        guest.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
}






















