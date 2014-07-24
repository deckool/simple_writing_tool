var h1s = document.getElementsByTagName("h1");
console.log(h1s);
for (var i = 0; i < h1s.length; i++) {
    var h1 = h1s[i];
//    h1.className = "MyClass";
    var h1Class = h1.className
    console.log(h1Class);
    var link = document.createElement('a');
    link.href = h1Class + ".html";
    link.innerHTML = h1Class;
    h1.appendChild(link);
//    h1.onclick = function(){
//    		window.location = h1.innerHTML + ".html";
         //     s[key].href(s[key].innerText);
//            return false;
//        };
}
var h3s = document.getElementsByTagName("h3");
for (var i = 0; i < h3s.length; i++) {
    var h3 = h3s[i];
    h3.className = "hash";
	data = h3.dataset;
    console.log(data.month);
    console.log(data.year);
    console.log(data.day);
    console.log(data.yearday);
//    h1.onclick = function(){
//    		window.location = h1.innerHTML + ".html";
         //     s[key].href(s[key].innerText);
//            return false;
        };
//}
//document.getElementById("MyElement").className = "MyClass";


var foot = document.querySelector('[id^="fnref:"]').id;
console.log(foot);