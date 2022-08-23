//
//  ViewController.swift
//  Project25
//
//  Created by Muhammed Burkay Şendoğdu on 3.08.2022.
//

/*
 MultipeerConnectivity 4 tane class gerektirir;
 1) MCSession: tüm multipeerConnectivity'nin hepsini yöneten yönetici sınıf.
 2) MCPeerID: Session'daki her userin unique idsi. ( Session = Oturum )
 3)MCAdvertiserAssistant: Bir session oluştururken, diğerlerine varlığımızı söylerken ve davetleri işlerken kullanılır.
 4) MCBrowserViewController: Session ararken, yakındaki kullanıcıları gösterirken ve katılmalarına izin verirken kullanılır.
 
 iOS'taki tüm MultipeerConnectivityler, hizmetimizi benzersiz şekilde tanımlayan 15 basamaklı bir string service type bildirir. Bu service type, kullanıcılarınızın yalnızca aynı uygulamanın diğer kullanıcılarını görmesini sağlamak için, hem MCAdvertiserAssistan hem de MCBrowserViewController tarafından kullanılır.
 İkisi de MCSession'dan referans istiyor ki bizim yerimize bağlantılarla ilgilenebilsin.
 
 MCSessionDelegate => 5 tane func getirir. Biz bu uygulamada aktif olarak 2 tanesini (didChange, didReceive) kullandık.
 MCBrowserViewControllerDelegate => 2 tane func getirir. İkisini de dismiss işlemiyle sonlandırdık. Ekstra bir iş yapmadık.
 
 */

import MultipeerConnectivity
import UIKit


class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,MCSessionDelegate,MCBrowserViewControllerDelegate {
    
    var images = [UIImage]()
    
    var peerID =  MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdversiterAssistan: MCAdvertiserAssistant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Selfie Share"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required) /* peeID aktarılan verilerin güvende tutulmasını sağlamak için .required şifreleme seçeneğiyle birlikte oturumu oluşturmak için kullanılır.*/
        mcSession?.delegate = self
    }
    
    @objc func importPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    @objc func showConnectionPrompt(){
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    
    func startHosting(action: UIAlertAction){
        guard let mcSession = mcSession else {
            return
        }
        mcAdversiterAssistan = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdversiterAssistan?.start()
    }
    
    
    func joinSession(action: UIAlertAction){
        guard let mcSession = mcSession else {
            return
        }
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser,animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        if let imageview = cell.viewWithTag(1000) as? UIImageView{ /* tag ile imageView'i buluyoruz.*/
            imageview.image = images[indexPath.item]
        }
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true)
        
        images.insert(image, at: 0) /* */
        collectionView.reloadData()

        guard let mcSession = mcSession else {
            return
        }
        if mcSession.connectedPeers.count > 0{ /* Peers dediği katılan bir aygıtın olup olmadığıdır. */
            if let imageData = image.pngData(){
                do{
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable) /*didReceive'de işlenecek datayı hazırlıyoruz*/
                }
                catch{
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac,animated: true)
                }
            }
        }

    }
    

    /* Bir kullanıcı oturuma bağlandığında ya da oturumumuzla bağlantısını kestiğinde çağırılan method. Bu bilgiyi projede kullanmayacağız, ancak bazı teşhislerin çıktısını alarak nasıl kullanılabileceğini size göstermek istiyorum. Bu, hata ayıklama için yararlıdır, çünkü bu mesajları görmek ve kodunuzun çalıştığını bilmek için Xcode'un hata ayıklama konsoluna bakabileceğiniz anlamına gelir. */
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state{
        case .connected: print("Connected: \(peerID.displayName)")
        case .connecting: print("Connecting: \(peerID.displayName)")
        case .notConnected: print("Not connected: \(peerID.displayName)")
        @unknown default: print("Unknown state received: \(peerID.displayName)")
        }
    }
    /* Data gönderildiyse yapılacak işlemleri yazdığımız yer. UI işlemi yapacağımız için main'e aldık aksi takdirde problem çıkabiliyor. ( Asla UI işlemlerini main dışında yapma) */
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self] in
            if let image = UIImage(data: data){
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }

    
    
    


}

