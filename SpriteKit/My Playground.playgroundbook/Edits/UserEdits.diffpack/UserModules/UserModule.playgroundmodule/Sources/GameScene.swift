import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    // VIP VARIABLES
    let numberOfPeople = 5
    let maxPersonSpeed: UInt32 = 100
    var socialDistancingLength: CGFloat = 1.5
    
    var player: SKSpriteNode!
    var people = [SKSpriteNode]()
    var gameOver = false
    var movingPlayer = false
    var offset: CGPoint!
    
    func positionWithin(range: CGFloat, containerSize: CGFloat) -> CGFloat {
        let partA = CGFloat(arc4random_uniform(100)) / 100.0
        let partB = (containerSize * (1.0 - range) * 0.5)
        let partC = (containerSize * range + partB)
        
        return partA * partC
    }
    
    func distanceFrom(posA: CGPoint, posB: CGPoint) -> CGFloat {
        let aSquared = (posA.x - posB.x) * (posA.x - posB.x)
        let bSquared = (posA.y - posB.y) * (posA.y - posB.y)
        return sqrt(aSquared + bSquared)
    }
    
    func createPerson() {
        let person = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "infected-player.png")), color: .clear, size: CGSize(width: size.width * 0.05, height: size.width * 0.05))
        person.position = CGPoint(x: positionWithin(range: 0.8, containerSize: size.width), y: positionWithin(range: 0.8, containerSize: size.height))
        person.addCircle(radius: person.size.width * (0.5 + socialDistancingLength), edgeColor: .lightGray, filled: false)
        
        while distanceFrom(posA: person.position, posB: player.position) < person.size.width * socialDistancingLength * 5 {
            person.position = CGPoint(x: positionWithin(range: 0.8, containerSize: size.width), y: positionWithin(range: 0.8, containerSize: size.height))
        }
        
        addChild(person)
        people.append(person)
        
        person.physicsBody = SKPhysicsBody(circleOfRadius: person.size.width * (0.5 + socialDistancingLength))
        person.physicsBody?.affectedByGravity = false
        person.physicsBody?.categoryBitMask = Bitmasks.uninfectedPerson
        person.physicsBody?.contactTestBitMask = Bitmasks.enemy
        person.physicsBody?.friction = 0.0
        person.physicsBody?.angularDamping = 0.0
        person.physicsBody?.restitution = 1.1
        person.physicsBody?.allowsRotation = false
    }
    
    func infect(person: SKSpriteNode) {
        person.texture = SKTexture(image: #imageLiteral(resourceName: "virus.png"))
        person.physicsBody?.categoryBitMask = Bitmasks.enemy
        (person.children.first as? SKShapeNode)?.strokeColor = .red
    }
    
    func triggerGameOver() {
        gameOver = true
        
        player.texture = SKTexture(image: #imageLiteral(resourceName: "worried-player.png"))
        player.physicsBody?.categoryBitMask = Bitmasks.enemy
        (player.children.first as? SKShapeNode)?.strokeColor = .orange
        (player.children.first as? SKShapeNode)?.fillColor = .init(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.3)
        
        for person in people {
            person.physicsBody?.velocity = .zero
        }
        
        let gameOverLabel = SKLabelNode(text: "YOU'VE BEEN INFECTED!")
        gameOverLabel.fontSize = 70.0
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverLabel.fontColor = .white
        gameOverLabel.zPosition = 3
        
        addChild(gameOverLabel)
    }
    
    public override func didMove(to view: SKView) {
        socialDistancingLength /= 2
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        physicsWorld.contactDelegate = self
        
        // Background
        let bg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "background.jpg")))
        bg.setScale(1)
        bg.zPosition = -10
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bg)
        
        // Player
        player = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "uninfected-player.png")), color: .clear, size: CGSize(width: size.width * 0.05, height: size.width * 0.05))
        player.addCircle(radius: player.size.width * (0.5 + socialDistancingLength), edgeColor: .green, filled: true)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5 + socialDistancingLength))
        player.physicsBody?.isDynamic = false
        player.physicsBody?.categoryBitMask = Bitmasks.player
        player.physicsBody?.contactTestBitMask = Bitmasks.enemy
        
        for _ in 1...numberOfPeople {
            createPerson()
        }
        
        for person in people {
            person.physicsBody?.applyImpulse(CGVector(dx: CGFloat(arc4random_uniform(maxPersonSpeed)) - (CGFloat(maxPersonSpeed) * 0.5), dy: CGFloat(arc4random_uniform(maxPersonSpeed)) - (CGFloat(maxPersonSpeed) * 0.5)))
        }
        
        let infectedEnemy = people[Int(arc4random_uniform(UInt32(people.count)))]
        infectedEnemy.texture = SKTexture(image: #imageLiteral(resourceName: "virus.png"))
        infectedEnemy.physicsBody?.categoryBitMask = Bitmasks.enemy
        
        (infectedEnemy.children.first as? SKShapeNode)?.strokeColor = .red
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver else { return }
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let touchedNodes = nodes(at: touchLocation)
        
        for node in touchedNodes {
            if let sprite = node as? SKSpriteNode {
                if sprite == player {
                    movingPlayer = true
                    offset = CGPoint(x: touchLocation.x - player.position.x, y: touchLocation.y - player.position.y)
                }
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver && movingPlayer else { return }
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let newPlayerPosition = CGPoint(x: touchLocation.x - offset.x, y: touchLocation.y - offset.y)
        
        player.run(SKAction.move(to: newPlayerPosition, duration: 0.01))
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingPlayer = false
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == Bitmasks.uninfectedPerson && contact.bodyB.categoryBitMask == Bitmasks.enemy {
            infect(person: contact.bodyA.node as! SKSpriteNode)
        } else if contact.bodyB.categoryBitMask == Bitmasks.uninfectedPerson && contact.bodyA.categoryBitMask == Bitmasks.enemy {
            infect(person: contact.bodyB.node as! SKSpriteNode)
        } else if contact.bodyA.categoryBitMask == Bitmasks.player && contact.bodyB.categoryBitMask == Bitmasks.enemy {
            triggerGameOver()
        }
    }
}
