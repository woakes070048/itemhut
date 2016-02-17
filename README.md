#Item Hut

Item Hut is a free and open-source marketing, ERP, CRM, and channel-management tool mainly focusing on B2B.

###Demo Site

www.itemhut.com

###Current Status
Under active development. To keep things progressing along smoothly, Item Hut is going to begin as an inventory system.

####Inventory System Setup
PostgreSQL 9.5

Python packages:
*Python3
*Python Bottle
*bcrypt
*hmac
*Psycopg2

clone to /itemhut:
```bash
$ git clone https://github.com/dt1/item-hut.git
```

setup the database
```bash
$su - postgres
$createdb itemhut
$psql -d itemhut -U postgres -f /itemhut/build_database/products/products.sql 
$psql -d itemhut -U postgres -f /itemhut/build_database/warehouse/warhouse.sql 
$psql -d itemhut -U postgres -f /itemhut/build_database/warehouse/populate-warhouse.sql 
```

run bottle:
```
$ python3 /itemhut/btl/home.py
```

####Full System Setup
(same as Inventory System Setup)

Python eBay SDK:
https://github.com/timotheus/ebaysdk-python

setup the yaml files

By default, the eBay SDK does not function with Python3. On Fedora:

```bash
[your-editor] /usr/lib/python3.4/site-packages/ebaysdk-2.1.2-py3.4.egg/ebaysdk/response.py
line 65:
change:
if i is None or isinstance(i, str) or isinstance(i, unicode):
to:
if i is None or isinstance(i, str): #or isinstance(i, unicode):
```


(to be continued...)

###Why?

In various professional roles, I have discovered that the marketing, ERP, CRM, and channel-management tools (all closed source) have never met the needs and expectations of the companies I have worked for. In response to these short-comings, I have always developed in-house databases and programs to further manage the complexity of the jobs I had to do.

This program can serve as a cheat-sheet for those who find themselves in my position and don't know where to start, or it can serve as a foundation for those who want to build their own solutions. This program is fundamentally different because it is created by someone who has found himself in the mud.

Item Hut makes a few assumptions that do not reflect reality: in particular, it assumes you have beautiful and clean data, ignoring the mantra "Data is Messy." Yes, data is, and always will be, messy, even with the best of plans. I am not able to know *how* your data is messy. With that in mind, Item Hut attempts to be as flexible as possible, and should be easy to modify. The databaase schema does provide lookup tables that represent some of the more common cases.

###Expected Features
* B2B Customer Management
* Inventory Management
* Basic Warehouse Management
* Intensive marketing analysis
* "Feature Complete" Ebay and Amazon API integration.
* Flat File creation
* Excellent Documentation (mostly found in the source code)
* etc.

###Implementation considerations:
Since I am not able to test half.com at this time, I have no plans to implement the these features. 

The code assumes you'd like to use a .yaml file to keep your credentials. I do not include the .yaml file. You can find the yaml file [here](https://github.com/timotheus/ebaysdk-python/blob/master/ebay.yaml). Place it in /Item Hut/pyebay/ebay.yaml.

###Current Status
Python is currently talking to PostgreSQL. The only feature that works at this time is insertion into PostgreSQL and a bit of processing.

Amazon database is fully comnplete.


###Components

* PostgreSQL 9.4 (Will upgrade to 9.5 when it released)
* PL/pgSQL
* C
* Python 3.4
* bottle (web ui)

###Setup

*BeautifulSoup*
$ pip install beautifulsoup4

*psycopg2*
Per the [documentation](http://initd.org/psycopg/docs/install.html), please install it via your package manager of choice. For Fedora:
$ dnf install python-psycopg2

*create the database*
$ su - postgres
$ createdb Item Hut

###Where is the GUI?
There are no plans to create a GUI component.

####Permissions and Licensing

While I am unable to enforce this, I am a strong believer that a customer's data is their data. I ask that, if you use this program, you allow your customers to own all the data they have supplied to you either through their own input or through the APIs.

While I do not require this, I am interested in spreading the word about this program. If you wish to use this program, please offer attribution.

Released under the [Mozilla Public License
Version 2.0](http://www.mozilla.org/MPL/2.0/)
