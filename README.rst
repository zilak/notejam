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
* terraform/src/notejam/dv/scaleset
* terraform/src/notejam/dv/front_door (change variables to have application gateway new ip)

====================
Supported frameworks
====================

**Python**


* `Django <https://github.com/komarserjio/notejam/tree/master/django>`_
* `Flask <https://github.com/komarserjio/notejam/tree/master/flask>`_
* `Pyramid <https://github.com/komarserjio/notejam/tree/master/pyramid>`_

**PHP**

* `Laravel <https://github.com/komarserjio/notejam/tree/master/laravel>`_
* `Yii <https://github.com/komarserjio/notejam/tree/master/yii>`_
* `CakePHP <https://github.com/komarserjio/notejam/tree/master/cakephp>`_
* `Nette <https://github.com/komarserjio/notejam/tree/master/nette/native_db>`_ / `Nette + Doctrine <https://github.com/komarserjio/notejam/tree/master/nette/doctrine>`_
* `Symfony <https://github.com/komarserjio/notejam/tree/master/symfony>`_

**Ruby**

* `Padrino <https://github.com/komarserjio/notejam/tree/master/padrino>`_
* `Ruby on Rails <https://github.com/komarserjio/notejam/tree/master/rubyonrails>`_

**Java**

* `Spring <https://github.com/komarserjio/notejam/tree/master/spring>`_

**Javascript (node.js)**

* `Express <https://github.com/komarserjio/notejam/tree/master/express>`_


In progress
-----------

**Scala**

* Play

**Clojure**

* Compojure

... and more frameworks are coming soon.

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

============
Contribution
============

Contribution is more than welcome!
Contribute improvements to existing applications to help them follow best practices
or provide new implementation for unsupported framework.


**Do you want to improve one of the existing implementations?**

Each implementation has its own README with contribution details.

**Do you want to add new framework?**

Read `contribution guide <https://github.com/komarserjio/notejam/blob/master/contribute.rst>`_ for details.

========
Contacts
========

* Twitter: `@komarserjio <https://twitter.com/komarserjio>`_
* Email: komarserjio <at> gmail.com

=======
License
=======

MIT © Serhii Komar.

See `license <https://github.com/komarserjio/notejam/blob/master/license.rst>`_.
