//
//  ViewController.swift
//  Final Project~ Connect4
//
//  Created by Kameko Duplessy on 5/10/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnImage: UIImageView!
    
    var redScore = 0
    var yellowScore = 0
    var redWins = 0
      var yellowWins = 0
      var roundsPlayed = 0
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        resetBoard()
        setCellWidthHeight()
    }
    
    func setCellWidthHeight()
    {
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }
    
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return board[section].count
    }
    
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
        
        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()
        return cell
    }
    
    
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItem(column)
        {
            if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell
            {
                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
                
                if victoryAchieved()
                {
                    if yellowTurn()
                    {
                        yellowScore += 1
                    }
                    if redTurn()
                    {
                        redScore += 1
                    }
                    resultAlert(currentTurnVictoryMessage())
                }
                
                if boardIsFull()
                {
                    resultAlert("Draw")
                }
                
                
                toggleTurn(turnImage)
            }
        }
    }
    func resultAlert(_ title: String)
    {
        let message = "\nRed: " + String(redScore) + "\n\nYellow: " + String(yellowScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {
            [self] (_) in
            resetBoard()
            self.resetCells()
        }))
        self.present(ac, animated: true)
    }
    
    func resetCells()
    {
        for cell in collectionView.visibleCells as! [BoardCell]
        {
            cell.image.tintColor = .white
        }
    }


      func startNewGame() {
          // Reset the board and start a new game
          if roundsPlayed < 4 {
              // Initialize game setup
              roundsPlayed += 1
          } else {
              concludeGame()
          }
      }

      func playerDidWin(player: String) {
          if player == "Red" {
              redWins += 1
          } else {
              yellowWins += 1
          }
          startNewGame()
      }


      func showAlertWith(message: String) {
          let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
      }
    func concludeGame() {
       
        var message = ""
        if redWins > yellowWins {
            message = "Red is the ultimate winner!"
        } else if yellowWins > redWins {
            message = "Yellow is the ultimate winner!"
        } else {
            message = "The game is a tie!"
        }

        let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
            self?.resetGame()
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: .cancel, handler: { _ in
            
        }))
        present(alert, animated: true, completion: nil)
    }

    func resetGame() {
       
        redWins = 0
        yellowWins = 0
        roundsPlayed = 0
        startNewGame()
    }


}

