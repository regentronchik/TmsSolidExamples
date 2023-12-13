

// Пример SRP - 1
// Класс Order отвечает только за обработку заказов

class Order {
    var orderId: Int
    var customerName: String
    var orderItems: [String]
    
    init(orderId: Int, customerName: String, orderItems: [String]) {
        self.orderId = orderId
        self.customerName = customerName
        self.orderItems = orderItems
    }
    
    func placeOrder() {
        // Логика для размещения заказа
    }
    
    func calculateTotal() -> Double {
        // Логика для вычисления общей суммы заказа
        return 0.0
    }
    
    func generateInvoice() {
        // Логика для создания счета
    }
}
// Пример SRP - 2
// Calculator отвечает только за выполнение математических операций и ничем другим (ни обработкой данных ни взаимодействием с пользовательским интерфейсом)

class Calculator {
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func subtract(a: Int, b: Int) -> Int {
        return a - b
    }
    
    func multiply(a: Int, b: Int) -> Int {
        return a * b
    }
    
    func divide(a: Int, b: Int) -> Int {
        return a / b
    }
}


// Пример OCP - 1
// Допустим у меня есть протокол с методом shot()

protocol Shooting {
    func shoot() -> String
}
//Этот класс имеет метод shot() и может стрелять
final class LaserBeam: Shooting {
    func shoot() -> String {
        return "Piy"
    }
}
// У класса WeaponsComposite есть массив оружия и он может стрелять из него всего сразу

final class WeaponsComposite {    
    let weapons: [Shooting]
    init(weapons: [Shooting]) {
        self.weapons = weapons
    }
    func shoot()
}
//  Ниже Rocket Launcher и он может стрелять ракетами. Чтобы добавить поддержку ракетных установок в класс Weapons Composite, мне не нужно ничего менять в существующих классах, таким образом я могу добавлять и дальше новые виды вооружения

final class RocketLauncher: Shooting {
    func shoot() -> String {
        return "Bum"
    }
}



// Пример OCP - 2
// UserManager открыт для расширения, но закрыт для изменения, если нужно добавить новый способ записи логов, можно создать новый класс, который будет реализовывать протокол Logger

protocol Logger {
    func log(message: String)
}

class ConsoleLogger: Logger {
    func log(message: String) {
        // вывод в консоль
    }
}

class FileLogger: Logger {
    func log(message: String) {
        // вывод в файл
    }
}

class UserManager {
    var logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func addUser(name: String, email: String, password: String) {
        // добавление нового пользователя в бд
        logger.log(message: "Добавлен новый пользователь: \(name)")
    }
}

// Пример LSP - 1
// Car и Bicycle наследуются от Vehicle и переопределяют методы в соответствии с их поведением, объекты типа Car и Bicycle могут использоваться вместо объекта типа Vehicle без нарушения поведения базового класса Vehicle
class Vehicle {
    func startEngine() {
        fatalError("This method should be overridden")
    }

    func accelerate() {
        fatalError("This method should be overridden")
    }

    func stopEngine() {
        fatalError("This method should be overridden")
    }
}

class Car: Vehicle {
    override func startEngine() {
        print("Car: Engine started")
    }

    override func accelerate() {
        print("Car: Accelerating")
    }

    override func stopEngine() {
        print("Car: Engine stopped")
    }
}

class Bicycle: Vehicle {
    override func startEngine() {
        fatalError("Bicycles don't have engines")
    }
    override func accelerate() {
        print("Bicycle: Pedaling faster")
    }
    override func stopEngine() {
        fatalError("Bicycles don't have engines")
    }
}

func performRace(vehicle: Vehicle) {
    vehicle.startEngine()
    vehicle.accelerate()
    vehicle.stopEngine()
}

let car = Car()
let bicycle = Bicycle()

performRace(vehicle: car)
performRace(vehicle: bicycle)

// Пример LSP - 2
// По сути и ручка и карандаш рисуют, только разными способами, главное дать любой предмет, который способен рисовать наследуя от протокола Drawing

protocol Drawing {
    var color: UIColor { get }
}

class Pen: Drawing {
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
}


class Pencil: Drawing {
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
}
// Класс Ребенка, который может рисовать всем, что может рисовать
class Child {
    func drawHouse(with item: Drawing) {
        print("House color: ", item.color)
    }
}
let bluePen = Pen(color: .blue)
let blackPencil = Pencil(color: .black)
let bob = Child()

bob.drawHouse(with: bluePen)
bob.drawHouse(with: blackPencil)






// Пример ISP - 1
//  Классы Printer, Scanner и FaxMachine реализуют интерфейсы Printable, Scanable и Faxable. Класс MultiFunctionalPrinter реализует все три интерфейса, так как он объединяет функциональность всех трех устройств, что соответствует принципу разделения интерфейса, так как каждый класс отвечает только за свою конкретную функциональность
protocol Printable {
    func printDocument()
}

protocol Scanable {
    func scanDocument()
}

protocol Faxable {
    func sendFax()
}

class Printer: Printable {
    func printDocument(document: String) {
        // печать документа
    }
}

class Scanner: Scanable {
    func scanDocument() {
        // сканирование документа
    }
}

class FaxMachine: Faxable {
    func sendFax() {
        // отправка факса
    }
}

class MultiFunctionalPrinter: Printable, Scanable, Faxable {
    func printDocument(document: String) {
        // печать документа
    }
    
    func scanDocument() {
        // сканирование документа
    }
    
    func sendFax() {
        // отправка факса
    }
}

// Пример ISP - 2
// Класс Drone не имеет функциональности для поворота, поэтому он не реализует Rotatable

protocol Movable {
    var speed: Double { get set }
    func move()
}

protocol Rotatable {
    var angle: Double { get set }
    func rotate()
}

class Car: Movable, Rotatable {
    var speed: Double
    var angle: Double
    func move() {
        // движение машины
    }
    
    func rotate() {
        // поворот машины
    }
}
class Drone: Movable {
    var speed: Double
    
    func move() {
        // движение дрона
    }
}



// Пример DIP - 1
// Класс DataManager зависит от абстракции Database, а не от конкретной реализации, поэтому можно легко заменить используемую базу данных на другую, не изменяя код класса DataManager.


protocol Database {
    func save(data: String)
}

class Postgres: Database {
    func save(data: String) {
        // сохранение данных в Postgres
    }
}

class MariaDB: Database {
    func save(data: String) {
        // сохранение данных в MariaDB
    }
}

class DataManager {
    private let database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    func saveData(data: String) {
        // сохранение данных
        database.save(data: data)
    }
}


// Пример DIP - 2
//По сути очень похоже на принцип открытости/закрытости

protocol EmailSender {
    func sendEmail(to recipient: String, subject: String, body: String)
}

class SmtpEmailSender: EmailSender {
    func sendEmail(to recipient: String, subject: String, body: String) {
        // отправка email через SMTP
    }
}

class LmtpEmailSender: EmailSender {
    func sendEmail(to recipient: String, subject: String, body: String) {
        // отправка email через Lmtp
    }
}

class EmailManager {
    private let emailSender: EmailSender
    
    init(emailSender: EmailSender) {
        self.emailSender = emailSender
    }
    func sendEmail(to recipient: String, subject: String, body: String) {
        // отправка email
        emailSender.sendEmail(to: recipient, subject: subject, body: body)
    }
}
//вызову
let Lmtp = LmtpEmailSender()
let send = EmailManager(sendEmail: Lmtp)
// и т.д.



