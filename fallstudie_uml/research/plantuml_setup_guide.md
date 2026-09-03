Skip to content

    [![DEV Community](https://media2.dev.to/dynamic/image/quality=100/https://dev-to-uploads.s3.amazonaws.com/uploads/logos/resized_logo_UQww2soKuUsjaOGNB38o.png)](/)

            [Powered by Algolia](https://www.algolia.com/developers/?utm_source=devto&utm_medium=referral)

            [Log in](https://dev.to/enter?signup_subforem=1)

          [Create account](https://dev.to/enter?signup_subforem=1&state=new-user)

## DEV Community

        ![](https://assets.dev.to/assets/heart-plus-active-9ea3b22f2bc311281db911d416166c5f430636e76b15cd5df6b3b841d830eefa.svg)

        Add reaction

      ![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg)

      Like

      ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg)

      Unicorn

      ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg)

      Exploding Head

      ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg)

      Raised Hands

      ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg)

      Fire

      Jump to Comments

      Save

      Boost

Pick as gem

              Copy link

            Copied to Clipboard

            Share to X
            [Share to LinkedIn](https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fdev.to%2Flimacon23%2Fenabling-plantuml-in-visual-studio-code-6ca&title=Enabling%20PlantUML%20in%20Visual%20Studio%20Code&summary=PlantUML%20is%20a%20component%20that%20allows%20you%20to%20quickly%20write%20the%20following%20diagrams%20in%20plain%20and%20simple...&source=DEV%20Community)
            [Share to Facebook](https://www.facebook.com/sharer.php?u=https%3A%2F%2Fdev.to%2Flimacon23%2Fenabling-plantuml-in-visual-studio-code-6ca)
            [Share to Mastodon](https://s2f.kytta.dev/?text=https%3A%2F%2Fdev.to%2Flimacon23%2Fenabling-plantuml-in-visual-studio-code-6ca)

          [Report Abuse](/report-abuse)

                      [![Rodel Talampas](https://media2.dev.to/dynamic/image/width=50,height=50,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F1007505%2F547b54e0-f5b1-4eec-b7c3-2e31fce315cd.jpg)](/limacon23)

                    [Rodel Talampas](/limacon23)

                        Posted on Jan 15, 2023

                        &bull;
                        Edited on Jun 6, 2023

    ![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg)

        ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg)

        ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg)

        ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg)

        ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg)

# Enabling PlantUML in Visual Studio Code

                      [#tutorial](/t/tutorial)
                      [#vscode](/t/vscode)
                      [#uml](/t/uml)
                      [#productivity](/t/productivity)

                [PlantUML](https://plantuml.com/) is a component that allows you to quickly write the following diagrams in plain and simple intuitive language - a.k.a. Diagram-As-Code.

- Sequence diagram

- Usecase diagram

- Class diagram

- Object diagram

- Component diagram

- Deployment diagram

There are many similar tools out there. `PlantUML` is free to use and was created using Java and GraphViz.  A simple way of using it is to download the [plantuml.jar](http://sourceforge.net/projects/plantuml/files/plantuml.jar/download) and run it to open PlantUML's [graphical user interface](https://plantuml.com/gui). There is no need to unpack or install anything.

Most developers use Visual Studio Code, why not install its plugin:

[![ ](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Facgkgcaytxno7s15mt4k.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Facgkgcaytxno7s15mt4k.png)

Browse the plugin and click install.  After installing the plugin, there is a need to install GraphViz binary. You can follow the link to install [it](https://graphviz.org/download/).  For mac users, easy to run `brew install graphviz`.

When all done, create a test file `test.puml`  and add the following code

```
@startuml Basic Sample
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

Person(admin, "Administrator")
System_Boundary(c1, "Sample System") {
    Container(web_app, "Web Application", "C#, ASP.NET Core 2.1 MVC", "Allows users to compare multiple Twitter timelines")
}
System(twitter, "Twitter")

Rel(admin, web_app, "Uses", "HTTPS")
Rel(web_app, twitter, "Gets tweets from", "HTTPS")
@enduml

```

Press `Option + D` in Mac or `Alt-D` for other OS's, should give the following output:

[![ ](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fvzsv7d3q1ly6303eux7n.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fvzsv7d3q1ly6303eux7n.png)

## Top comments (1)

          Subscribe

    ![pic](https://media2.dev.to/dynamic/image/width=256,height=,fit=scale-down,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8j7kvp660rqzt99zui8e.png)

        Personal
        Trusted User

      [Create template](/settings/response-templates)
      Templates let you quickly answer FAQs or store snippets for re-use.

      Submit
      Preview
      [Dismiss](/404.html)

    [![carloswm85 profile image](https://media2.dev.to/dynamic/image/width=50,height=50,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F634702%2F93550c1d-a61c-44d3-8dd8-de23e321fecc.jpg)](https://dev.to/carloswm85)

  [Carlos](https://dev.to/carloswm85)

      Carlos

  [![](https://media2.dev.to/dynamic/image/width=90,height=90,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F634702%2F93550c1d-a61c-44d3-8dd8-de23e321fecc.jpg)

      Carlos](/carloswm85)

  Follow

- Joined

          May 20, 2021

  &bull;

[Nov 19 '24](https://dev.to/limacon23/enabling-plantuml-in-visual-studio-code-6ca#comment-2jk29)

- [Copy link](https://dev.to/limacon23/enabling-plantuml-in-visual-studio-code-6ca#comment-2jk29)

-

- Hide

-

-

-

          Amazing. Thanks for the little tutorial.

I'd suggest anyone in Windows system to install graphviz by using the chocolaey command:

`choco install graphviz`

    2 likes

      Like

        Reply

  [Code of Conduct](/code-of-conduct)
  &bull;
  [Report abuse](/report-abuse)

        Are you sure you want to hide this comment? It will become hidden in your post, but will still be visible via the comment's permalink.

        Hide child comments as well

          Confirm

  For further actions, you may consider blocking this person and/or [reporting abuse](/report-abuse)

  [![](https://media2.dev.to/dynamic/image/width=90,height=90,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F1007505%2F547b54e0-f5b1-4eec-b7c3-2e31fce315cd.jpg)

      Rodel Talampas](/limacon23)

  Follow

    Engineering Manager / Solutions Architect - have been in the IT industry for 25+ years

- Location

            Sydney

- Education

              De La Salle Univeristy - Dasmarinas

- Work

              Engineering Manager / Solutions Architect

- Joined

          Jan 13, 2023

### More from [Rodel Talampas](/limacon23)

            [Singleton Connection with Transactions in MongoDB

                  #javascript
                  #tutorial
                  #programming
                  #node](/limacon23/singleton-connection-with-transactions-in-mongodb-1b5c)
            [Developer Setup for Mac

                  #beginners
                  #devs
                  #programming
                  #tutorial](/limacon23/developer-setup-for-mac-epc)

      [DEV Community](/) — A space to discuss and keep up software development and manage your software career

- [Home](/)

- [DEV Challenges](/challenges)

- [DEV++](/++)

- [Videos](/videos)

- [DEV Education Tracks](/deved)

- [DEV Help](/help)

- [Advertise on DEV](/advertise)

- [Organization Accounts](/organizations)

- [DEV Showcase](/showcase)

- [About](/about)

- [Contact](/contact)

- [Free Postgres Database](/free-postgres-database-tier)

- [DEV Shop](https://shop.forem.com/)

- [MLH](https://mlh.io/)

- [Code of Conduct](/code-of-conduct)

- [Privacy Policy](/privacy)

- [Terms of Use](/terms)

      Built on [Forem](https://www.forem.com) — the [open source](https://dev.to/t/opensource) software that powers [DEV](https://dev.to) and other inclusive communities.

      Made with love and [Ruby on Rails](https://dev.to/t/rails). DEV Community &copy; 2016 - 2026.

      ![DEV Community](https://media2.dev.to/dynamic/image/width=190,height=,fit=scale-down,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8j7kvp660rqzt99zui8e.png)

          We're a place where coders share, stay up-to-date and grow their careers.

      [Log in](https://dev.to/enter?signup_subforem=1)
      [Create account](https://dev.to/enter?signup_subforem=1&state=new-user)

    ![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg)
    ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg)
    ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg)
    ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg)
    ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg)