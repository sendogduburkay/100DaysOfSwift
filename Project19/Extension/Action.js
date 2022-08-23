/*
 İki işlev vardır: run() ve finalize(). Birincisi, uzantınız çalıştırılmadan önce, diğeri ise daha sonra çağrılır.
 */


/* JavaScript oldukça bulanık bir dildir, bu yüzden buna boş bakıyor olabilirsiniz. Düz bir İngilizce ile ifade edecek olsaydım, bunun anlamı "iOS'a JavaScript'in ön işlemeyi bitirdiğini söyle ve bu data dictionary'i extentiona ver." Gönderilen veriler, "URL" ve "title" anahtarlarına sahiptir ve değerler, sayfa URL'si ve sayfa başlığıdır.*/

var Action = function() {};

Action.prototype = {

run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
},

finalize: function(parameters) {

    var customJavaScript = parameters["customJavaScript"];
    eval(customJavaScript);
}

};

var ExtensionPreprocessingJS = new Action
