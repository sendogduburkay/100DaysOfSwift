import UIKit

//-------- STRONG CAPTURE
/* Özel bir şeyler istemediğimiz sürece Swift strongu kullanır. Bu closure içindeki kullanılan tüm external valueları yakaladığı anlamına geliyor. Ve asla yok olmadığından emin oluyor.
 sing() içindeki taylor sabiti normalde sing içinde çalışır ve işlev sona erdiğinde o da yok edilir. Ama closure içinde kullanıldığı için swift closure bir yerlerde var olduğu sürece bu değeri yok etmemek için çalışacak.
 Eğer swift taylor'un yok edilmesini sağlasaydı taylor.playSong() işlevsiz kalacaktı.
 
 */


class Singer{
    func playSong(){
        print("Shake Of It!!")
    }
}


func sing()->()->Void{
    let taylor = Singer()
    let singing = {
        taylor.playSong()
        return
    }
    return singing
    
}


let singFunc = sing()
singFunc()

//-------- WEAK CAPTURING
/*
 Zayıf yakalanan değerler kapatma tarafından canlı tutulmaz, bu nedenle yok edilebilir ve sıfır olarak ayarlanabilir.
 1'in bir sonucu olarak, zayıf yakalanan değerler Swift'de her zaman isteğe bağlıdır. Bu, aslında olmayabilirlerken var olduklarını varsaymanızı engeller.
 Kodu şimdi çalıştırırsanız, singFunction() işlevini çağırmanın artık hiçbir şey yazdırmadığını göreceksiniz. Bunun nedeni, Taylor'ın yalnızca sing() içinde var olmasıdır, çünkü döndürdüğü kapanış onu güçlü bir şekilde tutmaz.
 
 */

func sing2()->()->Void{
    let taylor = Singer()
    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }
    
    return singing
}

let singFunction = sing2()
singFunction()


var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()
let logger2 = logger1
logger2()
logger1()
logger2()

