*******
Notejam
*******


====================
Infrastructure provisioning
====================

The infrastructure of this project will be provision via IaC, more specific by Terraform.
In this repository on the folder "terraform" is the code necessary to run. The order how the code should be run is the following:

* terraform/src/notejam/dv/rg
* terraform/src/notejam/dv/vnet
* terraform/src/notejam/dv/loganalytics
* terraform/src/notejam/dv/keyvault
* terraform/src/notejam/dv/sqlserver
* terraform/src/notejam/dv/appgw
* terraform/src/notejam/dv/scaleset (change the argument agw_pool_id and image_id to the id of your application gateway and the Azure Image of notejam(you have to manual create it) )
* terraform/src/notejam/dv/front_door (change variables to have application gateway new ip)



====================
Supported frameworks
====================

**Python**


* `Flask <https://github.com/zilak/notejam/tree/master/flask>`__


====================
Application overview
====================

Notejam is a web application which offers user to sign up/in/out and create/view/edit/delete notes.
Notes are grouped in pads.

**Screenshots**

.. image:: https://github.com/komarserjio/notejam/blob/master/html/screenshots/1p.png
    :alt: Sign in
    :width: 400
    :align: center
    :target: https://github.com/komarserjio/notejam/tree/master/screenshots.rst

.. image:: https://github.com/komarserjio/notejam/blob/master/html/screenshots/2p.png
    :alt: All notes
    :width: 400
    :align: center
    :target: https://github.com/komarserjio/notejam/tree/master/screenshots.rst

.. image:: https://github.com/komarserjio/notejam/blob/master/html/screenshots/3p.png
    :alt: New note
    :width: 400
    :align: center
    :target: https://github.com/komarserjio/notejam/tree/master/screenshots.rst

See `more screenshots <https://github.com/komarserjio/notejam/tree/master/screenshots.rst>`_
for look and feel.

See `detailed overview <https://github.com/komarserjio/notejam/blob/master/contribute.rst#application-requirements>`_.

Typical application covers following topics:

* Request/Response handling
* Routing
* Templates
* Configuration
* Authentication
* Forms
* Error handling
* Database/ORM
* Mailing
* Functional/unit testing

=============
How to launch
=============

All implementations are SQLite based and quickly launchable by built-in web servers.
Each implementation has instruction describing easy steps to install environment, launch and run tests.


